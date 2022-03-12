test_that("find_python_path works", {
    
    conda_env <- echoconda::yaml_to_env(yaml_path = system.file(
        package = "echoconda",
        "conda/echoR.yml"
    ))
    #### In Windows, the executable is named "python.exe" ####
    python <- find_python_path(conda_env = "echoR")
    testthat::expect_true(startsWith(basename(python),"python"))

    python <- find_python_path(conda_env = NULL)
    testthat::expect_true(startsWith(basename(python),"python"))

    python <- find_python_path(conda_env = "typo") 
    testthat::expect_true(startsWith(python,"python"))
    
    #### Test multiple inputs ####
    env_names <- c("base","echoR")
    python <- find_python_path(conda_env = env_names)
    testthat::expect_equal(env_names,names(python))
    testthat::expect_true(all(startsWith(basename(python),"python")))
})
