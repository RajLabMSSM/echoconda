test_that("activate_env works", {
    
    conda_env <- echoconda::activate_env(conda_env = "echoR")
    testthat::expect_equal(
        conda_env,
        if (echoconda::env_exists("echoR")) "echoR" else "base"
    )

    conda_env <- echoconda::activate_env(conda_env = "base")
    testthat::expect_equal(conda_env, "base")
})
