box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         wesanderson[wes_palette],
         app/logic/calcNt[...])

#' @export
ui <- function(id){
  ns <- NS(id)
  
  tagList(
    plotlyOutput(ns("NtPlot"), width = "400px")
  )
}

#' @export
server <- function(id, data){
  moduleServer(id, function(input, output, session){

    out <-  reactive({
      
      Nt <- calcNt(data())
      
      gptl <- ggplot(Nt,
                     aes(t, expn,
                         col   = x,
                         group = x)) +
        geom_line() +
        scale_x_continuous(limits = c(input$xlower, input$xupper)) +
        scale_colour_manual(values = wes_palette("GrandBudapest1", 2)) +
        labs(x = "Time",
             y = "E[N(t)]",
             title = "Mean Number of Events") +
        theme_bw()
      
      ggplotly(gptl)
      
    })
    
    output$NtPlot <- renderPlotly({out()})
    
  })
}
