env_exists <- function(env_name,
                       conda = "auto") {
    envs <- reticulate::conda_list(conda = conda)
    does_exist <- env_name %in% envs$name
    return(does_exist)
}
