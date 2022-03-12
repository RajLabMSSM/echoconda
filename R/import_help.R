import_help <- function(path,
                        help_args = c("-h","--help","-help","-H"),
                        exceptions="axel",
                        verbose=TRUE){
    #### Enter nonsense command to get output of incorrect argument ####
    {
        typo_str <- "-typooo"
        ### Some packages report the help file even when you give totally
        ## wrong inputs.
        if(tolower(basename(path)) %in% tolower(exceptions)){
            out_wrong <- "WRONG INPUTS"
        } else {
            tmp <- tempfile(fileext = "1.txt") 
            empty <- system(paste(path,typo_str,"2>&1 | tee",tmp,"&"),
                            intern = TRUE) 
            ## Wait until the file is written
            Sys.sleep(1)
            out_wrong <- readr::read_file(tmp)
        } 
    }   
    #### Find the appropriate help flag #### 
    valid_h <- FALSE
    for(h in help_args){
        messager("Testing help_flag:",h,v=verbose) 
        tmp2 <- tempfile(fileext = "-2.txt")
        empty <- system(paste(path,h,"2>&1 | tee",tmp2,"&"),
                        intern = TRUE) 
        ## Wait until the file is written
        Sys.sleep(1)
        out <- readr::read_file(tmp2)
        if((out=="") | (out==gsub(typo_str,h,out_wrong))){
            next()    
        } else {
            messager("Settled on using",h,"flag.",v=verbose)
            system(paste(path,h))
            valid_h <- TRUE
            break()
        } 
    }  
    if(valid_h==FALSE) stop("Could not identify any used help_flags.") 
    return(out)
}