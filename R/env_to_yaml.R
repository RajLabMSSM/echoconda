#' Create yaml file from env
#'
#' Export a yaml file from a conda environment.
#' @param conda_env Name of the conda environment to export.
#' @param yaml_path Path to write yaml file to.
#' @param verbose Print messages.
#' @param ... Additional arguments passed to \link[reticulate]{conda_create}.
#' @inheritParams find_conda
#' @inheritParams reticulate::conda_create
#' 
#' @source \href{https://github.com/rstudio/reticulate/issues/779}{
#' GitHub Issue}
#' @source \href{https://github.com/datitran/object_detector_app/issues/41}{
#' GitHub Issue}
#' @family conda
#' @export
#' @importFrom reticulate conda_export
#' @examples
#' path <- env_to_yaml(conda_env="base")
env_to_yaml <- function(conda_env,
                        yaml_path = file.path(tempdir(),"conda.yml"),
                        conda  = "auto",
                        method = c("reticulate","basilisk"),
                        verbose = TRUE,
                        ...){
    
    if(env_exists(conda_env = conda_env,
                  conda = conda, 
                  method = method)){
        messager("Exporting environment",conda_env,"as yaml file.",v=verbose)
        out <- reticulate::conda_export(envname = conda_env, 
                                        file = yaml_path,
                                        ...)
        return(out) 
    } else {
        stop("Could not find environment named",paste0("'",conda_env,"'"))
    } 
}
