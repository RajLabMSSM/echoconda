% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/env_to_yaml.R
\name{env_to_yaml}
\alias{env_to_yaml}
\title{Create yaml file from env}
\source{
\href{https://github.com/rstudio/reticulate/issues/779}{
GitHub Issue}

\href{https://github.com/datitran/object_detector_app/issues/41}{
GitHub Issue}
}
\usage{
env_to_yaml(
  conda_env,
  yaml_path = file.path(tempdir(), "conda.yml"),
  conda = "auto",
  method = c("reticulate", "basilisk"),
  verbose = TRUE,
  ...
)
}
\arguments{
\item{conda_env}{Name of the conda environment to export.}

\item{yaml_path}{Path to write yaml file to.}

\item{conda}{The path to a \code{conda} executable. Use \code{"auto"} to allow
\code{reticulate} to automatically find an appropriate \code{conda} binary.
See \strong{Finding Conda} and \code{\link[reticulate:conda_binary]{conda_binary()}} for more details.}

\item{method}{Method to use:
\itemize{
\item{"basilisk"}
\item{"reticulate"}
}}

\item{verbose}{Print messages.}

\item{...}{Additional arguments passed to \link[reticulate]{conda_create}.}
}
\description{
Export a yaml file from a conda environment.
}
\examples{
path <- env_to_yaml(conda_env="base")
}
\seealso{
Other conda: 
\code{\link{activate_env}()},
\code{\link{find_env_rlib}()},
\code{\link{yaml_to_env}()}
}
\concept{conda}
