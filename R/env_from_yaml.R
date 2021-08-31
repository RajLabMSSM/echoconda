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
    install_conda()
    lines <- readLines(yaml_path)
    env_name <- trimws(gsub("name: ","",grep('name:',lines,value = TRUE)))
    cmd <- paste("conda env create -f", yaml_path)
    print(cmd)
    system(cmd)
    message("Conda environment '",env_name,"' created.")
    return(env_name)
}
