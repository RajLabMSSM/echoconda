test_that("find_install_dir returns a writable directory", {
    result <- echoconda:::find_install_dir(verbose = FALSE)
    expect_true(dir.exists(result) || dir.exists(dirname(result)))
    expect_type(result, "character")
    expect_true(nchar(result) > 0)
})

test_that("find_install_dir with custom options picks first writable", {
    td1 <- file.path(tempdir(), "test_install_dir_1")
    td2 <- file.path(tempdir(), "test_install_dir_2")
    dir.create(td1, showWarnings = FALSE)
    dir.create(td2, showWarnings = FALSE)
    result <- echoconda:::find_install_dir(
        dest_dir_opts = c(td1, td2),
        verbose = FALSE
    )
    expect_equal(result, echoconda:::fix_path(td1))
    unlink(c(td1, td2), recursive = TRUE)
})

test_that("find_install_dir returns NA-ish when no viable dir", {
    # When no writable dir is found, names() returns NA for the [1] element
    result <- echoconda:::find_install_dir(
        dest_dir_opts = "/no_access_xyz_999",
        verbose = FALSE
    )
    expect_true(is.na(result))
})
