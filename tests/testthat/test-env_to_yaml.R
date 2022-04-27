test_that("env_to_yaml works", {
  
    #### base ####
    path_base <- echoconda::env_to_yaml(conda_env="base")
    l_base <- readLines(path_base)
    # testthat::expect_gte(length(l_base), 400)
    echoconda:::messager(length(l_base),"lines in exported env yaml:","base")
    utils::head(l_base)
    testthat::expect_equal(echoconda:::name_from_yaml(path_base),"base")

    #### echoR ####
    path_echor <- echoconda::env_to_yaml(conda_env="echoR")
    l_echor <- readLines(path_echor)
    # testthat::expect_gte(length(l_echor), 400)
    echoconda:::messager(length(l_echor),"lines in exported env yaml:","echoR")
    utils::head(l_echor)
    testthat::expect_equal(echoconda:::name_from_yaml(path_echor),"echoR")
})
