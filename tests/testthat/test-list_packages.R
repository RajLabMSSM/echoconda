test_that("list_packages works", {
    
    requireNamespace("microbenchmark")
    
    conda_env <- echoconda::yaml_to_env()
    
    method <- eval(formals(echoconda:::list_packages)$method)
    micro_res <- microbenchmark::microbenchmark(
        reticulate={res1 <- echoconda:::list_packages(conda_env = conda_env,
                                                      method = "reticulate")}, 
        basilisk={res2 <- echoconda:::list_packages(conda_env = conda_env,
                                                    method = "basilisk")},
        r={res3 <- echoconda:::list_packages(conda_env = conda_env,
                                             method = "r")}, 
        times = 1, unit = "s"
    )
    testthat::expect_gte(nrow(res1),200)
    testthat::expect_gte(nrow(res2),70)
    testthat::expect_gte(nrow(res3),350)
})
