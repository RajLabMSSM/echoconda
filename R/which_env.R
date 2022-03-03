#' Print the currently activated conda env
#' 
#' \link[reticulate]{py_discover_config}
#' "This function enables callers to check which versions of
#'  Python will be discovered on a system as well as which one 
#'  will be chosen for use with reticulate."
#' @param verbose Print messages. 
#' @export
which_env <- function(verbose=TRUE){
    # conf <- reticulate::py_config()
    conf <- reticulate::py_discover_config()
    conda_env <- basename(conf$prefix)
    messager("echoconda:: Active conda env:",
             paste0("'",conda_env,"'"),v=verbose)
    return(conda_env) 
}