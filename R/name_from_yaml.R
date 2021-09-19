name_from_yaml <- function(yaml_path,
                           verbose = TRUE) {
    messager("echoconda:: Retrieving conda env name from yaml.", v = verbose)
    options(timeout = 60)
    lines <- tryCatch(
        expr = {
            lines <- readLines(yaml_path)
        },
        error = function(e) NULL
    )
    if (!is.null(lines)) {
        env_name <- trimws(gsub(
            "name: ", "",
            grep("name:", lines, value = TRUE)
        ))
    } else {
        messager("echoconda:: Could not retrieve conda env name.", v = verbose)
        env_name <- NULL
    }
    return(env_name)
}
