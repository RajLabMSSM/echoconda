test_that("activate_env works", {
    
    testthat::expect_null(activate_env(conda_env = "echoR"))
    testthat::expect_null(activate_env(conda_env = "typo"))
})
