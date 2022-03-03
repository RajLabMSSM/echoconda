test_that("find_packages works", {
    
    conda_env <- echoconda::yaml_to_env()
    
    #### dplyr ####
    pkgs1 <- echoconda::find_packages(packages = "dplyr",
                                      conda_env = "echoR")
    testthat::expect_equal(nrow(pkgs1), 1)
    testthat::expect_equal(pkgs1$package, "r-dplyr")
    
    #### r-dplyr ####
    pkgs2 <- echoconda::find_packages(packages = "r-dplyr",
                                      conda_env = "echoR")
    testthat::expect_equal(nrow(pkgs2), 1)
    testthat::expect_equal(pkgs2$package, "r-dplyr")
    
    #### multiple pkgs in multiple envs ####
    pkgs3 <- echoconda::find_packages(packages = c("r-dplyr","wget","numpy"),
                                      conda_env = c("base","echoR"))
    testthat::expect_gte(nrow(pkgs3), 4)
    testthat::expect_equal(sort(unique(pkgs3$package)),
                           c("numpy","r-dplyr","wget"))
    
    #### typo ####
    pkgs4 <- find_packages(packages = "typooooooo", 
                           conda_env = "echoR")
    testthat::expect_equal(nrow(pkgs4), 1)
    testthat::expect_true(is.na(pkgs4$package))
})
