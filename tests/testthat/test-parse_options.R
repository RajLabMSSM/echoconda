test_that("parse_options works", {
  
    #### curl ####
    opts <- echoconda::parse_options(path="curl")
    testthat::expect_true(nrow(opts)>200 & nrow(opts)<300)
    #### wget ####
    opts <- echoconda::parse_options(path="wget")
    testthat::expect_true(nrow(opts)>100 & nrow(opts)<200)
    #### wget ####
    opts <- echoconda::parse_options(path="gunzip")
    testthat::expect_true(nrow(opts)>10 & nrow(opts)<20)
    
    #### Conda env #### 
    #### python ####
    path <- echoconda::find_packages("python",conda_env = "echoR",
                                     return_path = TRUE)
    opts <- echoconda::parse_options(path=path[['python']][1])
    testthat::expect_true(nrow(opts)>20 & nrow(opts)<40)
    #### r ####
    path <- echoconda::find_packages("r",conda_env = "echoR",
                                     return_path = TRUE)
    opts <- echoconda::parse_options(path=path[["r"]][1])
    testthat::expect_true(nrow(opts)>20 & nrow(opts)<40)
    #### radian ####
    out <- echoconda::find_packages("radian",conda_env = "echoR")
    opts <- echoconda::parse_options(path=unlist(out$path)[1])
    testthat::expect_true(nrow(opts)>10 & nrow(opts)<20)
    
    #### Not working ####
    # Don't follow --/- conventions as closely 
    # opts <- echoconda::parse_options(path="git")  
})
