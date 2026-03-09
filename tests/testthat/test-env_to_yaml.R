test_that("env_to_yaml works", {

    testthat::skip_on_cran()
    testthat::skip_if_not(
      echoconda::env_exists(conda_env = "echoR_mini"),
      message = "echoR_mini conda env not available"
    )

    #### base ####
    path_base <- env_to_yaml(conda_env="base")
    l_base <- readLines(path_base)
    # testthat::expect_gte(length(l_base), 400)
    echoconda:::messager(length(l_base),"lines in exported env yaml:","base")
    # utils::head(l_base)
    testthat::expect_equal(echoconda:::name_from_yaml(path_base),"base")

    #### echoR_mini ####
    conda_env <- yaml_to_env()
    path_echor <- env_to_yaml(conda_env="echoR_mini")
    l_echor <- readLines(path_echor)
    # testthat::expect_gte(length(l_echor), 400)
    echoconda:::messager(length(l_echor),"lines in exported env yaml:","echoR_mini")
    # utils::head(l_echor)
    testthat::expect_equal(echoconda:::name_from_yaml(path_echor),"echoR_mini")
})
