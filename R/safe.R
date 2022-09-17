#' Safely evaluate arbitrary code input
#'
#' @param input chr, user input.
#' @importFrom rlang env_bind
#' @importFrom rlang parse_exprs
evaluate <- function(input) {
	fun_env <- new.env(parent = safe_env)
	env_bind(fun_env, !!! trial())
	calls <- parse_exprs(input)
	l <- length(calls)
	if(l != 1) for (i in calls[-l]) eval(i, fun_env)
	eval(calls[[l]], fun_env)
}

#' Safely evaluate arbitrary R expressions
#'
#' @param expr An arbitrary R expression
#' @return The result of evaluating the object: for an expression vector this
#'  is the result of evaluating the last element.
#' @export
safe <- function(expr) {
	tryCatch(
		eval(expr, safe_env),
		error = function(e) abort("Dangerous function detected", call = NULL)
	)
}
