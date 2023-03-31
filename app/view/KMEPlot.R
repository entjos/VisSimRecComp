box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         wesanderson[wes_palette],
         app/logic/calcKME[...],
         viridisLite[viridis])

#' @export
ui <- function(id){
  ns <- NS(id)
  
  tagList(
    plotlyOutput(ns("KMEPlot"), width = "400px")
  )
}

#' @export
server <- function(id, data){
  moduleServer(id, function(input, output, session){
    
    out <-  reactive({
      
      KME <- calcKME(data())
      
      gptl <- ggplot(KME,
                     aes(t, surv,
                         col   = x,
                         group = x)) +
        geom_line() +
        scale_x_continuous(limits = c(input$xlower, input$xupper)) +
        scale_y_continuous(limits = c(0, 1)) +
        scale_colour_manual(values = wes_palette("GrandBudapest1", 2)) +
        labs(x = "Time",
             y = "KME Estimate of S(t)",
             title = "Kaplan-Meier Estimate") +
        theme_bw()
      
      ggplotly(gptl)
      
    })
    
    output$KMEPlot <- renderPlotly({out()})
    
  })
}
