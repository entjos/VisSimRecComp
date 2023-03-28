box::use(data.table[...],
         simrec[simreccomp],
         shiny[...])

#' @export
getSimulation <- function(n_sim,
                          xlower,
                          xupper,
                          beta.xr,
                          beta.xc,
                          theta,
                          lambda_re,
                          kappa_re,
                          lambda_surv,
                          kappa_surv,
                          seed){
  
  set.seed(seed)
  
  sim_data <- simreccomp(n_sim,
                         fu.min = xlower,
                         fu.max = xupper,
                         cens.prob = 0,
                         dist.x = "binomial",
                         par.x = 0.5,
                         beta.xr = beta.xr,
                         beta.xc = beta.xc,
                         dist.zr = "gamma",
                         par.zr = theta,
                         dist.zc = "gamma",
                         par.zc = 0,
                         dist.rec = "weibull",
                         par.rec = c(lambda_re, kappa_re),
                         dist.comp = "weibull",
                         par.comp = c(lambda_surv, kappa_surv),
                         pfree = 1,
                         dfree = 0.00001)
  
  sim_data <- data.table::as.data.table(sim_data)
  
  sim_data_re <- data.table::copy(sim_data)
  sim_data_re[order(id, stop),
              `:=` (status = fifelse(status == 2, 0, status),
                    re     = 1)]
  
  sim_data_ce <- data.table::copy(sim_data)[stop == fu]
  sim_data_ce <- sim_data_ce[,
                             `:=` (start  = 0,
                                   status = fifelse(status == 2, 1, 0),
                                   re     = 0)]
  
  sim_data_comb <- rbindlist(list(sim_data_ce, sim_data_re))
  sim_data_comb[, `:=`(ce   = fifelse(re == 1, 0, 1),
                       stop = fifelse(stop < 0.00001, stop + 0.1, stop),
                       x    = as.factor(x))]
  
  return(sim_data_comb)
  
}