chmod_translate_codes <- function(permissions="rwx",
                                  from_numbers=FALSE){
    key <- c("---"=0,
             "--x"=1,
             "-w-"=2,
             "-wx"=3,
             "r--"=4,
             "r-x"=5,
             "rw-"=6,
             "rwx"=7)
    if(from_numbers){
        key_inv <- stats::setNames(names(key),unname(key))
        out <- paste(key_inv[strsplit(as.character(permissions),"")[[1]]],
                     collapse = " ")
    }else {
        out <- paste(key[strsplit(permissions," ")[[1]]],collapse = "")
    } 
    return(out)
}