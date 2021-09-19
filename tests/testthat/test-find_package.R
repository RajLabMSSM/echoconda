test_that("find_package works", {
    
    env_name <- env_from_yaml(yaml_path = system.file(package = "echoconda", 
                                                      "conda/echoR.yml"))
    
    tabix <- find_package(package = "tabix", conda_env = "echoR")
    testthat::expect_equal(basename(tabix), "tabix")

    tabix <- find_package(package = "tabix", conda_env = NULL)
    testthat::expect_equal(basename(tabix), "tabix")

    tabix <- find_package(package = "tabix", conda_env = "typo")
    testthat::expect_equal(basename(tabix), "tabix")
})
