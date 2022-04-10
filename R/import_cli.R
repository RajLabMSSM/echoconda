#' Import Command Line Interface tool
#' 
#' Import a Command Line Interface (CLI) tool into R as a function.
#' @param path Path to CLI tool executable file (preferred), 
#' or simply the tool name.
#' @param fix_names Map argument names to R-friendly versions. 
#' @inheritParams find_packages 
#' 
#' @source \href{https://stackoverflow.com/a/12983961/13214824}{
#' Stack Overflow}
#' @source \href{https://adv-r.hadley.nz/function-factories.html}{
#' Function factories}
#' @source \href{https://github.com/r-lib/roxygen2/issues/798}{
#' Dynamic roxygen notes}
#' @source \href{https://stackoverflow.com/q/29327423/13214824}{
#' match.call}
#' @export
#' @importFrom stats setNames
#' @examples 
#' mycurl <- import_cli(path="curl")
#' mycurl(h = TRUE)
#' mycurl(url= file.path("http://hgdownload.soe.ucsc.edu/goldenPath",
#'                            "hg38/multiz100way/md5sum.txt"),
#'        o="~/Downloads/tmp.txt")
import_cli <- function(path,
                       fix_names = TRUE,
                       # intern = FALSE,
                       conda_env = NULL, 
                       verbose = TRUE){
    # path="curl"; conda_env="echoR"; verbose=TRUE
    package <- NULL;
     
    if(!is.null(conda_env)){
        pkgs <- find_packages(packages = path,
                              conda_env = conda_env, 
                              verbose = verbose)
        p <- path
        pkgs <- subset(pkgs, package==basename(p))
        new_path <- unlist(pkgs$path)[1]
        if(is.na(new_path) || is.null(new_path)){
            new_path <- basename(new_path)
            messager(
                "Could not identify tool path from conda_env:",conda_env,"\n",
                "Defaulting to basename:",new_path, v=verbose)
        }
    } else {new_path <- path}
    opts <- parse_options(path=new_path) 
    message("Imported CLI tool ==> R") 
    #### Argument list ####
    ### Map cleaned arguments to original CLI arguments 
    arg_map <- stats::setNames(
        as.list(opts$arg),
        make.names(gsub("-","_",gsub("^-+","",opts$arg))))  
    arg_map[[quote(...)]] <- quote(...)
    arg_names <- if(fix_names) {
        message("Mapping argument names to R-friendly versions.")
        names(arg_map)
    } else {
        unname(arg_map)
    }
    arg_list <-  stats::setNames(
        object = rep(list(NULL),length(arg_names)),
        nm = arg_names)
    arg_list[[quote(...)]] <- quote(...) 
    #### Body #### 
    body <- make_function_body(new_path = new_path,
                               fix_names = fix_names)
    func <- make_function(body=body,
                          arg_list = arg_list) 
    # giftwrap::wrap_commands(run = path,
    #                         use_namespace = use_namespace,
    #                         base_remove = use_namespace)
    # func <- get("run", asNamespace("imports"))
    # formals(func) <- arg_list
    # Sys.setenv()
    # paste(
    #     roxygen2::rd_section("title",pkg_name),
    #     roxygen2::rd_section("description",
    #                          paste(pkg_name,
    # "Imported by \\link[echoconda]{import_cli}"))
    # ) 
    return(func)
}
