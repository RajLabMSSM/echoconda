#' Import Command Line Interface tool
#' 
#' Import a Command Line Interface (CLI) tool into R as a function.
#' @param path Path to CLI tool executable file (preferred), 
#' or simply the tool name.
#' @inheritParams find_packages
#' @inheritParams giftwrap::wrap_commands
#' @export
#' @examples 
#' import_cli(path="curl")
#' # curl::run("-h")
import_cli <- function(path,
                       use_namespace = basename(path),
                       conda_env = NULL,
                       verbose = TRUE){
    requireNamespace("giftwrap")
    if(!is.null(conda_env)){
        path <- find_packages(packages = path,
                              conda_env = conda_env)$command[1]
        if(is.na(path) || is.null(path)){
            path <- basename(path)
            messager(
                "Could not identify tool path from conda_env:",conda_env,"\n",
                "Defaulting to basename:",path, v=verbose)
        }
    } 
    opts <- echoconda::parse_options(path=path)
    giftwrap::wrap_commands(run = path,
                            use_namespace = use_namespace,
                            base_remove = use_namespace)
    message("Imported CLI tool ==> R as: ", use_namespace)
    # giftwrap::wrap_lexicon(lexicon("git"),
    #              use_namespace = "git",
    #              commands = c("status", "reset"),
    #              drop_base = TRUE)
}
