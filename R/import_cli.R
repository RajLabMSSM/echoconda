#' Import Command Line Interface tool
#' 
#' Import a Command Line Interface (CLI) tool into R as a function.
#' @param path Path to CLI tool executable file.
#' @inheritParams giftwrap::wrap_commands
#' @export
#' @examples 
#' import_cli(tool="curl")
#' curl::run("-h")
import_cli <- function(tool,
                       use_namespace = basename(tool),
                       conda_env = NULL,
                       verbose = TRUE){
    if(!is.null(conda_env)){
        tool <- echoconda::find_packages(packages = tool,
                                         conda_env = conda_env)$path
        if(is.na(tool) || is.null(tool)){
            tool <- basename(tool)
            messager(
                "Could not identify tool path from conda_env:",conda_env,"\n",
                "Defaulting to basename:",tool, v=verbose)
        }
    } 
    opts <- echoconda::parse_options(path=tool)
    giftwrap::wrap_commands(run = tool,
                            use_namespace = use_namespace,
                            base_remove = use_namespace)
    message("Imported CLI tool ==> R as: ", use_namespace)
    # giftwrap::wrap_lexicon(lexicon("git"),
    #              use_namespace = "git",
    #              commands = c("status", "reset"),
    #              drop_base = TRUE)
}
