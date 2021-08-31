test_that("find_env_rlib works", {
    
    env_Rlib <- find_env_rlib(conda_env = "echoR")
    testthat::expect_type(env_Rlib, "character")
    
    env_Rlib <- find_env_rlib(conda_env = NULL)
    testthat::expect_type(env_Rlib, "character") 
})
