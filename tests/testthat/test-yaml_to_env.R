test_that("yaml_to_env works", {
  
    #### echoR ####
    conda_env <- echoconda::yaml_to_env()
    testthat::expect_equal(conda_env,"echoR")
    testthat::expect_true(echoconda::env_exists(conda_env = conda_env))
    
    #### test ####
    conda_env <- echoconda::yaml_to_env(yaml_path = "test")
    testthat::expect_equal(conda_env,"test")
    testthat::expect_true(echoconda::env_exists(conda_env = conda_env))
    reticulate::conda_remove(envname = "test")
    testthat::expect_false(echoconda::env_exists(conda_env = conda_env))
    
    #### test_bad ####
    conda_env <- echoconda::yaml_to_env(yaml_path = "test_bad")
    testthat::expect_equal(conda_env,"base")
    testthat::expect_false(echoconda::env_exists(conda_env = "test_bad"))
})
