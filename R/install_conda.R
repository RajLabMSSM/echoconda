#' Install conda if it's missing
#'
#' @param conda_path Path to conda executable.
#' @param verbose Print messages.
#'
#' @family conda
#' @export
#' @importFrom reticulate conda_version install_miniconda
install_conda <- function(conda_path = "auto",
                          verbose = TRUE) {
    conda_version <- NULL
    try({
        conda_version <- reticulate::conda_version(conda = conda_path)
    })
    if (is.null(conda_version)) {
        messager("echoconda:: conda not detected. Installing with reticulate...",
            v = verbose
        )
        reticulate::install_miniconda()
    } else {
        messager("echoconda:: conda already installed.", v = verbose)
    }
}
