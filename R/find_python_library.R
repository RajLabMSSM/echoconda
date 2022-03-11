find_python_library <- function(python){
    pylib <- system(paste(python,"-c 'import sys; print(sys.path)'"),
                    intern = TRUE)
    pylib  <- trimws(gsub("\\[|\\]|'","",strsplit(pylib,",")[[1]]))
    pylib <- pylib[stringr::str_length(pylib)>0]
    return(pylib)
}