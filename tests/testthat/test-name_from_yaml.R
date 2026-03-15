test_that("name_from_yaml extracts name from file contents", {
    # Create a temp yaml with a name field
    tf <- tempfile(fileext = ".yml")
    writeLines(c("name: test_env", "channels:", "  - defaults"), tf)
    result <- echoconda:::name_from_yaml(tf, verbose = FALSE)
    expect_equal(result, "test_env")
    unlink(tf)
})

test_that("name_from_yaml falls back to filename when file doesn't exist", {
    # When given just a basename that doesn't exist as a file,
    # it should extract from the filename
    result <- echoconda:::name_from_yaml("myenv.yml", verbose = FALSE)
    expect_equal(result, "myenv")
})

test_that("name_from_yaml strips .yaml extension too", {
    result <- echoconda:::name_from_yaml("another_env.yaml", verbose = FALSE)
    expect_equal(result, "another_env")
})
