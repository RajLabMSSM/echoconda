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
#' @param return_path Return only the path to each package. 
#' @param nThread Number of threads to use when parallelizing searches across
#' multiple conda envs.
#' @param verbose Print messages.
#' @inheritParams reticulate::conda_binary
#' @returns Merged data.table with all packages installed in each conda 
#' environment. 
#' @export
#' @importFrom data.table := fread rbindlist
#' @importFrom dplyr %>% first group_by mutate
#' @importFrom stats na.omit
#' @examples 
#' pkgs <- echoconda::find_packages(conda_env="base")
find_packages <- function(packages = NULL,
                          conda_env = NULL,
                          conda = "auto",
                          filter_paths = FALSE,
                          sort_names = FALSE,
                          return_path=FALSE,
                          nThread = 1,
                          verbose = TRUE){ 
    requireNamespace("parallel") 
    package <- path <- python <- package <- NULL;
    # echoverseTemplate:::args2vars(find_packages);
    # echoverseTemplate:::source_all()
    
    envs <- reticulate::conda_list()
    packages <- unique(packages)
    if(!is.null(conda_env)) envs <- envs[envs$name %in% conda_env,]
    conda <- reticulate::conda_binary(conda = conda)
    n_pkgs <- if(is.null(packages)) "all" else length(packages)
    messager("Searching for",n_pkgs,"package(s) across",
             nrow(envs),"conda environment(s):",
             v=verbose)
    prep <- function(x){
        gsub("^r-*|^bioconductor-*|_|-|[.]","",tolower(x))
    }
    #### Iterate through envs ####
    pkgs_select <- parallel::mclapply(envs$name, function(env){
        messager(" -",env,v=verbose) 
        tryCatch({
            # pkgs <- reticulate:::conda_list_packages(envname = env)
            pkgs <- conda_list_packages(conda_env = env, 
                                        conda = conda,
                                        verbose = FALSE)
            if(!is.null(packages)){ 
                pkgs <- subset(pkgs, prep(package) %in% prep(packages))
            }
            pkgs <- cbind(conda_env=env, pkgs)
            pkgs
        }, error = function(e){ message(e); NULL}) 
    }, mc.cores = nThread) %>%
        data.table::rbindlist()
    #### Get paths to each package ####
    pkgs_select <- find_packages_paths(conda_env=conda_env,
                                       pkgs_select=pkgs_select, 
                                       verbose=verbose)
    #### Filter ####
    if(isTRUE(filter_paths)){
        pkgs_select <- subset(pkgs_select, !is.na(path))
    }
    #### Sort ####
    if(sort_names){
        data.table::setkey(pkgs_select,"package") 
    }
    ##### Add command used to call package #####
    # pkgs_select <- pkgs_select %>%
    #     dplyr::group_by(package) %>% 
    #     dplyr::mutate(command = dplyr::first(
    #         stats::na.omit(c(path, gsub("-","_",package)))
    #         )) %>%
    #     data.table::data.table()
    #### Report ####
    messager(formatC(length(unique(pkgs_select$package)),big.mark = ","),
             "unique package(s) found across",
             length(unique(pkgs_select$conda_env)),
             "conda environment(s).",v=verbose)
    if(return_path){
        return(unique(pkgs_select$path))
    }else {
        return(pkgs_select)
    } 
}
