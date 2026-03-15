test_that("find_conda errors with unrecognized method", {
    expect_error(
        echoconda::find_conda(method = "nonexistent_method"),
        "method not recognized"
    )
})

test_that("find_conda with basilisk method returns path or errors gracefully", {
    # This test exercises the logic branches -- it will either find conda
    # (returning a valid path) or throw a controlled error
    result <- tryCatch(
        echoconda::find_conda(method = "basilisk"),
        error = function(e) e
    )
    if (inherits(result, "error")) {
        expect_true(grepl("Could not find conda", result$message))
    } else {
        expect_true(file.exists(result))
    }
})

test_that("find_conda with reticulate method returns path or errors gracefully", {
    result <- tryCatch(
        echoconda::find_conda(method = "reticulate"),
        error = function(e) e
    )
    if (inherits(result, "error")) {
        expect_true(grepl("Could not find conda", result$message))
    } else {
        expect_true(file.exists(result))
    }
})
