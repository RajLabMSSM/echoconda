#' Name from yaml
#' 
#' Extract env name from a yaml text file.
#' @keywords internal
#' @importFrom yaml read_yaml
name_from_yaml <- function(yaml_path,
                           verbose = TRUE) { 
    messager("Retrieving conda env name from yaml:",
             yaml_path, v = verbose)
    #### Get name from path ####
    if(basename(yaml_path)==yaml_path && 
       (!file.exists(yaml_path))){
        conda_env <- gsub(".yml|.yaml","",basename(yaml_path),
                          ignore.case = TRUE)
    } else {
    #### Get name from file contents ####
        conda_env <- yaml::read_yaml(yaml_path)$name 
    } 
    return(conda_env)
}
