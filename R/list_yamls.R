#' List included yaml files 
#' 
#' List the yaml files included within \code{echconda}. 
#' These are provided to make different conda environments that are useful for
#' specific workflows.
#' 
#' @param verbose Print messages.
#' @export
#' @examples 
#' yamls <- echoconda::list_yamls()
list_yamls <- function(verbose = TRUE){
    
    cdir <- system.file(package = "echoconda","conda/")
    yamls <- list.files(cdir, full.names = TRUE, recursive = TRUE)
    meta <- data.table::data.table(
        conda_env=sapply(yamls, name_from_yaml, verbose=FALSE),
        yaml_path=yamls
    ) 
    messager(paste0(
        nrow(meta)," conda yamls available:\n",
        paste0(" - ",meta$conda_env, collapse = "\n")
    ),
    v=verbose)
    return(meta)
}
