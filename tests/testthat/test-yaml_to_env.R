test_that("yaml_to_env works", {
  
    conda_env <- echoconda::yaml_to_env()
    testthat::expect_equal(conda_env,"echoR")
    testthat::expect_true(echoconda::env_exists(conda_env = conda_env))
})
