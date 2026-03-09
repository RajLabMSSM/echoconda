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
    conda_path <- basilisk.utils::condaBinary(loc = cache_dir)
    if(!file.exists(conda_path)){
        messager("echoconda:: Installing conda via basilisk.",v=verbose)
        basilisk.utils::download(cache.dir = cache_dir)
    } else {
        messager("echoconda:: conda already installed.",v=verbose)
    }
}