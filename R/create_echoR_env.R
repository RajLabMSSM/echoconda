#' #' Create conda env for \pkg{echolocatoR}
#' #'
#' #' Create a new env (or update and existing one)
#' #' with the necessary Python, R, and command line packages
#' #' to run \pkg{echolocatoR}.
#' #'
#' #' By default uses \emph{echoR},
#' #' the conda environment distributed with \pkg{echolocatoR}.
#' #'
#' #' \itemize{
#' #' \item{plink}{https://anaconda.org/bioconda/plink}
#' #' \item{tabix}{https://anaconda.org/bioconda/tabix}
#' #' }
#' #' @family conda
#' #'
#' #' @param conda_env The name of the conda env you want to create.
#' #' @param python_packages Python packages to install.
#' #' @param r_packages R packages to install.
#' #' @param cli_packages Command Line Interface packages to install.
#' #' @param force_install If env already exists, force create a new one.
#' #' @param auth_token GitHub authentication token.
#' #' @inheritParams reticulate::conda_install
#' #'
#' #' @export
#' #' @importFrom reticulate conda_list conda_install
#' #' @importFrom devtools install_github github_pat
#' create_echoR_env <- function(conda_env = "echoR",
#'                              python_version = NULL,
#'                              channel = c("conda-forge", "bioconda", "r"),
#'                              python_packages = c(
#'                                  "pandas>=0.25.0",
#'                                  "pyarrow",
#'                                  "scikit-learn",
#'                                  "bitarray",
#'                                  "networkx",
#'                                  "rpy2",
#'                                  "scipy",
#'                                  "pandas-plink"
#'                              ),
#'                              r_packages = c(
#'                                  "r-base",
#'                                  # "r>=3.6.3",
#'                                  "r-devtools"
#'                                  # "r-biocmanager",
#'                                  # "r-reticulate",
#'                                  # "r-data.table",
#'                                  # "r-ggplot2",
#'                                  # "r-wavethresh",
#'                                  # "r-lattice",
#'                                  # "r-ckmeans.1d.dp",
#'                                  # "r-stringi",
#'                                  # "r-matrixstats",
#'                                  # "r-expm",
#'                                  # "r-rlang",
#'                                  # "r-xgr",
#'                              ),
#'                              cli_packages = c(
#'                                  "tabix",
#'                                  "plink",
#'                                  "macs2"
#'                              ),
#'                              force_install = FALSE,
#'                              auth_token = devtools::github_pat()) {
#'     # Avoid confusing checks
#'     envname <- NULL
#'
#'     # Make sure conda is installed to begin with
#'     install_conda()
#'     # conda_path <- reticulate::conda_binary()
#'     envs <- reticulate::conda_list()$name
#'     if (!envname %in% envs | force_install) {
#'         reticulate::conda_install(
#'             envname = conda_env,
#'             packages = c(
#'                 python_packages,
#'                 r_packages,
#'                 cli_packages
#'             ),
#'             channel = channel,
#'             python_version = python_version
#'         )
#'     }
#'     activate_env(conda_env = conda_env)
#'     # Get the path to the conda env
#'     env_path <- dirname(dirname(find_python_path(conda_env = conda_env)))
#'     env_Rlib <- find_env_rlib(conda_env = conda_env)
#'     # Have echolocatoR install itself into the new env
#'     devtools::install_github(
#'         repo = "RajLabMSSM/echolocatoR",
#'         auth_token = auth_token,
#'         upgrade = "always",
#'         lib = env_Rlib,
#'         force = TRUE
#'     )
#'     return(env_path)
#' }
