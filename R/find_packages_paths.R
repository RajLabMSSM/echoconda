find_packages_paths <- function(conda_env,
                                pkgs_select,
                                types=c("r","python","binary"),
                                verbose=TRUE){ 
    
    python <- find_python_path(conda_env = conda_env,
                               verbose = verbose)
    pylib <- find_python_library(python = python)
    env_path <- dirname(dirname(python))
    if(conda_env=="base"){
        ## Have to limit search or else it will look in all other envs too
        env_path <- file.path(env_path,"*bin")
    }
    ##### First, find all executables in the conda env #####
    ## They seem to be distributed across different locations, not just bin/
    types <- tolower(types)
    execs <- c(
        ### Binaries 
        if("binary" %in% types){
            system(paste("find",env_path,
                         if(get_os()=="Mac"){
                             "-perm +111 -type f -or -type l"
                         } else {
                             "-executable"
                         } 
                         ), 
                   intern = TRUE)
        } else{NULL},
        ### R package folders 
        if("r" %in% types){
            list.files(file.path(env_path,"lib/R/library"),
                       full.names = TRUE,
                       ignore.case = TRUE)
        } else {NULL},
        ### Python package folders 
        if("python" %in% types){
            list.files(pylib,
                       full.names = TRUE,
                       ignore.case = TRUE)
        } else {NULL}
    )
    if(length(execs)==0) return(pkgs_select)
    # #### Find package paths ####
    pkg_paths <- lapply(pkgs_select$package, function(pkg){
        execs[grepl(paste0("^",gsub("-",".*.",
                                    gsub(x =  pkg,
                                         pattern = c("^r-|^bioconductor-"),
                                         replacement = "")
                                    )
                           ),
                    basename(execs))]
    }) %>% `names<-`(pkgs_select$package)
    dat <- data.table::data.table(package=names(pkg_paths),
                                  path=pkg_paths) 
    ##### Get r packages #####  
    data.table::setkeyv(dat,"package")
    # dat["trim-galore"]
    # dat["r-dplyr"]
    # dat["pandas"]
    # #### Merge with main package metadata #### 
    pkgs_merge <- data.table::merge.data.table(x = pkgs_select,
                                               y = dat,
                                               by = "package",
                                               all.x=TRUE)   
    data.table::setkeyv(pkgs_merge,"package")
    messager("Identified paths for",
             formatC(sum(unlist(lapply(pkgs_merge$path,length))>0),
                     big.mark = ","),"/",
             formatC(nrow(pkgs_merge), big.mark = ","),
             "packages.",v=verbose
    )
    return(pkgs_merge)
}