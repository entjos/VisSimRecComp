box::use(plotly[...],
         ggplot2[...],
         shiny[...],
         app/logic/getSimulation[...])

#' @export
ui <- function(id){
  ns <- NS(id)
  
  sidebarPanel(
    actionButton(ns("trigger"),
                 "simulate"),
    numericInput(ns("lambda_surv"),
                 "Lambda",
                 value = 1,
                 step  = 0.1),
    numericInput(ns("kappa_surv"),
                 "Kappa",
                 value = 1,
                 step  = 0.1),
    numericInput(ns("xlower"),
                 "From",
                 value = 0,
                 step  = 1),
    numericInput(ns("xupper"),
                 "To",
                 value = 10,
                 step  = 1),
    numericInput(ns("beta.xr"),
                 "Effect of X on the recurrent event",
                 value = 1.4,
                 step  = 0.1),
    numericInput(ns("beta.xc"),
                 "Effect of X on survival",
                 value = 0.4,
                 step  = 0.1),
    numericInput(ns("n_sim"),
                 "No. observations to simulate",
                 value = 1000,
                 step  = 1000),
    numericInput(ns("lambda_re"),
                 "Lambda",
                 value = 1,
                 step  = 0.1),
    numericInput(ns("kappa_re"),
                 "Kappa",
                 value = 1,
                 step  = 0.1),
    numericInput(ns("theta"),
                 "Varianze of the frailty term",
                 value = 1,
                 step  = 0.1),
    numericInput(ns("seed"),
                 "Random Seed",
                 value = 9874,
                 step  = 1)
  )
}

#' @export
server <- function(id){
  moduleServer(id, function(input, output, session){
    
    eventReactive(input$trigger,
                  ignoreNULL = FALSE, {
                    getSimulation(input$n_sim,
                            input$xlower,
                            input$xupper,
                            input$beta.xr,
                            input$beta.xc,
                            input$theta,
                            input$lambda_re,
                            input$kappa_re,
                            input$lambda_surv,
                            input$kappa_surv,
                            input$seed)
    })
    
    
  })
}