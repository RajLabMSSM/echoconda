find_packages_paths <- function(conda_env,
                                pkgs_select, 
                                verbose=TRUE){ 
    
    python <- find_python_path(conda_env = conda_env,
                               verbose = verbose)
    pylib <- find_python_library(python = python)
    ##### First, find all executables in the conda env #####
    ## They seem to be distributed across different locations, not just bin/
    execs <- c(
        ### Binaries 
        system(paste("find",dirname(dirname(python)),
                     "-perm +111 -type f -or -type l"), 
               intern = TRUE),
        ### R package folders 
        list.files(file.path(dirname(dirname(python)),"lib/R/library"),
                   full.names = TRUE,
                   ignore.case = TRUE),
        ### Python package folders 
        list.files(pylib,
                   full.names = TRUE,
                   ignore.case = TRUE)
    )
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
