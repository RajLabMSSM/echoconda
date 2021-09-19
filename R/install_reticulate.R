#' #' Install reticulate
#' #'
#' #' \emph{reticulate} often doesn't always install very well via CRAN.
#' #' This function helps do it correctly.
#' #'
#' #' @keywords internal
#' #' @importFrom utils installed.packages install.packages
#' install_reticulate <- function(dependencies = c(
#'                                    "devtools",
#'                                    "reticulate",
#'                                    "lattice",
#'                                    "jsonlite",
#'                                    "Matrix",
#'                                    "rappdirs",
#'                                    "Rcpp"
#'                                )) {
#'     if ("reticulate" %in% utils::installed.packages()) {
#'         messager("echoconda:: `reticulate` already installed.")
#'     } else {
#'         required_packages <-
#'             dependencies[!dependencies %in% utils::installed.packages()]
#'         if (length(required_packages) > 0) {
#'             for (lib in required_packages) {
#'                 utils::install.packages(lib, dependencies = T)
#'             }
#'         }
#'     }
#' }
