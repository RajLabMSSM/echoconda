#' Check whether a conda env exists
#'
#' @param env_name Name of the conda environment.
#' @param conda Path to conda executable.
#'
#' @examples
#' does_exist <- env_exists(env_name = "echoR")
#' @export
#' @importFrom reticulate conda_list
env_exists <- function(env_name,
                       conda = "auto") {
    envs <- reticulate::conda_list(conda = conda)
    does_exist <- env_name %in% envs$name
    return(does_exist)
}
