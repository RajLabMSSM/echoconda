#' Create conda env from yaml
#' 
#' Original function for creating conda env from yaml before this was 
#' implemented in \link[reticulate]{conda_create}.
#' 
#' @source \href{https://stackoverflow.com/questions/35802939/install-only-available-packages-using-conda-install-yes-file-requirements-t}{
#' StackOverflow suggestions for cross-platform troubleshooting}
#' @keywords internal
#' @inheritParams yaml_to_env
#' @inheritParams reticulate::conda_create
conda_create0 <- function(yaml_path = system.file(package = "echoconda",
                                                  "conda/test.yml"), 
                          conda = "auto",
                          force_new = FALSE,
                          verbose=TRUE){ 
    
    force <- if (force_new) "--force" else NULL
    conda <- reticulate::conda_binary(conda = conda)
    cmd <- paste(conda, "env create -f", force, yaml_path)
    # cmd <- paste(
    #     "while read requirement;",
    #     paste("do",conda,"install --yes $requirement;"),
    #     "done <",
    #     yaml_path
    # )
    messager(cmd, v=verbose)
    system(cmd)
    conda_env <- name_from_yaml(
        yaml_path = yaml_path,
        verbose = FALSE
    )
    return(conda_env)
}