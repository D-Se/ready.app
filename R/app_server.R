#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
	text_reactive <- eventReactive(input$answer, {
		evaluate(input$ans)
	})

	output$res <- renderPrint(text_reactive())
	output$status <- renderText({
		req(text_reactive())
		# test if answer is correct
		if(identical(text_reactive(), as.integer(c(6, 14, 24, 36, 50)))) {
			"Correct"
		} else {
			"Not correct"
		}
	})
}
