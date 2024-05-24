#' Install conda: basilisk
#'
#' Install conda if it has not already been installed.
#' @param verbose Print messages.
#' 
#' @keywords internal
#' @importFrom basilisk.utils installConda
install_conda_basilisk <- function(verbose=TRUE){
    # Sys.setenv("BASILISK_USE_SYSTEM_DIR"=1)
    new_install <- basilisk.utils::installConda(installed = FALSE)
    if(isTRUE(new_install)){
        messager("echoconda:: Installing conda via basilisk.",v=verbose)
    } else {
        messager("echoconda:: conda already installed.",v=verbose)
    }
}