#' Find package across all conda envs
#' 
#' Search for a package (or list of packages) across all available conda
#'  environments.
#'  By default, returns all packages from all conda environments.
#' @param packages A package (e.g. \code{"pandas"})
#' or a list of packages (e.g. \code{c("pandas","r-dplyr","bgzip")}).
#' Will recognize R packages with or without the prefixes 
#' "r-" and "bioconductor-" (i.e. "r-dplyr" is equivalent to "dplyr"). 
#' @param conda_env Conda environments to search in. 
#' If \code{NULL} (default), will search all conda environments.
#' @param filter_paths Filter out packages without callable executable paths
#'  from the table.
#' @param sort_names Sort packages alphanumerically by their name. 
#' @param types Path type to search for and include in the table.
#' @param return_path Return only the path to each package. 
#' @param robust Uses a more robust (but slower) method for identifying paths
#' to conda environments and package executables (default: \code{FALSE}).
#' When \code{robust=FALSE}, only executables in the main "bin" directory
#'  will be detected. When \code{robust=TRUE}, additional executables to
#'  R packages, Python packages, and executables in nested subdirectories will 
#'  be detected.
#' @param nThread Number of threads to use when parallelizing searches across
#' multiple conda envs.
#' @param verbose Print messages.
#' @inheritParams list_packages
#' @inheritParams reticulate::conda_binary
#' 
#' @returns Merged data.table with all packages installed in each conda 
#' environment. 
#' 
#' @export
#' @importFrom data.table rbindlist
#' @importFrom stats setNames 
#' @examples 
#' pkgs <- echoconda::find_packages(conda_env="base")
find_packages <- function(packages = NULL,
                          conda_env = NULL,
                          conda = "auto",
                          method = c("r","reticulate","basilisk"),
                          types = c("r","python","binary"),
                          return_path = FALSE,
                          robust = FALSE, 
                          filter_paths = FALSE,
                          sort_names = FALSE,
                          nThread = 1,
                          verbose = TRUE){ 
    requireNamespace("parallel") 
    path <- NULL;
    # echoverseTemplate:::source_all(packages = "dplyr")
    # echoverseTemplate:::args2vars(find_packages);conda_env="echoR";
    
    #### Gather names of (requested envs) ####
    envs <- list_envs(conda_env = conda_env,
                      conda = conda) 
    #### List packages #### 
    packages <- unique(packages)
    n_pkgs <- if(is.null(packages)) "all" else length(packages)
    #### Report what will be searched ####
    messager("Searching for",n_pkgs,"package(s) across",
             nrow(envs),"conda environment(s).",
             v=verbose) 
    #### Iterate through envs ####
    pkgs_select <- data.table::rbindlist(
        parallel::mclapply(envs$name, function(env){ 
            tryCatch({ 
                pkgs <- list_packages(conda_env = env, 
                                      conda = conda,
                                      method = method,
                                      packages = packages,
                                      verbose = verbose)   
                if(nrow(pkgs)>0){
                    #### Get paths to each package ####
                    pkgs <- find_packages_paths(conda_env=env,
                                                pkgs=pkgs, 
                                                types=types,
                                                robust = robust,
                                                verbose=verbose)
                } else {
                    messager("No matching packages identified",
                             "in the requested conda environment:",env,"\n",
                             "Returning empty data.table.",
                             v=verbose)
                }
                return(pkgs)
            }, error = function(e){ message(e); NULL}) 
        }, mc.cores = nThread), 
    fill=TRUE)
    #### Report ####
    if(nrow(pkgs_select)==0){
        messager("No matching packages identified",
                 "in the requested conda environment(s).",
                 "Returning empty data.table.",
                 v=verbose)
        return(pkgs_select)
    } else {
        messager(formatC(length(unique(pkgs_select$package)),big.mark = ","),
                 "unique package(s) found across",
                 length(unique(pkgs_select$env)),
                 "conda environment(s).",v=verbose)
    }
    #### Filter ####
    if(isTRUE(filter_paths)){
        messager("Removing packages without identifiable paths.",v=verbose)
        pkgs_select <- subset(pkgs_select, !is.na(path))
    }
    #### Sort ####
    if(sort_names){
        messager("Sorting packages alphanumerically.",v=verbose)
        data.table::setkeyv(pkgs_select,c("env","package")) 
    }
    #### Return ####
    if(return_path){
        # messager("Returning a named list of paths.",v=verbose)
        return(stats::setNames(pkgs_select$path,
                               pkgs_select$package))
    }else {
        return(pkgs_select)
    } 
}
