activate_env_basilisk <- function(conda_env,
                                  loc=basilisk.utils::getCondaDir(),
                                  verbose=TRUE){
    
    messager("Activating conda env via basilisk:",
             paste0("'",conda_env,"'"),v = verbose) 
    ## Supplying the full path to the env dir
    ## is much more robust than simply supplying the env name.
    envs <- list_envs(conda_env = conda_env,
                      method = "basilisk")
    out <- basilisk.utils::activateEnvironment(envpath = envs$dir,
                                               loc = loc)
}