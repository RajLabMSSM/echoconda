test_that("find_env_rlib works", {
    env_name <- env_from_yaml(yaml_path = system.file(
        package = "echoconda",
        "conda/echoR.yml"
    ))

    env_Rlib <- find_env_rlib(conda_env = "echoR")
    testthat::expect_type(env_Rlib, "character")

    env_Rlib <- find_env_rlib(conda_env = NULL)
    testthat::expect_type(env_Rlib, "character")
})
