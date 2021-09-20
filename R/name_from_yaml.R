name_from_yaml <- function(yaml_path,
                           verbose = TRUE) {
    messager("echoconda:: Retrieving conda env name from yaml.", v = verbose)
    lines <- suppressWarnings(tryCatch(
        expr = {
            options(timeout = 5)
            lines <- readLines(yaml_path)
            lines
        },
        error = function(e) NULL
    ))
    if (!is.null(lines)) {
        conda_env <- trimws(gsub(
            "name: ", "",
            grep("name:", lines, value = TRUE)
        )) 
    } else {
        messager("echoconda:: Could not retrieve conda env name.", v = verbose)
        conda_env <- NULL 
    }
    return(conda_env)
}
