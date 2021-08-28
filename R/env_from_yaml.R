#' Create conda env from yaml file
#'
#'
#' @param yaml_path Path to local or remote yaml file with conda build
#' specifications.
#'
#' @family conda
#' @export
env_from_yaml <- function(yaml_path = file.path(
                              "https://github.com",
                              "RajLabMSSM/echolocatoR",
                              "raw/master/inst",
                              "conda/echoR.yml"
                          )) {
    cmd <- paste("conda env create -f", yaml_path)
    print(cmd)
    system(cmd)
}
