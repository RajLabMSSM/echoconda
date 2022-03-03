test_that("env_to_yaml works", {
  
    #### base ####
    path_base <- echoconda::env_to_yaml(conda_env="base")
    l_base <- readLines(path_base)
    testthat::expect_gte(length(l_base), 400)
    testthat::expect_equal(echoconda:::name_from_yaml(path_base),"base")

    #### echoR ####
    path_echor <- echoconda::env_to_yaml(conda_env="echoR")
    l_echor <- readLines(path_echor)
    testthat::expect_gte(length(l_echor), 400)
    testthat::expect_equal(echoconda:::name_from_yaml(path_echor),"echoR")
})
