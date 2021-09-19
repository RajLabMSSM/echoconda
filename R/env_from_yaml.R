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
env_from_yaml <- function(yaml_path = system.file(package = "echoconda",
                                                  "conda/echoR.yml"),
                          conda = "auto",
                          force_new = FALSE,
                          verbose = TRUE) {
    install_conda()
    start <- Sys.time()
    force <- if (force_new) "--force" else NULL
    env_name <- name_from_yaml(
        yaml_path = yaml_path,
        verbose = verbose
    )
    if (env_exists(env_name) & force_new == FALSE) {
        messager("echoconda:: Conda environment already exists:",
            env_name,
            v = verbose
        )
    } else {
        messager("echoconda:: Creating conda environment:", env_name,
            v = verbose
        )
        conda <- reticulate::conda_binary(conda = conda)
        cmd <- paste(conda, "env create -f", force, yaml_path)
        message(cmd)
        system(cmd)
        messager("echoconda:: Conda environment created:",
            env_name,
            v = verbose
        )
    }
    report_time(start = start, v = verbose)
    return(env_name)
}
