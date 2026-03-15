test_that("search_yamls returns path for known bundled yaml", {
    # "echoR" is a bundled yaml in the package
    result <- echoconda:::search_yamls(
        yaml_path = "echoR.yml",
        show_contents = FALSE,
        verbose = FALSE
    )
    expect_true(!is.null(result))
    expect_true(file.exists(result))
    expect_true(endsWith(result, ".yml"))
})

test_that("search_yamls returns NULL for unknown yaml", {
    result <- echoconda:::search_yamls(
        yaml_path = "nonexistent_env_xyz.yml",
        show_contents = FALSE,
        verbose = FALSE
    )
    expect_null(result)
})

test_that("search_yamls finds test yaml", {
    result <- echoconda:::search_yamls(
        yaml_path = "test.yml",
        show_contents = FALSE,
        verbose = FALSE
    )
    expect_true(!is.null(result))
    expect_true(file.exists(result))
})
