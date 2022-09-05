#' Check executable(s)
#' 
#' Check that each executable works. 
#' Support function for \link[echoconda]{find_executables_remote}. 
#' @param path Path or named list of paths to executable(s).
#' @param verbose Print messages.
#' @keywords internal
#' @returns Logical list.
check_executables_remote <- function(path,
                                     verbose = TRUE){
    checks <- lapply(names(path), function(too){
        x <- path[[too]]
        if(too=="bcftools"){
            out <- system(paste(x,"--version"), intern = TRUE)
            is_installed <- any(
                grepl("bcftools",
                      out,fixed = TRUE)
            ) 
        } else if (too=="gcta"){
            out <- suppressWarnings(system(x, intern = TRUE))
            is_installed <- any(
                grepl("Genome-wide Complex Trait Analysis (GCTA)",
                      out,fixed = TRUE)
            ) 
        } else if (too=="plink"){
            out <- system(paste(x,"--version"), intern = TRUE)
            is_installed <- any(
                grepl("PLINK v",
                      out,fixed = TRUE)
            ) 
        } else {
            stop("Tool must be one of:",
                 paste("\n -",eval(formals(find_executables_remote)$tool),
                       collapse ="")
            )
        }
        if(isFALSE(is_installed)){
            stp <- paste(x,"did not install properly.")
            stop(stp)
        }
        return(is_installed)
    }) |> `names<-`(names(path))
    messager("All executable checks cleared.",v=verbose)
    return(checks)
}
