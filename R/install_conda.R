#' Install conda if it's missing
#'
#' @param conda_path Path to conda executable.
#' @param verbose Print messages.
#' @param ... Additional arguments to be passed to 
#' \link[reticulate]{install_miniconda}.
#'
#' @source 
#' \href{https://github.com/rstudio/reticulate/issues/1055}{
#' reticulate GitHub Issue.}
#' \href{https://github.com/conda/conda/issues/5388}{
#' conda GitHub Issue.}
#' @family conda
#' @export
#' @importFrom reticulate conda_version install_miniconda
install_conda <- function(conda_path = "auto",
                          verbose = TRUE,
                          ...) {
    conda_version <- NULL
    try({
        conda_version <- reticulate::conda_version(conda = conda_path)
    })
    if (is.null(conda_version)) {
        messager("echoconda:: Conda not detected.",
                 "Installing with reticulate.",
            v = verbose
        )
        reticulate::install_miniconda(...)
    } else {
        messager("echoconda:: Conda already installed.", v = verbose)
    }
}
