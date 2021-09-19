test_that("env_from_yaml works", {
    env_name <- echoconda::env_from_yaml()
    testthat::expect_equal(env_name, "echoR")
})
