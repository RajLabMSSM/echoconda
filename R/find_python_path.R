#' Find the python file for a specific env
#'
#' @param conda_env Conda environment name.
#' @param verbose Print messages.
#' @inheritParams find_conda
#'
#' @family echoconda
#' @examples
#' # importFrom reticulate conda_list
#' python <- find_python_path(conda_env = "echoR")
#' @export
find_python_path <- function(conda_env = "echoR_mini",
                             method = c("basilisk","reticulate"),
                             verbose = TRUE) {
    # Avoid confusing checks
    name <- NULL; 
    conda_env <- check_env(conda_env = conda_env) 
    envs <- list_envs(method = method)
    #### Return results as named vector #### 
    python_paths <- sapply(conda_env, function(env){  
        if(env %in% envs$name){
            python <- subset(envs, name==env)$python
        } else{
            messager("echoconda:: No conda env supplied.",
                     "Using default 'python' instead.",
                     v = verbose)
            python <- "python"
        }
        return(python)
    })
    return(python_paths) 
}
