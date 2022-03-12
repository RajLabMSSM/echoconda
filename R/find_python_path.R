#' Find the python file for a specific env
#'
#' @param conda_env Conda environment name.
#' @param verbose Print messages.
#'
#' @family echoconda
#' @examples
#' # importFrom reticulate conda_list
#' python <- find_python_path(conda_env = "echoR")
#' @export
find_python_path <- function(conda_env = "echoR",
                             verbose = TRUE) {
    # Avoid confusing checks
    name <- NULL; 
    install_conda(verbose = FALSE)
    conda_env <- check_env(conda_env = conda_env)
    env_list <- reticulate::conda_list()
    python_paths <- lapply(conda_env, function(env){ 
        if (is.null(env)) {
            messager("echoconda:: No conda env supplied.",
                     "Using default 'python' instead.",
                     v = verbose
            )
            python_path <- "python"
        } else {
            if (env %in% env_list$name) {
                python_path <- subset(env_list, name == env)$python
            } else {
                messager("echoconda::", paste0("'", env, "'"),
                         "conda environment not found.",
                         "Using default 'python' instead.",
                         v = verbose
                )
                python_path <- "python"
            }
        }
        return(python_path)
    })
    #### Return results as named vector #### 
    python_paths <- unlist(python_paths)
    names(python_paths) <- conda_env
    return(python_paths) 
}
