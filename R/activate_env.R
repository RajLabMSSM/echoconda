#' Activate conda env
#'
#' @param conda_env Conda environment to use.
#' @param verbose Print messages.
#'
#' @family conda
#' @examples
#' activate_env(conda_env = "echoR")
#' @export
#' @importFrom reticulate use_condaenv conda_list
activate_env <- function(conda_env = "echoR",
                         verbose = TRUE) {
    install_conda()
    env_list <- reticulate::conda_list()
    if (conda_env %in% env_list$name) {
        messager("+ echoconda:: Activating conda env",
            paste0("'", conda_env, "'"),
            v = verbose
        )
        reticulate::use_condaenv(condaenv = conda_env)
    } else {
        messager("+ echoconda::", paste0("'", conda_env, "'"),
            "conda environment not found. Using default 'base' instead.",
            v = verbose
        )
        conda_env <- "base"
        reticulate::use_condaenv(condaenv = "base")
    }
    return(conda_env)
}
