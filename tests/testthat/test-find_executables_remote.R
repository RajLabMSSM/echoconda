test_that("find_executables_remote works", {
    
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
