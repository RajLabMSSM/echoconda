test_that("activate_env works", {
    env_name <- env_from_yaml()
    testthat::expect_equal(
        env_name,
        if (env_exists("echoR")) "echoR" else "base"
    )

    conda_env <- activate_env(conda_env = "echoR")
    testthat::expect_equal(
        conda_env,
        if (env_exists("echoR")) "echoR" else "base"
    )

    conda_env <- activate_env(conda_env = "typo")
    testthat::expect_equal(conda_env, "base")
})
