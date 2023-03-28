box::use(shiny[...])

box::use(app/view/CumHazPlot,
         app/view/KMEPlot,
         app/view/NtPlot,
         app/view/SurvPlot,
         app/view/Input)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  bootstrapPage(
    Input$ui(ns("SurvPlot")),
    mainPanel(
      fluidRow(
        column(6,
               SurvPlot$ui(ns("SurvPlot")),
               KMEPlot$ui(ns("SurvPlot"))
        ),
        column(6,
               NtPlot$ui(ns("SurvPlot")),
               CumHazPlot$ui(ns("SurvPlot"))
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    sim_data <- Input$server("SurvPlot")
    
    SurvPlot$server("SurvPlot")
    NtPlot$server("SurvPlot", sim_data)
    KMEPlot$server("SurvPlot", sim_data)
    CumHazPlot$server("SurvPlot", sim_data)
  })
}
