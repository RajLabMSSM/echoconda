#' Print the currently activated conda env
#' 
#' @export
#' @importFrom reticulate py_config
which_env <- function(verbose=TRUE){
    conf <- reticulate::py_config()
    conda_env <- basename(conf$prefix)
    messager("echoconda:: Active conda env:",
             paste0("'",conda_env,"'"),v=verbose)
    return(conda_env) 
}