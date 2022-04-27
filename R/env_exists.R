#' Check whether a conda env exists
#'
#' An extension of the internal function
#'  \code{reticulate:::condaenv_exists()}. 
#' 
#' @source \url{https://github.com/rstudio/reticulate/blob/577acd2dfd43b48720037eb0851f20e377dbb802/R/conda.R#L494} 
#'
#' @param conda_env Name of the conda environment.
#' @param conda Path to conda executable.
#'
#' @examples
#' does_exist <- env_exists(conda_env = "echoR")
#' @export
#' @importFrom reticulate conda_python conda_binary
env_exists <- function(conda_env = NULL,
                       conda = "auto") { 
    
    #### Make sure conda_env is not NULL ####
    if(is.null(conda_env)) return(FALSE)
    envs <- list_envs(conda = conda)
    does_exist <- conda_env %in% envs$name
    return(does_exist)
    # #### Check that conda is installed ####
    # condabin <- tryCatch(reticulate::conda_binary(conda = conda),
    #                      error = identity)
    # if (inherits(condabin, "error")) return(FALSE) 
    # #### Check that the environment exists #### 
    # python <- tryCatch(reticulate::conda_python(envname = conda_env,
    #                                             conda = conda),
    #                    error = identity)
    # if (inherits(python, "error")) return(FALSE) 
    # #### Validate the Python binary exists ####
    # return(file.exists(python))  
}
