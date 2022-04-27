find_executables <- function(packages=NULL,
                             conda_env,
                             types=c("r","python","binary"),
                             robust=TRUE,
                             verbose=TRUE){
    #### Conda env path ####
    python <- find_python_path(conda_env = conda_env,
                               verbose = verbose)
    pylib <- find_python_library(python = python)
    env_path <- dirname(dirname(python))
    if(conda_env=="base"){
        ## Have to limit search or else it will look in all other envs too
        env_path <- file.path(env_path,"*bin")
    }
    types <- tolower(types) 
    #### Robust method ####
    if(isTRUE(robust)){   
        ##### First, find all executables in the conda env #####
        ## They seem to be distributed across different locations, not just bin/
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
    #### Faster, less robust method ####
    } else {  
        execs <- list.files(
            path = dirname(python),
            pattern = if(length(packages)>0){
                paste(packages,collapse = "|")
            } else {NULL},
            full.names = TRUE,
            ignore.case = TRUE)
        #### Omit directories ####
        execs <- execs[!dir.exists(execs)]
    }
    messager(length(execs),"executable(s) found.",v=verbose)
    #### Return ####
    return(execs)
}
