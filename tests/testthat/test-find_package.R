test_that("find_package works", {
  
    tabix <- find_package(package = "tabix", conda_env = "echoR")
    testthat::expect_equal(basename(tabix),"tabix")
    
    
    tabix <- find_package(package = "tabix", conda_env = NULL)
    testthat::expect_equal(basename(tabix),"tabix")
})
