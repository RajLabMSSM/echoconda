test_that("chmod_translate_codes: letters to numbers", {
    # rwx = 7
    expect_equal(echoconda:::chmod_translate_codes("rwx"), "7")
    # r-- = 4
    expect_equal(echoconda:::chmod_translate_codes("r--"), "4")
    # --- = 0
    expect_equal(echoconda:::chmod_translate_codes("---"), "0")
})

test_that("chmod_translate_codes: multiple permission groups", {
    # "rwx r-- r--" => "744"
    result <- echoconda:::chmod_translate_codes("rwx r-- r--")
    expect_equal(result, "744")
    # "rwx rwx rwx" => "777"
    result <- echoconda:::chmod_translate_codes("rwx rwx rwx")
    expect_equal(result, "777")
    # "rw- r-- r--" => "644"
    result <- echoconda:::chmod_translate_codes("rw- r-- r--")
    expect_equal(result, "644")
})

test_that("chmod_translate_codes: numbers to letters (from_numbers=TRUE)", {
    # 7 => rwx
    result <- echoconda:::chmod_translate_codes(7, from_numbers = TRUE)
    expect_equal(result, "rwx")
    # 644 => "rw- r-- r--"
    result <- echoconda:::chmod_translate_codes(644, from_numbers = TRUE)
    expect_equal(result, "rw- r-- r--")
    # 755 => "rwx r-x r-x"
    result <- echoconda:::chmod_translate_codes(755, from_numbers = TRUE)
    expect_equal(result, "rwx r-x r-x")
})

test_that("chmod_translate_codes: round-trip consistency", {
    # letters -> numbers -> letters
    letters_in <- "rwx r-x r--"
    numbers <- echoconda:::chmod_translate_codes(letters_in)
    letters_out <- echoconda:::chmod_translate_codes(
        as.integer(numbers), from_numbers = TRUE
    )
    expect_equal(letters_out, letters_in)
})
