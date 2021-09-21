cleanup_conda <- function(no_no_dir){
    if(dir.exists(no_no_dir)){
        try({
            removed <- suppressWarnings(file.remove(no_no_dir))
        })
    }  
}