#' Install conda if it's missing
#'
#' @param conda_path Path to conda executable.
#' @param verbose Print messages.
#'
#' @family conda
#' @export
#' @importFrom reticulate conda_version conda_install
install_conda <- function(conda_path = "auto",
                          verbose = FALSE) {
    conda_version <- NULL
    try({
        conda_version <- reticulate::conda_version(conda = conda_path)
    })
    if (is.null(conda_version)) {
        messager("+ CONDA:: conda not detected. Installing with reticulate...",
            v = verbose
        )
        reticulate::conda_install()
    } else {
        messager("+ CONDA:: conda already installed.", v = verbose)
    }
}
