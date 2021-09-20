#' Create conda env from yaml file
#'
#'
#' @param yaml_path Path to local or remote yaml file with conda build
#' specifications.
#' @param conda Path to conda executable.
#' @param force_new If the conda env already exists,
#'  overwrite it with a new one (\emph{DEFAULT}: \code{FALSE}).
#' @param verbose Print messages.
#'
#' @family conda
#' @export
#' @importFrom reticulate conda_binary
env_from_yaml <- function(yaml_path = system.file(
                              package = "echoconda",
                              "conda/echoR.yml"
                          ),
                          conda = "auto",
                          force_new = FALSE,
                          verbose = TRUE) {
    install_conda()
    start <- Sys.time()
    force <- if (force_new) "--force" else NULL
    conda_env <- name_from_yaml(
        yaml_path = yaml_path,
        verbose = verbose
    )
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
            conda <- reticulate::conda_binary(conda = conda)
            cmd <- paste(conda, "env create -f", force, yaml_path)
            message(cmd)
            conda_env <- tryCatch(expr = {
                system(cmd)
                messager("echoconda:: Conda environment created:",
                         conda_env,
                         v = verbose
                )
                conda_env
            }, error = function(x) {
                messager("echoconda:: Conda enviroment creation failed.",
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
