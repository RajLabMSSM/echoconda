#' Create conda env from yaml file
#'
#' Create a conda environment from a yaml file. By default, 
#' creates the "echoR" conda env to support \pkg{echolocatoR}.
#' @param yaml_path Path to local or remote yaml file with conda build
#' specifications.
#' @param force_new If the conda env already exists,
#'  overwrite it with a new one (\emph{DEFAULT}: \code{FALSE}).
#' @param verbose Print messages.
#' @inheritParams reticulate::conda_create
#' 
#' @source \href{https://github.com/rstudio/reticulate/issues/779}{GitHub Issue}
#' @source \href{https://stackoverflow.com/questions/35802939/install-only-available-packages-using-conda-install-yes-file-requirements-t}{
#' StackOverflow suggestions for cross-platform troubleshooting}
#' @family conda
#' @export
#' @importFrom reticulate conda_binary
#' @examples
#' conda_env <- echoconda::yaml_to_env()
yaml_to_env <- function(yaml_path = system.file(
                              package = "echoconda",
                              "conda/echoR.yml"
                          ),
                          conda = "auto",
                          force_new = FALSE,
                          verbose = TRUE) {
    install_conda()
    start <- Sys.time() 
    conda_env <- name_from_yaml(
        yaml_path = yaml_path,
        verbose = verbose
    )
    #### Search for known yamls (by name or by path) ####
    yaml_path <- search_yamls(conda_env = yaml_path,
                              verbose = verbose)
    #### Check OS ####
    if(get_os()=="Windows" && conda_env=="echoR"){
        messager("Windows OS detected:",
                 "using modified yaml file that omits packages",
                 "not available on Windows.", v=verbose)
        yaml_path <- system.file(package = "echoconda",
                                 "conda/echoR_windows.yml")
    }
    #### Create env or return "base" ####
    if((is.null(conda_env)) || (conda_env=="base")) {
        messager("Returning 'base'",v=verbose)
        conda_env <- "base"
    } else {
        if (env_exists(conda_env) & (!force_new)) {
            messager("echoconda:: Conda environment already exists:",
                     conda_env,
                     v = verbose
            )
        } else {
            messager("echoconda:: Creating conda environment:", conda_env,
                     v = verbose
            ) 
            conda_env <- tryCatch(expr = {
                # out <- conda_create0(yaml_path = yaml_path,
                #                      conda = conda, force_new = force_new,
                #                      verbose = verbose)
                reticulate::conda_create(envname = conda_env,
                                         environment = yaml_path, 
                                         conda = conda)
                if(env_exists(conda_env = conda_env,
                              conda = conda)){
                    messager("echoconda:: Conda environment created:",
                             conda_env,
                             v = verbose
                    )
                } else {stop()}
                conda_env
            }, error = function(x) {
                messager("echoconda:: Conda enviroment creation failed.",
                         "Defaulting to enviroment 'base'.",
                         v = verbose
                )
                "base"
            })
        }
    }
    conda_env <- check_env(conda_env = conda_env)
    report_time(start = start, v = verbose)
    return(conda_env)
}
