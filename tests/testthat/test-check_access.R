test_that("check_access detects writable directory", {
    td <- tempdir()
    result <- echoconda:::check_access(td)
    expect_true(result[[1]])
    expect_true(names(result) == td)
})

test_that("check_access detects non-writable path", {
    skip_on_os("windows")
    # /proc or /sys are typically not writable
    fake_path <- "/no_such_directory_xyz123"
    result <- echoconda:::check_access(fake_path)
    expect_false(result[[1]])
})

test_that("check_access works with multiple paths", {
    td <- tempdir()
    fake <- "/no_such_directory_xyz123"
    result <- echoconda:::check_access(c(td, fake))
    expect_length(result, 2)
    expect_true(result[[1]])   # tempdir is writable
    expect_false(result[[2]])  # fake is not writable
})

test_that("check_access with temp file", {
    tf <- tempfile()
    writeLines("test", tf)
    result <- echoconda:::check_access(tf)
    expect_true(result[[1]])
    unlink(tf)
})
