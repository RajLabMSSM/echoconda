#' Find conda
#'
#' Find conda executable from multiple installations:
#' \pkg{reticulate}, \pkg{basilisk}
#'
#' @param method Method to use:
#' \itemize{
#' \item \code{"basilisk"}
#' \item \code{"reticulate"}
#' }
#' @inheritParams reticulate::conda_binary
#'
#' @export
#' @importFrom basilisk.utils find
find_conda <- function(conda="auto",
                       method=c("basilisk","reticulate")){
    method <- tolower(method)[1]
    if(method=="basilisk"){
        conda_x <- tryCatch(basilisk.utils::find(),
                             error = function(e) NULL)
        #### If it fails, use the other method ####
        if(is.null(conda_x) || !file.exists(conda_x)){
            conda_x <- tryCatch(reticulate::conda_binary(conda = conda),
                                error = function(e) NULL)
        }
    } else if(method=="reticulate"){
        ## Not clear on how these are different. Return same file on Mac.
        # conda_x <- reticulate::conda_exe(conda = conda)
        conda_x <- tryCatch(reticulate::conda_binary(conda = conda),
                            error = function(e) NULL)
        #### If it fails, use the other method ####
        if(is.null(conda_x) || !file.exists(conda_x)){
            conda_x <- tryCatch(basilisk.utils::find(),
                                error = function(e) NULL)
        }
    } else {
        stop("method not recognized.")
    }
    #### Last resort: check PATH ####
    if(is.null(conda_x) || !file.exists(conda_x)){
        conda_path <- Sys.which("conda")
        if(nzchar(conda_path)) conda_x <- conda_path
    }
    if(is.null(conda_x) || !file.exists(conda_x)){
        stop("Could not find conda. ",
             "Install via basilisk.utils::download() or ",
             "reticulate::install_miniconda().")
    }
    return(conda_x)
}
