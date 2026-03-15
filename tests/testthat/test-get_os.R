test_that("get_os returns valid OS string", {
    os <- echoconda:::get_os()
    expect_true(os %in% c("Windows", "Linux", "Mac"))
    # On this machine it should be non-empty
    expect_true(nchar(os) > 0)
})

test_that("get_os matches Sys.info sysname", {
    os <- echoconda:::get_os()
    sysname <- Sys.info()[["sysname"]]
    expected <- switch(sysname,
        Windows = "Windows",
        Linux = "Linux",
        Darwin = "Mac",
        ""
    )
    expect_equal(os, expected)
})
