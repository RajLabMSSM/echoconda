test_that("prep_pkg_names strips r- prefix", {
    expect_equal(echoconda:::prep_pkg_names("r-dplyr"), "dplyr")
})

test_that("prep_pkg_names strips bioconductor- prefix", {
    expect_equal(echoconda:::prep_pkg_names("bioconductor-genomicranges"),
                 "genomicranges")
})

test_that("prep_pkg_names strips underscores and hyphens", {
    expect_equal(echoconda:::prep_pkg_names("my_package"), "mypackage")
    expect_equal(echoconda:::prep_pkg_names("my-package"), "mypackage")
})

test_that("prep_pkg_names lowercases", {
    expect_equal(echoconda:::prep_pkg_names("MyPackage"), "mypackage")
})

test_that("prep_pkg_names strips dots", {
    expect_equal(echoconda:::prep_pkg_names("data.table"), "datatable")
})

test_that("prep_pkg_names handles combined prefixes and special chars", {
    expect_equal(echoconda:::prep_pkg_names("r-data.table"), "datatable")
    expect_equal(echoconda:::prep_pkg_names("bioconductor-S4Vectors"),
                 "s4vectors")
})

test_that("prep_pkg_names handles plain names", {
    expect_equal(echoconda:::prep_pkg_names("numpy"), "numpy")
})
