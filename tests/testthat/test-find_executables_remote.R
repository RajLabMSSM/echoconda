test_that("find_executables_remote works", {

    testthat::skip_on_cran()
    testthat::skip_if_not(
      echoconda::env_exists(conda_env = "echoR_mini"),
      message = "echoR_mini conda env not available"
    )

    if(.Platform$OS.type=="windows"){
        # bctools binary not provided for windows
        testthat::expect_error(
            find_executables_remote()
        )
    } else { 
        paths <- find_executables_remote()
        testthat::expect_true(all(unlist(lapply(paths, file.exists))))
    }  
})
