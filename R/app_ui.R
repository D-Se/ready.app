#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    fluidPage(
    	mainPanel(
    		h3("Try different solutions!"),
    		textAreaInput(
    			"ans", label = NULL,
    			value = "grep('[a-z]', letters)",
    			width = "600px", height = "200px"
    		),
    		h3("Results: "),
    		actionButton("answer", "Click Me"),
    		verbatimTextOutput("res"),
    		textOutput("status")
    	)
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "app"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
