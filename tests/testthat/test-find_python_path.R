test_that("find_python_path works", {
    
    env_name <- env_from_yaml(yaml_path = system.file(package = "echoconda", 
                                                      "conda/echoR.yml"))
    
    python <- find_python_path(conda_env = "echoR")
    testthat::expect_equal(basename(python), "python")

    python <- find_python_path(conda_env = NULL)
    testthat::expect_equal(basename(python), "python")

    python <- find_python_path(conda_env = "typo")
    testthat::expect_equal(basename(python), "python")
})
