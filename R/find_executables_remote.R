#' Find remotely stored executable(s)
#' 
#' Find the path to one or more executable binary for each given software.
#' @param path User-provided path to executable. 
#' Is \code{NULL} (default), an executable will be downloaded 
#' and stored automatically. 
#' @param verbose Print messages.
#' @keywords internal 
#' @returns Path to executable. 
#' 
#' @export
#' @importFrom methods show
#' @importFrom echodata set_permissions
#' @examples 
#' paths <- find_executables_remote()
find_executables_remote <- function(path = NULL,
                                    tool = c("bcftools",
                                             "gcta",
                                             "plink"),
                                      verbose = TRUE){
    tool <- tolower(tool) 
    if(is.null(path)){
        requireNamespace("genetics.binaRies") 
        path <- lapply(tool, function(x){
            if(x=="bcftools") {
                path <- genetics.binaRies::get_bcftools_binary()
            } else if(x=="gcta"){
                path <- genetics.binaRies::get_gcta_binary()
            } else if(x=="plink"){
                path <- genetics.binaRies::get_plink_binary()
            } else {
                stp <- paste(
                    "Tool must be one of:",
                    paste("\n -",
                          eval(formals(find_executables_remote)$tool),
                          collapse ="")
                )
                stop(stp)
            }
            echodata::set_permissions(path = path, 
                                      verbose = verbose)
            return(path)
        }) |> `names<-`(tool)
    } else {
        echodata::set_permissions(path = path,
                                  verbose = verbose)
    }
    messager("Using executable(s):",
             methods::show(unlist(path)),
             v=verbose) 
    #### Check that tool works ####
    checks <- check_executables_remote(path = path,
                                       verbose = verbose) 
    return(path)
}
