#' List conda envs
#' 
#' List all available conda environments.
#' @param conda_env [Optional] A specific conda environment to search for.
#' @inheritParams find_conda
#' @inheritParams reticulate::conda_list
#' @export
#' @importFrom data.table :=
list_envs <- function(conda="auto",
                      conda_env=NULL,
                      use_basilisk=TRUE){
    python <- name <- dir <- NULL;
    conda_x <- find_conda(conda = conda,
                          use_basilisk = use_basilisk)
    # envs <- basilisk::listPackages(env = conda_env)
    envs <- reticulate::conda_list(conda = conda_x)
    envs <- data.table::data.table(envs)
    envs[,dir:=dirname(dirname(python)),]
    #### Search for matching env ####
    if(!is.null(conda_env)){
        envs <- envs[name %in% conda_env,]
    } 
    if(nrow(envs)==0) {
        messager("Warning: Could not identify any conda_env",
                 "matching existing conda environments.") 
    } 
    return(envs)
}
