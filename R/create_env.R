#' Create conda env
#' 
#' Create conda env using one of several methods.
#' @keywords internal
#' @inheritParams yaml_to_env
#' @inheritParams reticulate::conda_create
create_env <- function(conda_env,
                       yaml_path,
                       method=c("reticulate","basilisk","cli"),
                       conda="auto",
                       force_new=FALSE,
                       verbose=TRUE){
    messager("echoconda:: Creating conda environment:", conda_env,
             v = verbose
    ) 
    method <- tolower(method)[1] 
    if(method=="basilisk" & (!startsWith(conda_env,"echoR"))){
        messager("method cannot be 'basilisk'",
                 "when creating non-echoR conda envs.",
                 "Changing method to 'reticulate'.",
                 v=verbose)
        method <- "reticulate"
    }
    conda_env <- tryCatch(expr = { 
        #### reticulate ####
        if(method=="reticulate"){
            reticulate::conda_create(envname = conda_env,
                                     environment = yaml_path, 
                                     conda = conda)
        #### basilisk ####
        } else if(method=="basilisk"){
            pkgs <- data.table::fread(
                system.file(package = "echoconda","conda/echoR_versions.tsv.gz")
            )  
            envObj <- create_env_basilisk(yaml_path = yaml_path,
                                          pkgs = pkgs,
                                          start = TRUE)
            conda_env <- envObj@envname
            
        #### cli ####
        } else if(method=="cli"){
            conda_env <- create_env_cli(yaml_path = yaml_path,
                                        conda = conda, 
                                        force_new = force_new,
                                        verbose = verbose)
        } else {
            stp <- paste("method must be one of:",
                         paste("\n -",eval(formals(create_env)$method)))
            stop(stp)
        }
        #### Double check that env exists ####
        if(env_exists(conda_env = conda_env,
                      conda = conda)){
            messager("echoconda:: Conda environment created:",
                     conda_env,
                     v = verbose
            )
        ## If it doesn't, return an error, which will trigger the tryCatch 
        ## to return 'base'.
        } else {stop()}
        conda_env
    }, error = function(e) {
        message(e);
        messager("echoconda:: Conda enviroment creation failed.",
                 "Defaulting to enviroment 'base'.",
                 v = verbose
        )
        "base"
    })
    return(conda_env)
}
