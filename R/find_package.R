#' Find package executable
#'
#' @param package Name of a package within a conda env.
#' @param conda_env Conda environment name.
#' @param verbose Print messages.
#'
#' @family CONDA
#' @examples
#' # Tabix
#' tabix <- find_package(package = "tabix", conda_env = "echoR")
#' tabix <- find_package(package = "tabix", conda_env = NULL)
#' # bgzip
#' bgzip <- find_package(package = "bgzip", conda_env = "echoR")
#' bgzip <- find_package(package = "bgzip", conda_env = NULL)
#' @export
find_package <- function(package,
                         conda_env = "echoR",
                         verbose = TRUE) {
    python <- find_python_path(
        conda_env = conda_env,
        verbose = verbose
    )
    packages <- list.files(dirname(python), full.names = TRUE)
    if (package %in% basename(packages)) {
        messager("+ CONDA:: Identified", package,
            "executable in", conda_env, "env.",
            v = verbose
        )
        pkg_path <- packages[endsWith(packages, package)]
    } else {
        messager("CONDA:: Could not identify", package,
            "executable in", conda_env, "env.",
            "Defaulting to generic", paste0("'", package, "'"),
            "command",
            v = verbose
        )
        pkg_path <- package
    }
    return(pkg_path)
}
