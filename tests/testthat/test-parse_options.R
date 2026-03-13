test_that("parse_options works", {

    testthat::skip_on_os("windows")  # uses Unix shell piping (| tee)
    #### curl ####
    opts <- echoconda::parse_options(path="curl")
    testthat::expect_true(nrow(opts)>10 & nrow(opts)<15)
    #### wget ####
    opts <- echoconda::parse_options(path="wget")
    testthat::expect_true(nrow(opts)>100 & nrow(opts)<200)
    #### gunzip ####
    opts <- echoconda::parse_options(path="gunzip")
    testthat::expect_true(nrow(opts)>10 & nrow(opts)<20)
    
    #### Conda env ####
    #### python ####
    testthat::skip_if_not(
      echoconda::env_exists(conda_env = "echoR_mini"),
      message = "echoR_mini conda env not available"
    )
    path <- echoconda::find_packages(packages = "python",
                                     conda_env = "echoR_mini",
                                     return_path = TRUE)
    opts <- echoconda::parse_options(path=path[['python']][1])
    testthat::expect_true(nrow(opts)>20 & nrow(opts)<40)
    
    #### Not working ####
    # Don't follow --/- conventions as closely 
    # opts <- echoconda::parse_options(path="git")  
})
