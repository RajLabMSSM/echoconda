activate_env_basilisk <- function(conda_env,
                                  loc=basilisk.utils::defaultCacheDirectory(),
                                  verbose=TRUE){

    messager("Activating conda env via basilisk:",
             paste0("'",conda_env,"'"),v = verbose)
    ## Supplying the full path to the env dir
    ## is much more robust than simply supplying the env name.
    envs <- list_envs(conda_env = conda_env,
                      method = "basilisk")
    ## activateEnvironment was removed from basilisk.utils.
    ## Set environment variables directly to activate the conda env.
    envpath <- envs$dir
    if(length(envpath) > 0 && nchar(envpath[1]) > 0){
        conda_x <- basilisk.utils::condaBinary(loc = loc)
        Sys.setenv(CONDA_PREFIX = envpath[1])
        old_path <- Sys.getenv("PATH")
        bin_dir <- if(.Platform$OS.type == "windows"){
            envpath[1]
        } else {
            file.path(envpath[1], "bin")
        }
        Sys.setenv(PATH = paste(bin_dir, old_path, sep = .Platform$path.sep))
    }
    return(invisible(envpath))
}