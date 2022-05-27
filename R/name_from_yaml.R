#' Name from yaml
#' 
#' Extract env name from a yaml text file.
#' @keywords internal
#' @importFrom yaml read_yaml
name_from_yaml <- function(yaml_path,
                           verbose = TRUE) { 
    messager("Retrieving conda env name from yaml:",
             yaml_path, v = verbose)
    conda_env <- yaml::read_yaml(yaml_path)$name 
    return(conda_env)
}
