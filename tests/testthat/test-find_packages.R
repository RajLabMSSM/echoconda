test_that("find_packages works", {
    
    conda_env <- echoconda::yaml_to_env()
    
    #### python packages: default ####
    pkgs1 <- echoconda::find_packages(packages = c("pyarrow","pandas"), 
                                      conda_env = "echoR_mini",
                                      method = "r")
    testthat::expect_equal(nrow(pkgs1), 0)
    pkgs1b <- echoconda::find_packages(packages = c("pyarrow","pandas"), 
                                      conda_env = "echoR_mini",
                                      method = "reticulate")
    testthat::expect_equal(nrow(pkgs1b), 2)
    testthat::expect_equal(pkgs1b$package, sort(c("pyarrow","pandas")))
    
    #### tabix ####
    pkgs2 <- echoconda::find_packages(packages = "tabix", 
                                      conda_env = "echoR_mini")
    testthat::expect_equal(nrow(pkgs2), 1)
    testthat::expect_equal(pkgs2$package, "tabix")
    
    #### multiple pkgs in multiple envs #### 
    ## method="reticulate"
    packages <- c("python","wget","tabix","pandas")
    pkgs3 <- echoconda::find_packages(packages = packages,
                                      conda_env = c("base","echoR_mini"),
                                      method="reticulate")
    testthat::expect_gte(nrow(pkgs3), 5)
    testthat::expect_equal(sum(sapply(pkgs3$path, length)==0), 1)
    testthat::expect_equal(sort(unique(pkgs3$package)),
                           sort(packages))
    ## method="r"
    pkgs3b <- echoconda:: find_packages(packages = packages,
                                       conda_env = c("base","echoR_mini"), 
                                       method="r")
    testthat::expect_gte(nrow(pkgs3b), 4)
    testthat::expect_equal(sum(sapply(pkgs3b$path, length)==0), 0)
    testthat::expect_equal(sort(unique(pkgs3b$package)),
                           sort(packages)[-1])
    
    #### typo #### 
    pkgs4 <- find_packages(packages = "typooooooo", 
                           conda_env = "echoR_mini")
    testthat::expect_equal(nrow(pkgs4), 0) 
})
