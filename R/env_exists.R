#' Check whether a conda env exists
#'
#' @param conda_env Name of the conda environment.
#' @param conda Path to conda executable.
#'
#' @examples
#' does_exist <- env_exists(conda_env = "echoR")
#' @export
#' @importFrom reticulate conda_list
env_exists <- function(conda_env,
                       conda = "auto") {
    if(is.null(conda_env)) return(FALSE)
    envs <- reticulate::conda_list(conda = conda)
    does_exist <- conda_env %in% envs$name
    return(does_exist)
}
