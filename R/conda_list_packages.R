#' List conda envs
#'
#' Alternative method for finding packages without relying on the (currently)
#' internal function \code{reticulate::conda_list_packages}.
#' 
#' @inheritParams find_packages
#' @inheritParams reticulate::conda_binary
#' @keywords internal
conda_list_packages <- function(conda_env,
                                conda = "auto",
                                verbose = TRUE){
    messager("Listing all packages in environment:",conda_env,v=verbose)
    conda_x <- reticulate::conda_exe(conda = conda)
    out <- system(paste(conda_x,"list -n",conda_env), intern = TRUE)
    pkgs <- data.table::fread(text = out, skip = 2, fill = TRUE)
    cnames <- colnames(pkgs)[-1]
    pkgs <- pkgs[,-5]
    colnames(pkgs) <- cnames
    data.table::setnames(pkgs,
                         c("Name","Version","Build","Channel"),
                         c("package","version","requirement","channel"))
    # python <- find_python_path(
    #     conda_env = conda_env,
    #     verbose = verbose
    # )
    # pkgs <- list.files(dirname(python), full.names = TRUE)
    return(pkgs)
}
