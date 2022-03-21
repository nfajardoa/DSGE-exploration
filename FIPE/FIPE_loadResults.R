# setwd("U:/My Documents/FIPE/Publication")
rm(list = ls())
#setwd("D:/users/NRO/DEPE/CurvaPhillipsSectorial/FIPE")
setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE")

library('gplots')
require('MASS')
require('latex2exp')

country_group = cbind("COL", "JPN", "USA", "UK") 

for (country in country_group) {

  if (country == "COL") {load("COL_2018-07-14_16_Results.RData")}
  if (country == "JPN") {load("JPN_2018-07-14_10_Results.RData")}
  if (country == "USA") {load("USA_2018-07-13_18_Results.RData")}
  if (country == "UK") {load("UK_2018-07-13_12_Results.RData")}  
  
options <- c('Distribution','Mean/Shape','Sd/Scale')
option_lambda_values <- c("normal", mean.lambda, sd.lambda)
option_r_values <- c("gamma", shape.rhat, scale.rhat)
option_Rhat_values <- c("gamma", shape.Rhat, scale.Rhat)
option_Ghat_values <- c("gamma", shape.Ghat, scale.Ghat)
parameters <- c('Iterations','Lags','Tau')
parameters_values <- c(iters, lags, tau)

text <- data.frame(Options = options, Lambda = option_lambda_values, r = option_r_values, Rhat = option_Rhat_values, Ghat = option_Ghat_values)
values <- data.frame(Options = parameters, Values = parameters_values)

# Plot posteriors
m <- rbind(c(1, 2), c(3, 4), c(5, 6), c(7, 8))

windows(title=paste(country, "(lambda)", sep="_"))
layout(m, heights = c(1.5, 2, 2, 2, 2))
par(mar = c(2.5, 2.5, 2.5, 2.5))
textplot(text, show.rownames=FALSE, cex = 1)
mtext(as.character(paste(country, "(lambda)", sep=" ")), side = 3, line = 0)
textplot(values, show.rownames=FALSE, cex = 1)
for (sector in 1:3){
  for (rho in 0:1){
    plot(density(eval(as.name(paste("theta", sector, rho, sep="")))[,1]),xlim=c(-1.5,1.5),col="red",xlab=NA,ylab=NA,main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
    curve(prior.lambda(x),lty=3, add=TRUE)}
}
dev.print(pdf, as.character(paste(country,"lambda","individual.pdf", sep="_")))

m <- rbind(c(1, 2), c(3, 4))

windows(title=paste(country, "(lambda)", sep="_"))
layout(m, heights = c(0.4, 1))
par(mar = c(2.5, 2.5, 2.5, 2.5))
textplot(text, show.rownames=FALSE, cex = 0.6)
mtext(as.character(paste(country, "(lambda)", "Agregado", sep=" ")), side = 3, line = 0)
textplot(values, show.rownames=FALSE, cex = 0.6)
for (sector in 0:0){
  for (rho in 0:1){
    plot(density(eval(as.name(paste("theta", sector, rho, sep="")))[,1]),xlim=c(-1.5,1.5),col="red",xlab=NA,ylab=NA,main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
    curve(prior.lambda(x),lty=3, add=TRUE)}
}
dev.print(pdf, as.character(paste(country,"lambda","agregado.pdf", sep="_")))


}
