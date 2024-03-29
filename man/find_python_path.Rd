% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_python_path.R
\name{find_python_path}
\alias{find_python_path}
\title{Find the python file for a specific env}
\usage{
find_python_path(
  conda_env = "echoR_mini",
  method = c("basilisk", "reticulate"),
  verbose = TRUE
)
}
\arguments{
\item{conda_env}{Conda environment name.}

\item{method}{Method to use:
\itemize{
\item{"basilisk"}
\item{"reticulate"}
}}

\item{verbose}{Print messages.}
}
\description{
Find the python file for a specific env
}
\examples{
# importFrom reticulate conda_list
python <- find_python_path(conda_env = "echoR")
}
\concept{echoconda}
