#' Install conda 
#' 
#' Install conda if it has not already been installed.
#' @param method Method to use when installing conda. 
#' @inheritParams install_conda_reticulate
#' @inheritParams reticulate::conda_version
#' 
#' @export
#' @examples 
#' echoconda::install_conda()
install_conda <- function(method = c("basilisk","reticulate"),
                          conda = "auto",
                          verbose = TRUE,
                          ...) { 
    
    method <- tolower(method)[1] 
    if(method=="basilisk"){
        install_conda_basilisk(verbose = verbose)
    } else if(method=="reticulate"){
        install_conda_reticulate(conda = conda, 
                                 verbose = verbose)
    } else {
        messager("Warning: method must be one of:",
                 paste("\n -",eval(formals(install_conda)$method),
                       collapse = ""),
                 v=verbose)
        messager("Defaulting to reticulate.",v=verbose)
        install_conda_reticulate(conda = conda, 
                                 verbose = verbose)
    }
}
