#' Check whether a conda env exists
#'
#' An extension of the internal function
#'  \code{reticulate:::condaenv_exists()}. 
#' 
#' @source \url{https://github.com/rstudio/reticulate/blob/577acd2dfd43b48720037eb0851f20e377dbb802/R/conda.R#L494} 
#'
#' @param conda_env Name of the conda environment.
#' @param conda Path to conda executable.
#' @inheritParams find_conda
#' 
#' @examples
#' does_exist <- env_exists(conda_env = "echoR")
#' @export
#' @importFrom reticulate conda_python conda_binary
env_exists <- function(conda_env = NULL,
                       conda = "auto",
                       method = c("basilisk","reticulate")) { 
    
    conda_env <- conda_env[1]
    #### Make sure conda_env is not NULL ####
    if(is.null(conda_env)) return(FALSE)
    envs <- list_envs(conda = conda, 
                      conda_env = conda_env,
                      method = method)
    does_exist <- nrow(envs)>0
    return(does_exist)
}
