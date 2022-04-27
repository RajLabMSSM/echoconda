#' Remove conda environment
#' 
#' Actually remove conda environments,
#'  unlike \code{reticulate}::\link[reticulate]{conda_remove}.
#' 
#' @param conda_env Name of the conda environment. 
#' @param verbose Print messages. 
#' 
#' @inheritParams find_conda
#' @inheritParams reticulate::conda_list
#' @export
#' @importFrom basilisk.utils deactivateEnvironment
#' @importFrom reticulate conda_remove
remove_env <- function(conda_env, 
                       conda="auto",
                       method=c("basilisk","reticulate"),
                       verbose=TRUE){
    name <- NULL; 
    envs <- list_envs(conda_env = conda_env,
                      conda = conda, 
                      method = method) 
    if(nrow(envs)>0){
        conda_x <- find_conda(conda = conda, 
                              method = method)
        #### Remove multiple ways ####
        for(env in envs){
            messager("Removing env:",env,v=verbose)
            basilisk.utils::deactivateEnvironment(listing = env)
            tryCatch({
                reticulate::conda_remove(envname = env,
                                         conda = conda_x)
            }, error = function(e){message(e)})
            unlink(x = dirname(dirname(subset(envs, name==env)$python)),
                   recursive = TRUE, 
                   force = TRUE)
        }
    } else {
        messager("Warning: conda_env did not match any existing envs.",
                 v=verbose)
    }
    return(envs)
}
