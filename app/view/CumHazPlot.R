box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         app/logic/calcCumHaz[...])

#' @export
ui <- function(id){
  ns <- NS(id)
  
  tagList(
    plotlyOutput(ns("CumHazPlot"), width = "400px")
  )
}

#' @export
server <- function(id, data){
  moduleServer(id, function(input, output, session){
    
    out <-  reactive({
      
      cumHaz <- calcCumHaz(data())
      
      gptl  <- ggplot(cumHaz,
                      aes(t, cumhaz,
                          col   = x,
                          group = x)) +
        geom_line() +
        scale_x_continuous(limits = c(input$xlower, input$xupper)) +
        labs(x = "Time",
             y = "H(t)")
      
      ggplotly(gptl)
      
    })
    
    output$CumHazPlot <- renderPlotly({out()})
    
  })
}
