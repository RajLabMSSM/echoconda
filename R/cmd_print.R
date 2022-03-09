#' Neatly print commands
#' 
#' Neatly print commands sent to the command line.
#' @param cmd Command string or list of strings.
#' @param raw Print the raw \code{cmd} text.
#' @param basepath For each component of \code{cmd} that is a path,
#'  shorten the path to just the basename.
#' @param prefix When \code{basepath=TRUE}, append a prefix to the path.
#' @param wrap If \code{wrap} is not \code{NULL}, 
#' use this to separate arguments with newlines.
#' @param verbose Print messages.
#' @export
#' @examples
#' cmd_print("fastqc -d ./fastqc_temp -o ${workdir}
#'           /fastqFileQC/${sample_name} -f fastq")
cmd_print <- function(cmd,
                      raw=FALSE,
                      basepath=TRUE,
                      prefix="...",
                      wrap="\n   ",
                      verbose=TRUE){
    cmd <- paste(cmd,collapse = " ")
    if(verbose){
        if(raw){
            cat(cmd)
        } else {
            if(basepath){
                split <- strsplit(cmd," ")[[1]]
                cmd <- paste(
                    lapply(split, function(l){ 
                        if(grepl("[/]|[\\]",l)){
                            if(tolower(basename(l)) %in% c("python","r") |
                               endsWith(tolower(basename(l)),".py") ){
                                basename(l)
                            } else {
                                file.path(prefix,basename(l))
                            }
                            
                        } else {l}
                    }),
                    collapse = " "
                )
            }
            if(!is.null(wrap)){
                cmd <- gsub(" --",paste0(wrap," --"),cmd) 
                cmd <- gsub(" -",paste0(wrap," -"),cmd) 
            }
            cat(cmd)
        } 
    }
}
