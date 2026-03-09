test_that("find_env_rlib works", {

    testthat::skip_on_cran()
    testthat::skip_if_not(
      echoconda::env_exists(conda_env = "echoR_mini"),
      message = "echoR_mini conda env not available"
    )

    conda_env <- yaml_to_env()

    env_Rlib <- find_env_rlib(conda_env = conda_env)
    # testthat::expect_equal(basename(dirname(dirname(dirname(env_Rlib)))),
    #                        "echoR_mini")

    # env_Rlib <- find_env_rlib(conda_env = NULL)
    # testthat::expect_true(dir.exists(env_Rlib))
})
