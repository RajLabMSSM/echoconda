#' Parse options
#' 
#' Parse the available options (arguments) for a given command line tool.
#' @param path Path to executable file.
#' @param command Modifying command for tool 
#'  (e.g. "submodule" when running "git submodule add").
#' @param subcommand Modifying subcommand for tool
#'  (e.g. "add" when running "git submodule add").
#' @param help_args Help arguments to use when identifying argument options.
#' @param args_sep Regex pattern that separates each new argument.
#' @param args_start Regex pattern to search for when detecting the beginning 
#' of each argument description.
#' @param col_names Column names after parsing.
#' @param verbose Print messages.
#' @export
#' @importFrom dplyr %>%
#' @examples  
#' opts <- echoconda::parse_options(path="curl")
parse_options <- function(path,
                          command=NA,
                          subcommand=NA,
                          help_args = c("-h","--help","-help","-H"),
                          args_sep="\n",
                          args_start="-+[a-z]+", 
                          col_names = c("arg","description"),
                          verbose = TRUE){
    requireNamespace("stringr")
    requireNamespace("readr")
    requireNamespace("tidyr")
    V1 <- arg <- base <- NULL;
    # echoverseTemplate:::args2vars(parse_options); 
    # echoverseTemplate:::source_all()
    
    path_orig <- path 
    #### Append commands/subcommands #####
    if(!is.na(command)) path <- paste(path,command)
    if(!is.na(subcommand)) path <- paste(path,subcommand) 
    help_out <- import_help(path = path, 
                            help_args = help_args, 
                            verbose = verbose)
    #### Parse the options ####   
    messager("Parsing options from help output.",v=verbose) 
     
    txt <- help_out %>%
        stringr::str_split(pattern = args_sep,
                           simplify = TRUE) %>%
        trimws() %>%  
        grep(pattern = paste0("^",args_start),
             ignore.case = TRUE, value = TRUE) %>%
        gsub(pattern = "\n",replacement = "") %>%
        gsub(pattern = " +",replacement = " ")  
     
    #### Check for subcommands #### 
    dat <- data.table::data.table(base=basename(path_orig),
                                  command=command,
                                  subcommand=subcommand,
                                  V1=txt) %>% 
        tidyr::separate(col = V1, sep=" ",
                        into = col_names,
                        extra = "merge")  %>%
        dplyr::mutate(arg=trimws(gsub(",","",arg)),
                      giftwrap_command= dplyr::coalesce(
                          base,command,subcommand
                          ),
                      .before=arg) 
    messager("Parsed",nrow(dat),"options from",dat$giftwrap_command[1],
             v=verbose)
    return(dat) 
} 
