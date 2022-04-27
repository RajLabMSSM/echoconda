find_packages_paths <- function(conda_env,
                                pkgs,
                                types=c("r","python","binary"),
                                robust=FALSE,
                                verbose=TRUE){ 
    # echoverseTemplate:::source_all(packages = "dplyr")
    # echoverseTemplate:::args2vars(find_packages_paths); conda_env="echoR"
    
    #### Reset path col ####
    if("path" %in% colnames(pkgs)) {
        if(all(!is.na(pkgs$path))){
            return(pkgs)
        } else{
            pkgs$path <- NULL
        }
    } 
    messager("Adding paths to package paths.",v=verbose)
    packages <- unique(pkgs$package)
    #### Find executables #####
    execs <- find_executables(packages=packages, 
                              conda_env=conda_env,
                              types=types,
                              robust=robust,
                              verbose=FALSE)
    #### If no executables found ####
    ## simply stop early and return pkgs data.table
    if(length(execs)==0) return(pkgs)
    #### Add path(s) for each package in pkgs data.table ####
    pkg_paths <- lapply(pkgs$package, function(pkg){ 
        execs_select <- 
            execs[
                grepl(pattern = paste0("^",gsub("-",".*.",
                                        gsub(x =  pkg,
                                             pattern = c("^r-|^bioconductor-"),
                                             replacement = "")
                                        )
                               ),
                        x = basename(execs),
                      ignore.case = TRUE)
                ]
        ## Do some extra checks for R because too many other packages start 
        ## with that letter.
        if(tolower(pkg)=="r") {
            execs_select <- execs_select[tolower(basename(execs_select))=="r"]
        }
        ### Sorting  will naturally put bin towards the top
        ### which tend to be real executables.
        execs_select <- sort(execs_select) 
        return(execs_select)
    }) %>% `names<-`(pkgs$package)
    dat <- data.table::data.table(package=names(pkg_paths),
                                  path=pkg_paths) 
    data.table::setkeyv(dat,"package")
    ##### Get r packages #####   
    # dat["trim-galore"]
    # dat["r-dplyr"]
    # dat["pandas"]
    # #### Merge with main package metadata #### 
    pkgs_merge <- data.table::merge.data.table(x = pkgs,
                                               y = dat,
                                               by = "package",
                                               all.x=TRUE)   
    data.table::setkeyv(pkgs_merge,"package")
    messager("Identified paths for",
             formatC(sum(unlist(lapply(pkgs_merge$path,length))>0),
                     big.mark = ","),"/",
             formatC(nrow(pkgs_merge), big.mark = ","),
             "package(s).",v=verbose
    )
    return(pkgs_merge)
}
