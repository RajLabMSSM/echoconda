#' Find the python file for a specific env
#'
#' @param conda_env Conda environment name.
#' @param verbose Print messages.
#'
#' @family echoconda
#' @examples
#' python <- find_python_path(conda_env = "echoR")
#' @export
#' @importFrom reticulate conda_list
find_python_path <- function(conda_env = "echoR",
                             verbose = TRUE) {
    # Avoid confusing checks
    name <- NULL

    install_conda(verbose = FALSE)
    conda_env <- check_env(conda_env = conda_env)
    env_list <- reticulate::conda_list()
    if (is.null(conda_env)) {
        messager("echoconda:: No conda env supplied.",
            "Using default 'python' instead.",
            v = verbose
        )
        python_path <- "python"
    } else {
        if (conda_env %in% env_list$name) {
            python_path <- subset(env_list, name == conda_env)$python
        } else {
            messager("echoconda::", paste0("'", conda_env, "'"),
                "conda environment not found.",
                "Using default 'python' instead.",
                v = verbose
            )
            python_path <- "python"
        }
    }
    return(python_path)
}
