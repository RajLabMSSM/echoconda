activate_env_reticulate <- function(conda_env,
                                    verbose=TRUE){
    conda_env <- conda_env[1]
    #### Check if env already active ####
    current_env <- which_env(verbose = verbose)
    if(conda_env == current_env){
        messager("Requested conda_env is already active:",
                 paste0("'",current_env,"'"),v=verbose)
        return(conda_env)
    } 
    #### Take multiple approaches to ensure env gets activated ####
    messager("Activating conda env via reticulate:",
             paste0("'", conda_env, "'"),v = verbose) 
    out <- tryCatch(expr = { 
        suppressWarnings(
            reticulate::use_condaenv(condaenv = conda_env,
                                     required = TRUE) 
        )
        python <- find_python_path(conda_env = conda_env,
                                   verbose = FALSE)  
        Sys.setenv(RETICULATE_PYTHON = python) 
        suppressWarnings(
            reticulate::use_python(python = python,
                                   required = TRUE) 
        )
        
    }, error = function(e){e})
    if (inherits(out, "error")) { 
        conda_env <- which_env(verbose = FALSE)
        messager("Unable to activate env.",
                 "Using previously activated env instead:",
                 conda_env, v=verbose)
    } 
}