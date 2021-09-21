#' #' List all package installed in a conda env
#' #' 
#' #' 
#' #' @importFrom jsonlite fromJSON
#' conda_list_packages <- function(envname = NULL, 
#'                                 conda = "auto", 
#'                                 no_pip = TRUE) {
#'     python_environment_resolve <- function(envname = NULL,
#'                                            resolve = identity) { 
#'         # use RETICULATE_PYTHON_ENV as default
#'         envname <- envname %||% Sys.getenv("RETICULATE_PYTHON_ENV",
#'                                            unset = "r-reticulate") 
#'         # treat environment 'names' containing slashes as full paths
#'         if (grepl("[/\\]", envname)) {
#'             envname <- normalizePath(envname, winslash = "/",
#'                                      mustWork = FALSE)
#'             return(envname)
#'         } 
#'         # otherwise, resolve the environment name as necessary
#'         promises::resolve(envname) 
#'     }
#'     
#'     condaenv_resolve <- function(envname = NULL) {
#'         
#'         python_environment_resolve(
#'             envname = envname,
#'             resolve = identity
#'         )
#'         
#'     }
#'     conda <- reticulate::conda_binary(conda)
#'     envname <- condaenv_resolve(envname)
#'     
#'     # create the environment
#'     args <- c("list")
#'     if (grepl("[/\\]", envname)) {
#'         args <- c(args, "--prefix", envname)
#'     } else {
#'         args <- c(args, "--name", envname)
#'     }
#'     
#'     if (no_pip)
#'         args <- c(args, "--no-pip")
#'     
#'     args <- c(args, "--json")
#'     
#'     output <- system2(conda, shQuote(args), stdout = TRUE)
#'     status <- attr(output, "status") %||% 0L
#'     if (status != 0L) {
#'         fmt <- "error listing conda environment [status code %i]"
#'         stopf(fmt, status)
#'     }
#'     
#'     parsed <- jsonlite::fromJSON(output)
#'     
#'     pkgs <- data.frame(
#'         package     = parsed$name,
#'         version     = parsed$version,
#'         requirement = paste(parsed$name, parsed$version, sep = "="),
#'         channel     = parsed$channel,
#'         stringsAsFactors = FALSE
#'     )
#'     return(pkgs) 
#' }