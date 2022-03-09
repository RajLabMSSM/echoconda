#' Set permissions
#' 
#' Robust methods for setting file/folder permissions 
#' across multiple OS platforms.  
#' @param path Path to file/folder.
#' @param recursive If \code{path} is a folder, 
#' set permissions set recursively for all files/subfolders within it
#'  (default: \code{TRUE}). 
#' @param permissions Permissions to set. 
#' Defaults to "rwx" (i.e. "read","write" and "execute") for all users.
#' @param verbose Print messages. 
#' @export
#' @examples 
#' path <- tempfile()
#' set_permissions(path=path)
set_permissions <- function(path,
                            recursive = FALSE,
                            permissions="rwx",
                            verbose = TRUE){ 
    messager("Setting permissions for",
             paste0(if(recursive)"folder"else"file","."),
             v=verbose)
    #### OS-specific commands ####
    if(get_os()=="Windows"){
        try({system(paste("icacls",
                          path,
                          if(recursive) "/t" else NULL,
                          if(verbose) NULL else "/q",
                          "/grant:r Everyone:(OI)(CI)RX"))})
    } else {
        try({system(paste("chmod",
                          if(recursive) "-R" else NULL,
                          paste0("u=",permissions,",go=",permissions),
                          path))})
    }
    #### Should work on all OS (maybe?) #### 
    try({Sys.chmod(paths = path,
                   mode = chmod_translate_codes(
                       permissions = paste(permissions,
                                           permissions,
                                           permissions,
                                           collapse = " ")
                       ),
                   use_umask = FALSE)})
}
