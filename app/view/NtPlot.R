box::use(plotly[...],
         ggplot2[...],
         shiny[...],
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
        labs(x = "Time",
             y = "E[N(t)]")
      
      ggplotly(gptl)
      
    })
    
    output$NtPlot <- renderPlotly({out()})
    
  })
}
