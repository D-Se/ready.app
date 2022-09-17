# making a safe execution environment for arbitrary code input.
# The safe search path is
unwanted <- c(
	"list.files",
	"as.character",
	"system"
)

ns <- mget(ls(.BaseNamespaceEnv, all.names = TRUE), envir = .BaseNamespaceEnv)
for(i in unwanted) ns[[i]] <- NULL

base_ns <- environment(grep)
n <- vapply(ns, is.primitive, T, USE.NAMES = F)
special_env <- ns[n] |> setNames(names(ns[n])) |> list2env(parent = emptyenv())
base_env <- new.env(parent = special_env)

ns <- ns[-which(n)]
safe_env <- lapply(ns, function(x) {
	if(is.function(x) && identical(environment(x), base_ns)) {
		environment(x) <- base_env
	}
	x
}) |>
	list2env(parent = special_env)

usethis::use_data(safe_env, overwrite = TRUE, internal = TRUE)
