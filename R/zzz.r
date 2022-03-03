# following advice from https://rstudio.github.io/reticulate/articles/python_dependencies.html#onload-configuration
# not sure what exactly this does yet, though
# RETICULATE_AUTOCONFIGURE: https://rstudio.github.io/reticulate/reference/configure_environment.html
.onLoad <- function(libname, pkgname) { 
  #### Find dir where user has write permissions ####
    # .conda_dir <- find_install_dir(dest_dir_opts = c(
    #   # dirname(dirname(reticulate::conda_binary())),
    #   tools::R_user_dir(package = "echoconda",which = "cache"),
    #   "./.conda"
    # ))
    # #### Set that dir as the location where conda envs will be installed ####
    # Sys.setenv("CONDA_ENVS_DIRS"=file.path(.conda_dir,"pkgs"),
    #            "CONDA_PKGS_DIRS"=file.path(.conda_dir,"envs"),
    #            "RETICULATE_AUTOCONFIGURE" = FALSE
    # )
  reticulate::configure_environment(pkgname)
}
