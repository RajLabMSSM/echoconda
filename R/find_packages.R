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
#' @param verbose Print messages.
#' @inheritParams reticulate::conda_binary
#' 
#' @returns Merged data.table with all packages installed in each conda 
#' environment. 
#' 
#' @export
#' @importFrom data.table := fread rbindlist
#' @examples 
#' pkgs <- echoconda::find_packages(conda_env="base")
find_packages <- function(packages = NULL,
                          conda_env = NULL,
                          conda = "auto",
                          filter_paths = FALSE,
                          sort_names = FALSE,
                          verbose = TRUE){ 
    requireNamespace("data.table")
    package <- path <- python <- package <- NULL;
    
    envs <- reticulate::conda_list()
    packages <- unique(packages)
    if(!is.null(conda_env)) envs <- envs[envs$name %in% conda_env,]
    conda <- reticulate::conda_binary(conda = conda)
    n_pkgs <- if(is.null(packages)) "all" else length(packages)
    messager("Searching for",n_pkgs,"package(s) across",
             nrow(envs),"conda environment(s):",
             v=verbose)
    prep <- function(x){
        gsub("^r-*|^bioconductor-*","",tolower(x))
    }
    #### Iterate through envs ####
    pkgs_select0 <- lapply(envs$name, function(env){
        messager(" - ",env,v=verbose) 
        # pkgs <- reticulate:::conda_list_packages(envname = env)
        pkgs <- conda_list_packages(conda_env = env, 
                                    conda = conda,
                                    verbose = FALSE)
        if(!is.null(packages)){ 
            pkgs <- subset(pkgs, prep(package) %in% prep(packages))
        }
        pkgs <- cbind(conda_env=env, pkgs)
        return(pkgs)
    })
    pkgs_select <- data.table::rbindlist(pkgs_select0)
    pkgs_select <- data.table::merge.data.table(pkgs_select, 
                                 envs, 
                                 by.x = "conda_env",
                                 by.y = "name")
    pkgs_select[,path:=file.path(dirname(python),package)]
    pkgs_select[,path:=ifelse(file.exists(path),path,NA)]
    #### Filter ####
    if(isTRUE(filter_paths)){
        pkgs_select <- subset(pkgs_select, !is.na(path))
    }
    #### Sort ####
    if(sort_names){
        data.table::setkey(pkgs_select,"package") 
    }
    #### Report ####
    messager(length(unique(pkgs_select$package)),
             "unique package(s) found across",
             length(unique(pkgs_select$conda_env)),
             "conda environment(s).",v=verbose)
    return(pkgs_select)
}
