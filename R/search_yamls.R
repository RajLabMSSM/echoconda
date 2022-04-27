search_yamls <- function(conda_env,
                         show_contents = TRUE,
                         verbose = TRUE){
    # Can take a yaml path too
    conda_env <- name_from_yaml(yaml_path = conda_env,
                                verbose = FALSE)
    yamls <- list_yamls(verbose = FALSE)
    if(conda_env %in% yamls$conda_env){
        ce <- conda_env 
        #### Check OS ####
        if(get_os()=="Windows" && conda_env=="echoR"){
            messager("Windows OS detected:",
                     "using modified yaml file that omits packages",
                     "not available on Windows.", v=verbose)
            yaml_path <- system.file(package = "echoconda",
                                     "conda/echoR_windows.yml")
        } else {
            yaml_path <- subset(yamls, (conda_env==ce) &
                                    (!endsWith(yaml_path,"windows.yml"))
                                )$yaml_path[1]
        }
        messager("Identified yaml file stored in echoconda.",v=verbose)
        if(show_contents){
            messager("Yaml contents:\n",v=verbose)
            cat(paste(readLines(yaml_path),collapse = "\n"))
            message("")
        } 
    } else {yaml_path <- NULL}
    return(yaml_path)
}
