box::use(app/logic/getSimulation[...],
         data.table[...],
         survival[...],
         shiny[...])

#' @export
calcCumHaz <- function(data){
  
  risksets <- survfit(Surv(time   = start, 
                           time2  = stop, 
                           event  = status,
                           type   = "counting") ~ x,
                      data = subset(data, re == 1))
  
  cumhaz <- data.table::data.table(t      = risksets$time,
                                   cumhaz = risksets$cumhaz,
                                   x      = c(rep("0", risksets$strata[[1]]),
                                              rep("1", risksets$strata[[2]])))
  
  return(cumhaz)
  
}
