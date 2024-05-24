#' Create conda env from yaml file
#'
#' Create a conda environment from a yaml file. By default, 
#' creates the "echoR" conda env to support \pkg{echolocatoR}.
#' @param yaml_path Path to local or remote yaml file with conda build
#' specifications.
#' @param method Method to use to create the conda env:
#' \itemize{
#' \item{"basilisk" : }{Uses the R package \pkg{basilisk}.}
#' \item{"reticulate" : }{Uses the R package \pkg{reticulate}.}
#' \item{"cli" : }{Uses a custom wrapper for conda's command line interface.}
#' }
#' @param force_new If the conda env already exists,
#'  overwrite it with a new one (\emph{DEFAULT}: \code{FALSE}).
#' @param show_contents Show the contents of the yaml file (if used).
#' @param verbose Print messages.
#' @inheritParams create_env
#' @inheritParams reticulate::conda_create
#' 
#' @source \href{https://github.com/rstudio/reticulate/issues/779}{GitHub Issue}
#' @source \href{https://stackoverflow.com/questions/35802939/install-only-available-packages-using-conda-install-yes-file-requirements-t}{
#' StackOverflow suggestions for cross-platform troubleshooting}
#' @family conda
#' 
#' @export
#' @importFrom reticulate conda_binary
#' @importFrom echodata is_local is_url
#' @examples
#' conda_env <- yaml_to_env()
yaml_to_env <- function(yaml_path = system.file(
                              package = "echoconda",
                              "conda","echoR_mini.yml"
                        ),
                        method = c("basilisk","reticulate"),
                        conda = "auto",
                        force_new = FALSE,
                        show_contents = FALSE,
                        verbose = TRUE,
                        ...) {
    # devoptera::args2vars(yaml_to_env)
    
    method <- tolower(method)[1]
    # install_conda(method = method,
    #               verbose = verbose)
    start <- Sys.time()  
    #### Check whether env exists #### 
    conda_env <- name_from_yaml(yaml_path = yaml_path,
                                verbose = verbose)
    does_exist <- env_exists(conda_env = conda_env, 
                             conda = conda,
                             method = method)
    #### If yes, return name ####
    if(isTRUE(does_exist)){ 
        messager("echoconda:: Conda environment already exists:",
                 conda_env, v = verbose)
        return(conda_env)
    } 
    ### If not, continue ####
    #### Search for known yamls (by name or by path) ####
    if(!any(echodata::is_local(path = yaml_path),
            echodata::is_url(path = yaml_path))){
        yaml_path <- search_yamls(yaml_path = yaml_path,
                                  show_contents = show_contents,
                                  verbose = verbose) 
    }  
    conda_env <- name_from_yaml(yaml_path = yaml_path,
                                verbose = verbose)
    #### Delete old env ####
    if(isTRUE(force_new)){
        remove_env(conda_env = conda_env,
                   conda = conda,
                   method = method,
                   verbose = verbose)
    }  
    #### Create env or return "base" ####
    if((is.null(conda_env)) || 
       (conda_env=="base")) {
        messager("Returning 'base'",v=verbose)
        conda_env <- "base"
    } else {
        if (env_exists(conda_env = conda_env, 
                       conda = conda, 
                       method = method) ) {
            messager("echoconda:: Conda environment already exists:",
                     conda_env, v = verbose)  
        } else {
            conda_env <- create_env(conda_env = conda_env, 
                                    yaml_path = yaml_path, 
                                    method = method, 
                                    conda = conda, 
                                    force_new = force_new, 
                                    verbose = verbose,
                                    ...)
        }
    }
    conda_env <- check_env(conda_env = conda_env)
    report_time(start = start, v = verbose)
    return(conda_env)
}
