box::use(app/logic/getSimulation[...],
         data.table[...],
         survival[...],
         shiny[...])

#' @export
calcKME <- function(data){
  
  risksets <- survfit(Surv(time   = start, 
                           time2  = stop, 
                           event  = status,
                           type   = "counting") ~ x,
                      data = subset(data, re == 0))
  
  surv <- data.table::data.table(t    = risksets$time,
                                 surv = risksets$surv,
                                 x    = c(rep("0", risksets$strata[[1]]),
                                          rep("1", risksets$strata[[2]])))
  
  return(surv)
  
}
