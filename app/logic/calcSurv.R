box::use(data.table[...],
         shiny[...])

#' @export
calcSurv <- function(lower,
                     upper,
                     lambda_surv,
                     kappa_surv,
                     beta.xc){
  
  surv_dta <- data.table::data.table(t = rep(seq(lower, 
                                                 upper, 
                                                 length.out = 200)),
                                     x = rep(c(0, 1), each = 200))
  
  surv_dta[, 
           surv := exp(-(lambda_surv * exp(beta.xc * x)) 
                       * t ^ kappa_surv)]
  
  surv_dta[,
           x := as.character(x)]
  
  return(surv_dta)
  
}