#' Activate conda env
#'
#' \link[reticulate]{use_condaenv} often 
#' \href{https://github.com/rstudio/reticulate/issues/292}{
#' doesn't work in practice}, especially within RStudio.
#' \link[echoconda]{activate_env} ensures the env is actually activated 
#' and used.
#' 
#' @param conda_env Conda environment to use.
#' @param verbose Print messages.
#' @source \href{https://github.com/rstudio/reticulate/issues/1147}{GH Issues}
#' @source \href{https://github.com/rstudio/reticulate/issues/1044}{GH Issues}
#' @source \href{https://github.com/rstudio/reticulate/issues/292}{GH Issues}
#' @family conda
#' 
#' @export
#' @importFrom basilisk.utils activateEnvironment
#' @importFrom reticulate conda_list use_condaenv use_python conda_list
#' @examples
#' echoconda::activate_env(conda_env = "echoR")
activate_env <- function(method = c("basilisk","reticulate"),
                         conda_env = "echoR_mini",
                         verbose = TRUE) { 
    
    conda_env <- conda_env[1]
    method <- tolower(method)[1] 
    #### check if env exists ####
    if (!env_exists(conda_env = conda_env, 
                    method = method)) { 
        messager("WARNING:", paste0("'", conda_env, "'"),
                 "conda environment not found. Using default 'base' instead.",
                 v = verbose)
        conda_env <- "base"
    }
    #### Activate env ####
    if(method=="basilisk"){
        activate_env_basilisk(conda_env = conda_env,
                              verbose = verbose)
    } else if(method=="reticulate"){
        activate_env_reticulate(conda_env = conda_env,
                                verbose = verbose)
    } 
    conda_env <- check_env(conda_env)
    return(conda_env)
}
