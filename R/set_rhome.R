#' Set \code{R_HOME}
#' 
#' Set the location of your R library when it is being called through a python 
#' script (e.g. via the python package \pkg{rpy2}).
#' @inheritParams activate_env
#' 
#' @keywords internal
#' 
set_rhome <- function(conda_env="echoR_mini",
                      verbose=TRUE){
     
    # og_lib <- .Library
    # .libPaths()
    # .Library
    # Sys.getenv('R_HOME')
    # R.home(component = 'R')
    # "unset R_HOME &&",
    #### Find R lib location within conda env ####
    pkgs <- find_packages(packages = "Rscript", # "R"
                          conda_env = conda_env)
    cmd <- paste(pkgs$path,'-e',shQuote("cat(R.home())"))
    rhome_conda <- system(cmd, intern=TRUE) 
    rhome_conda <- rev(rhome_conda)[1]
    #### Set R lib location within conda env's python #####
    python <- find_python_path(conda_env = conda_env)
    set_rhome_py <- "~/Desktop/echoverse/echoconda/inst/python/set_rhome.py"
    # set_rhome_py <- system.file("python","set_rhome.py",package = "echoconda")
    cmd <- paste(python, 
                 set_rhome_py,
                 rhome_conda)
    rhome_new <- system(cmd, intern=TRUE) 
    if(rhome_new==rhome_conda){
        message("Success!")
    }
    return(rhome_new)
    
    # Sys.setenv(R_HOME=conda_lib) 
    # basilisk.utils::setVariable(name = "R_HOME", 
    #                             value = conda_lib) 
    # basilisk.utils::setVariable(name = "R_HOME", 
    #                             value = og_lib)  
    # os <- reticulate::import("os") 
    # os$environ$setdefault(key = "R_HOME",
    #                       value = conda_lib)
    # rpy2 <- reticulate::import("rpy2")
    
}
