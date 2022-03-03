test_that("list_yamls works", {
  
    yamls <- echoconda::list_yamls()
    testthat::expect_true(methods::is(yamls,"data.table"))
    testthat::expect_gte(nrow(yamls), 17) 
    testthat::expect_true("echoR" %in% yamls$conda_env) 
})
