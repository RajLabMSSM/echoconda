test_that("yaml_to_env works", {
  
    #### echoR_mini: reticulate ####
    ## Finishes in ~3.1 minutes
    # conda_env <- echoconda::yaml_to_env(method = "reticulate")
    # testthat::expect_equal(conda_env,"echoR_mini")
    # testthat::expect_true(echoconda::env_exists(conda_env = conda_env))
    
    #### echoR_mini: basilisk ####
    ## Finishes in ~2.6 minutes 
    conda_env <- echoconda:: yaml_to_env(method = "basilisk", 
                                         force_new = TRUE)
    testthat::expect_equal(conda_env,"echoR_mini")
    testthat::expect_true(echoconda::env_exists(conda_env = conda_env))
    
    #### test ####
    ## Finishes in ~20 seconds
    conda_env <- echoconda::yaml_to_env(yaml_path = "test")
    testthat::expect_equal(conda_env,"test")
    testthat::expect_true(echoconda::env_exists(conda_env = conda_env))
    removed2 <- echoconda::remove_env(conda_env = "test")
    testthat::expect_false(echoconda::env_exists(conda_env = conda_env)) 
    
    #### test_bad ####
    ## Finishes in ~10 seconds
    testthat::expect_error(
        conda_env <- echoconda::yaml_to_env(yaml_path = "test_bad")
    )
    testthat::expect_false(echoconda::env_exists(conda_env = "test_bad"))
})
