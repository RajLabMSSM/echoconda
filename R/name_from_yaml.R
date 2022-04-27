#' Name from yaml
#' 
#' Extract env name from a yaml text file.
#' @keywords internal
#' @importFrom yaml read_yaml
name_from_yaml <- function(yaml_path,
                           verbose = TRUE) {
    
    if(!file.exists(yaml_path)){
        # messager(yaml_path,"does not exist.",
        #          "Inferring conda_env name from path.",v=verbose)
        conda_env <- gsub(".yaml$|.yml$","",basename(yaml_path))
        return(conda_env)
    }
    messager("Retrieving conda env name from yaml:",yaml_path, v = verbose)
    conda_env <- yaml::read_yaml(yaml_path)$name 
    return(conda_env)
}
