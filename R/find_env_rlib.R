#' Find the R library for a specific env
#'
#' @param conda_env Conda environment name.
#' @param suffix Suffixes to use when searching for R library.
#'
#' @family conda
#' @export
find_env_rlib <- function(conda_env = "echoR",
                          suffix = "lib/R/library/") {
    conda_env <- check_env(conda_env = conda_env)
    conda_path <- dirname(dirname(find_python_path(conda_env = conda_env)))
    if (conda_path == ".") {
        env_Rlib <- .libPaths()
        message("No conda_env='", conda_env, "' not found.")
        message("Using ", env_Rlib, " instead.")
    } else {
        env_Rlib <- file.path(conda_path, suffix)
    }
    return(env_Rlib)
}
