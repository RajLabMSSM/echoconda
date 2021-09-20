check_env <- function(conda_env=NULL,
                        default="base"){
    if(is.null(conda_env)) return(default) else return(conda_env)
}