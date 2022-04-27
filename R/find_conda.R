#' Find conda 
#' 
#' Find conda executable from multiple installations: 
#' \pkg{reticulate}, \pkg{basilisk}
#' 
#' @param method Method to use:
#' \itemize{
#' \item{"basilisk"}
#' \item{"reticulate"}
#' }
#' @inheritParams reticulate::conda_binary
#'
#' @export
#' @importFrom basilisk.utils getCondaBinary getCondaDir
find_conda <- function(conda="auto",
                       method=c("basilisk","reticulate")){
    method <- tolower(method)[1]
    if(method=="basilisk"){
        conda_x <- basilisk.utils::getCondaBinary(
            loc = basilisk.utils::getCondaDir()
        )
        #### If it fails, use the other method ####
        if(!file.exists(conda_x)){
            conda_x <- reticulate::conda_binary(conda = conda)
        }
    } else if(method=="reticulate"){ 
        ## Not clear on how these are different. Return same file on Mac.
        # conda_x <- reticulate::conda_exe(conda = conda)
        conda_x <- reticulate::conda_binary(conda = conda)
        #### If it fails, use the other method ####
        if(!file.exists(conda_x)){
            conda_x <- basilisk.utils::getCondaBinary(
                loc = basilisk.utils::getCondaDir()
            )
        }
    } 
    return(conda_x)
}
