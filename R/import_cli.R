#' Import Command Line Interface tool
#' 
#' Import a Command Line Interface (CLI) tool into R as a function.
#' @param path Path to CLI tool executable file (preferred), 
#' or simply the tool name.
#' @param env Which R environment to use.
#' @inheritParams find_packages 
#' @source \href{https://stackoverflow.com/a/12983961/13214824}{
#' Stack Overflow}
#' @source \href{https://adv-r.hadley.nz/function-factories.html}{
#' Function factories}
#' @source \href{https://github.com/r-lib/roxygen2/issues/798}{
#' Dynamic roxygen notes}
#' @source \href{https://stackoverflow.com/q/29327423/13214824}{
#' match.call}
#' @export
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
    
    pkg_name <- basename(path)
    if(!is.null(conda_env)){
        pkgs <- find_packages(packages = path,
                              conda_env = conda_env)
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
    # giftwrap::wrap_commands(run = path,
    #                         use_namespace = use_namespace,
    #                         base_remove = use_namespace)
    # func <- get("run", asNamespace("imports"))
    # formals(func) <- arg_list
    message("Imported CLI tool ==> R")
    
    #### Argument list ####
    ### Map cleaned arguments to original CLI arguments 
    arg_map <- stats::setNames(
        as.list(opts$arg),
        make.names(gsub("-","_",gsub("^-+","",opts$arg)))) 
    # arg_map[["intern"]] <- intern
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
    # arg_map[["intern"]] <- intern
    #### Body ####
    # func <- function(){}
    make_function_body <- function(new_path,
                                   fix_names){
        body <- quote({
            arg_list2 <- as.list(match.call(definition = func))[-1]
            ### Map back to original argument names 
            if(fix_names){ 
                # print(arg_list2)
                message("Mapping argument names to original version.")
                names(arg_list2) <- unname(arg_map[names(arg_list2)]) 
                # print(arg_list2)
            } 
            # if("intern" %in% names(arg_list2)){
            #     ## Check for special intern variable and then remove from list
            #     intern <- arg_list2[["intern"]]
            #     if(is.null(intern)) intern <- FALSE 
            #     arg_list2[["intern"]] <- NULL
            # }
            arg_strings <- lapply(names(arg_list2), function(nm){
                # message("Getting: ",nm)
                x <- eval(arg_list2[[nm]])
                if(nm=="..."){
                    return(x)
                } else if(all(is.null(x)) || all(x=="")) {
                    return("")
                } else if (any(x==TRUE)) {
                    return(paste(nm," "))
                } else {
                    return(paste(nm,x," "))
                }
            }) 
            cmd <- paste(new_path,  
                         paste(arg_strings, collapse = "")
                         )
            cmd_print(cmd = cmd)
            sys_out <- system(cmd, intern = TRUE ) 
            message("Output:")
            cat(paste(sys_out,collapse = '\n'))
            return(sys_out)
        })
        return(body)
    } 
    body <- make_function_body(new_path = new_path,
                               fix_names = fix_names)
    make_function <- function(body,
                              arg_list,  
                              env = parent.frame()) {  
        f <- function() {}
        formals(f) <- arg_list
        body(f) <- body
        environment(f) <- env
        return(f)
    }
   
    func <- make_function(body=body,
                          arg_list = arg_list)   
    # Sys.setenv()
    # paste(
    #     roxygen2::rd_section("title",pkg_name),
    #     roxygen2::rd_section("description",
    #                          paste(pkg_name,
    # "Imported by \\link[echoconda]{import_cli}"))
    # ) 
    return(func)
}
