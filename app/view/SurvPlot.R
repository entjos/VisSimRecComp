box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         wesanderson[wes_palette],
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
        scale_y_continuous(limits = c(0, 1)) +
        scale_colour_manual(values = wes_palette("GrandBudapest1", 2)) +
        labs(x = "Time",
             y = "S(t)",
             title = "Exact Survival Function") +
        theme_bw()
      
      ggplotly(gptl)
    })
    
    output$SurvPlot <- renderPlotly({
      out()
    })
  })
}

