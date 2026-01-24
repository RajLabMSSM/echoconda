activate_env_basilisk <- function(conda_env,
                                  loc=NULL,
                                  verbose=TRUE){
    ## Note: basilisk.utils::activateEnvironment was removed in newer versions.
    ## Now using reticulate-based activation instead.
    messager("Activating conda env:",
             paste0("'",conda_env,"'"),v = verbose)
    activate_env_reticulate(conda_env = conda_env,
                            verbose = verbose)
}