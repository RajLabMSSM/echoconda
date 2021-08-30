test_that("multiplication works", {
  
    python <- find_python_path(conda_env = "echoR")
    testthat::expect_equal(basename(python),"python")
})
