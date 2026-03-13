#' Install conda: basilisk
#'
#' Install conda if it has not already been installed.
#' @param verbose Print messages.
#'
#' @keywords internal
#' @importFrom basilisk.utils download defaultCacheDirectory
install_conda_basilisk <- function(verbose=TRUE){
    # Sys.setenv("BASILISK_USE_SYSTEM_DIR"=1)
    cache_dir <- basilisk.utils::defaultCacheDirectory()
    messager("echoconda:: Installing/checking conda via basilisk.", v=verbose)
    conda_path <- basilisk.utils::download()
    if(!is.null(conda_path) && dir.exists(conda_path)){
        messager("echoconda:: conda available at:", conda_path, v=verbose)
    }
}