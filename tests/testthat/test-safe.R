test_that("safe evaluation of user input", {
	expect_error(evaluate("as.character(1)"), "could not find function")
	expect_error(evaluate("grep('[a-z]', letters)"), "could not find function")
}
)
