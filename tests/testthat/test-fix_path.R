test_that("fix_path expands tilde", {
    result <- echoconda:::fix_path("~/some_dir")
    expect_false(startsWith(result, "~"))
    expect_true(nchar(result) > nchar("~/some_dir"))
})

test_that("fix_path with absolute path returns unchanged on non-Windows", {
    skip_on_os("windows")
    abs_path <- "/tmp/test_dir"
    result <- echoconda:::fix_path(abs_path)
    expect_equal(result, abs_path)
})

test_that("fix_path handles empty string", {
    result <- echoconda:::fix_path("")
    expect_type(result, "character")
})
