box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         wesanderson[wes_palette],
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
        scale_colour_manual(values = wes_palette("GrandBudapest1", 2)) +
        labs(x = "Time",
             y = "H(t)")
      
      ggplotly(gptl)
      
    })
    
    output$CumHazPlot <- renderPlotly({out()})
    
  })
}
