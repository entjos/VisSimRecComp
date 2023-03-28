box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         app/logic/calcSurv[...])

#' @export
ui <- function(id){
  ns <- NS(id)
  
  tagList(
    plotlyOutput(ns("SurvPlot"), width = "400px")
  )
}

#' @export
server <- function(id){
  moduleServer(id, function(input, output, session){
    
    out <- eventReactive(input$trigger,
                         ignoreNULL = FALSE, {
      surv <- calcSurv(input$xlower,
                       input$xupper,
                       input$lambda_surv,
                       input$kappa_surv,
                       input$beta.xc)
      
      gptl <- ggplot(surv,
                     aes(t, surv,
                         col   = x,
                         group = x)) +
        geom_line() +
        scale_x_continuous(limits = c(input$xlower, input$xupper)) +
        labs(x = "Time",
             y = "S(t)")
      
      ggplotly(gptl)
    })
    
    output$SurvPlot <- renderPlotly({
      out()
    })
  })
}

