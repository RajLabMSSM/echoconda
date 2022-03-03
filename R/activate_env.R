#' Activate conda env
#'
#' \link[reticulate]{use_condaenv} often 
#' \href{https://github.com/rstudio/reticulate/issues/292}{
#' doesn't work in practice}, especially within RStudio.
#' \link[echoconda]{activate_env} ensures the env is actually activated 
#' and used.
#' 
#' @param conda_env Conda environment to use.
#' @param verbose Print messages.
#' @source \href{https://github.com/rstudio/reticulate/issues/1147}{GH Issues}
#' @source \href{https://github.com/rstudio/reticulate/issues/1044}{GH Issues}
#' @source \href{https://github.com/rstudio/reticulate/issues/292}{GH Issues}
#' @family conda
#' @export
#' 
#' @examples
#' # importFrom reticulate conda_list use_condaenv use_python conda_list
#' echoconda::activate_env(conda_env = "echoR")
activate_env <- function(conda_env = "echoR",
                         verbose = TRUE) { 
    install_conda()
    
    current_env <- which_env()
    if(conda_env == current_env){
        messager("echoconda:: Requested conda_env is already active:",
                 paste0("'",current_env,"'"),v=verbose)
    }
    
    env_list <- reticulate::conda_list()
    if (conda_env %in% env_list$name) {
        messager("echoconda:: Attempting to activate conda env:",
            paste0("'", conda_env, "'"),
            v = verbose
        ) 
        #### Take multiple approaches to ensure env gets activated ####
        out <- tryCatch(expr = {
            reticulate::use_condaenv(condaenv = conda_env,
                                     required = TRUE) 
            python <- find_python_path(conda_env = conda_env,
                                       verbose = FALSE)  
            Sys.setenv(RETICULATE_PYTHON = python)  
            reticulate::use_python(python = python,
                                   required = TRUE) ## <--Tricky
        }, error = function(e){e})
        if (inherits(out, "error")) { 
            conda_env <- which_env(verbose = FALSE)
            messager("Unable to activate env.",
                     "Using previously activated env instead:",
                     conda_env, v=verbose)
        } 
    } else {
        messager("echoconda::", paste0("'", conda_env, "'"),
            "conda environment not found. Using default 'base' instead.",
            v = verbose
        )
        conda_env <- "base"
        out <- tryCatch({
            reticulate::use_condaenv(condaenv = "base", )
        }, error = function(e){e})
    }
    conda_env <- check_env(conda_env)
    return(conda_env)
}
