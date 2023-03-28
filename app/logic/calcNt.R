box::use(app/logic/getSimulation[...],
         data.table[...],
         JointFPM[mean_no],
         shiny[...],
         survival[Surv])

#' @export
calcNt <- function(data){
  
  Nt_x1 <- mean_no(Surv(start, stop, status) ~ x,
                   re_indicator = "re",
                   ce_indicator = "ce",
                   data = subset(data, x == 1))
  
  Nt_x0 <- mean_no(Surv(start, stop, status) ~ x,
                   re_indicator = "re",
                   ce_indicator = "ce",
                   data = subset(data, x == 0))
  
  Nt_x1$x <- "1"
  Nt_x0$x <- "0"
  
  Nt <- rbindlist(list(Nt_x1, Nt_x0))
  
  return(Nt)
  
}

