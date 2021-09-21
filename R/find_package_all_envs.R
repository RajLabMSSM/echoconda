# 
# find_packages_all_envs <- function(package=NULL,
#                                    conda="auto"){
# 
#     # envs <- reticulate::conda_list()
#     # conda <- reticulate::conda_binary(conda = conda)
#     #
#     #
#     # pkgs_select <- lapply(envs$name, function(conda_env){
#     #     out <- system(paste(conda,"list -n",conda_env))
#     #     if(!is.null(package)){
#     #         pkgs <- grep(paste0("^",package,"$"),pkgs, value = TRUE)
#     #     }
#     #     return(pkgs)
#     # }) %>% `names<-`(envs$name)
# 
# 
# }