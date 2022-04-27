#' Find conda 
#' 
#' Find conda executable from multiple installations: 
#' \pkg{reticulate}, \pkg{basilisk}
#' 
#' @param use_basilisk Search conda envs created by \pkg{basilisk} 
#' instead of \pkg{reticulate}.
#' @inheritParams reticulate::conda_binary
#'
#' @export
#' @importFrom basilisk.utils getCondaBinary getCondaDir
find_conda <- function(conda="auto",
                       use_basilisk=FALSE){
    if(isTRUE(use_basilisk)){
        conda_x <- basilisk.utils::getCondaBinary(
            loc = basilisk.utils::getCondaDir()
        )
    } else { 
        ## Not clear on how these are different. Return same file on Mac.
        # conda_x <- reticulate::conda_exe(conda = conda)
        conda_x <- reticulate::conda_binary(conda = conda)
    } 
    return(conda_x)
}
