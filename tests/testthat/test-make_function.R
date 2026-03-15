test_that("make_function creates a function with specified formals", {
    body <- quote({ x + y })
    arg_list <- list(x = 1, y = 2)
    f <- echoconda:::make_function(body = body, arg_list = arg_list)

    expect_true(is.function(f))
    expect_equal(formals(f)$x, 1)
    expect_equal(formals(f)$y, 2)
    expect_equal(f(), 3)      # uses defaults
    expect_equal(f(10, 20), 30)
})

test_that("make_function with no-default formals using alist", {
    body <- quote({ paste(a, b) })
    arg_list <- alist(a = , b = )  # alist allows missing defaults
    f <- echoconda:::make_function(body = body, arg_list = arg_list)

    expect_true(is.function(f))
    expect_equal(f("hello", "world"), "hello world")
})

test_that("make_function preserves environment", {
    local_var <- 42
    body <- quote({ local_var })
    f <- echoconda:::make_function(
        body = body,
        arg_list = list(),
        env = environment()
    )
    expect_equal(f(), 42)
})
