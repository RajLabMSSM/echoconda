#' List conda envs
#'
#' Alternative method for finding packages without relying on the (currently)
#' internal function \code{reticulate::conda_list_packages}. 
#' 
#' @inheritParams find_conda
#' @inheritParams find_packages
#' @inheritParams reticulate::conda_binary
#' @keywords internal
#' @importFrom basilisk listPackages
#' @importFrom data.table tstrsplit
#' @importFrom utils getFromNamespace
list_packages <- function(packages = NULL,
                          conda_env,
                          method = c("r","reticulate","basilisk"),
                          conda = "auto",
                          verbose = TRUE){
    package <- full <- NULL; 
    method <- tolower(method)[1]
    #### Get conda executable ####  
    envs <- list_envs(conda_env = conda_env, 
                      conda = conda)
    #### List packages  #### 
    messager("Listing all packages in environment:",conda_env,v=verbose)
    #### Method 0 ####
    if(method=="r"){
        pkg_paths <- list.files(
            path = file.path(envs$dir,"bin"), 
            pattern = if(is.null(packages)) {NULL} else {
                paste(packages,collapse = "|")
            },
            full.names = TRUE)
        pkgs <- data.table::data.table(package=basename(pkg_paths),
                                       path=pkg_paths)
    #### Method 1 ####
    } else if(method=="basilisk"){ 
        pkgs <- basilisk::listPackages(env = envs$dir[1])
        pkgs <- data.table::data.table(pkgs)
        pkgs[,"version":=data.table::tstrsplit(full,"==",
                                               fixed=TRUE,keep = 2L),]
    
    #### Method 2 ####
    ## reticulate seems to return far more packages than basilisk
    } else if(method=="reticulate"){
        ## Not yet exported in CRAN release of reticulate? 
        conda_list_packages <- utils::getFromNamespace(
            x = "conda_list_packages",
            ns = "reticulate")
        pkgs <- conda_list_packages(envname = envs$dir)
        pkgs <- data.table::data.table(pkgs)
    }else {
        messager("method must be one of:",
                 paste("\n -",eval(formals(list_packages)$method),
                       collapse = "")
                 )
    } 
    # #### Method 3 ####
    # out <- system(paste(conda_x,"list -n",conda_env), intern = TRUE)
    # pkgs <- data.table::fread(text = out, skip = 2, fill = TRUE)
    # cnames <- colnames(pkgs)[-1]
    # pkgs <- pkgs[,-5]
    # colnames(pkgs) <- cnames
    # data.table::setnames(
    #     x = pkgs,
    #     old = c("Name","Version","Build","Channel"),
    #     new = c("package","version","requirement","channel"))  
    
    ##### Subset to only requested package(s) #### 
    if(!is.null(packages)){
        pkgs <- pkgs[prep_pkg_names(package) %in% prep_pkg_names(packages),]
    }
    pkgs <- cbind(env=rep(conda_env,nrow(pkgs)), pkgs)
    pkgs <- pkgs[!is.na(package),]
    return(pkgs)
}
