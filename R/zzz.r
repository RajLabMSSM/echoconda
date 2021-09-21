# following advice from https://rstudio.github.io/reticulate/articles/python_dependencies.html#onload-configuration
# not sure what exactly this does yet, though
.onLoad <- function(libname, pkgname) {
    .conda_dir <- "./.conda"
    Sys.setenv("CONDA_ENVS_DIRS"=file.path(.conda_dir,"pkgs"),
               "CONDA_PKGS_DIRS"=file.path(.conda_dir,"envs")
    )
  reticulate::configure_environment(pkgname)
}
