# This file creates, for a selected country, the sets of 3x2 graphs used presented in the paper

# Preamble
# setwd("U:/My Documents/FIPE/Publication")
# setwd("D:/users/NRO/DEPE/CurvaPhillipsSectorial/FIPE")
setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE")
rm(list = ls())
library('latex2exp')

# Load the file with the parameters.
source("parameters.R")

# Calculate posteriors, looping over the three sector groups and the two values for rho. The vetor theta collecls the posteriors
# for r, R, Gamma. The matrix S collectes the variance covariance matrix of the proposal distribution used in the MCMC simulator
#  for (sector in 0:3){
#sector=5

for (sector in c(0,1:5)){
  for (rho in 0:1){
    print(Sys.time())
    print(iters)
    print(if(lags==0){"Forward Looking"}else{"Hybrid"})
    source("FIPE_lag_auto.R")
                  print(rho)    
                  assign(paste("theta", sector,rho,sep=""), theta)
                  assign(paste("S"    , sector,rho,sep=""), S_adapted)
                  save.image(paste(country,"_",sector,"_",rho,"_",lags,"_",Sys.Date(),"_",format(Sys.time(), "%H"),"_Results.RData", sep=""))
  }
}

country
tau
dim(mcmc_r$trace)
# aceptance_rate
mcmc_r$acceptance_rate

#dim(theta10)
colMeans(theta00)
# colMeans(theta10)
# colMeans(theta11)
# colMeans(theta20)
# colMeans(theta21)
# colMeans(theta30)
# colMeans(theta31)
# colMeans(theta40)
# colMeans(theta41)
# colMeans(theta50)
# colMeans(theta51)
#BCI(theta31)
BCI(mcmc_r, interval = c(0.10, 0.90))



# percentiles de lambda por cada sector y cada rho almacenados en theta#sector#rho[,1]
#cbind(t(quantile(theta[,1]  ,probs=c(0.10,0.16,0.50))),estimate_mode(theta),t(quantile(theta,probs=c(0.84,0.90))))
# en theta queda el mismo contenido que en theta31
# cbind(t(quantile(theta00[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta00[,1]),t(quantile(theta00[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta01[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta01[,1]),t(quantile(theta01[,1],probs=c(0.84,0.90))))

# cbind(t(quantile(theta00[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta00[,1]),t(quantile(theta00[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta01[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta01[,1]),t(quantile(theta01[,1],probs=c(0.84,0.90))))

cbind(t(quantile(theta00[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta00[,1]),t(quantile(theta00[,1],probs=c(0.84,0.90))))
cbind(t(quantile(theta01[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta01[,1]),t(quantile(theta01[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta10[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta10[,1]),t(quantile(theta10[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta11[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta11[,1]),t(quantile(theta11[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta20[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta20[,1]),t(quantile(theta20[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta21[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta21[,1]),t(quantile(theta21[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta30[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta30[,1]),t(quantile(theta30[,1],probs=c(0.84,0.90))))
# cbind(t(quantile(theta31[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta31[,1]),t(quantile(theta31[,1],probs=c(0.84,0.90))))

cbind(t(quantile(theta40[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta40[,1]),t(quantile(theta40[,1],probs=c(0.84,0.90))))
cbind(t(quantile(theta41[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta41[,1]),t(quantile(theta41[,1],probs=c(0.84,0.90))))
cbind(t(quantile(theta50[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta50[,1]),t(quantile(theta50[,1],probs=c(0.84,0.90))))
cbind(t(quantile(theta51[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta51[,1]),t(quantile(theta51[,1],probs=c(0.84,0.90))))

dif_mat_cov=mcmc_r$prop_sigma-var(mcmc_r$trace)
det(dif_mat_cov) # from manual: While Metro_Hastings has an adaptive proposal structure built in, if prop_sigma differs greatly
                 # from the covariance structure of the target distribution, stationarity may not be achieved. 

#plotMH(mcmc_r, correlogram = FALSE)


# # draws plots
# windows(title=paste(draws, "lambda", sep=""))
# par(mfrow=c(2,2))
# for (par in 1:4){
#   plot(mcmc_r$trace[,par], xlab=NA, ylab=NA, type="l" )
#   #  density(eval(as.name(paste("theta", sector, rho, sep="")))[,1]), xlim=c(-1.5,1.5), col="red", xlab=NA, ylab=NA,  main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
# }

# Plot posteriors
# windows(title=paste(country, "lambda", sep=""))
# par(mfrow=c(2,1))
# for (sector in 0:0){
#   for (rho in 0:1){plot(density(eval(as.name(paste("theta", sector, rho, sep="")))[,1]),xlim=c(-0.5,1.2),col="red",xlab=NA,ylab=NA,main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
#     curve(prior.lambda(x),lty=3, add=TRUE)}
# }

windows(title=paste('draws',country))
plot(theta50[,1], type='l')

windows(title=paste(country, "lambda", sep=""))
estimate_mode <- function(x){d<-density(x);d$x[which.max(d$y)]}
par(mfrow=c(3,2))
#par(mfrow=c(2,2))
#for (sector in 1:3){
posi = 1
# for (sector in c(0, 4:5)){
   if (sector == 0){sector_name='Total'; }
   if (sector == 4){sector_name='Transables'}
   if (sector == 5){sector_name='No transable'}
   for (rho in 0:1){
       vv=eval(as.name(paste("theta",sector,rho,sep="")))[,1]
       l_10=quantile(vv,probs=c(0.10))
       l_16=quantile(vv,probs=c(0.16))
       l_50=quantile(vv,probs=c(0.50))
       l_mode=estimate_mode(vv)
       l_84=quantile(vv,probs=c(0.84))
       l_90=quantile(vv,probs=c(0.90))
       densidad=density(vv)
       plot(  densidad,
             xlim=c(-0.5,0.5),col="red",xlab=NA,ylab=NA,main=TeX(sprintf("sector=%s ,lags=%d,$\\rho$ = %d",sector_name,lags,rho)) )
       if (posi==1){
         legend(0.22,6.9, legend=c("Posterior","Prior","Inter. 80% credibilidad","Inter. 64% credibilidad"),col=c("red","black","gray60","pink"), lty=1:4, cex=0.8, box.lty=2) 
      }
      posi = posi+1;
      curve(prior.lambda(x),lty=3, add=TRUE)
      #abline(v=l_10, col="gray60", lty=3, cex=0.8)
      #abline(v=l_90, col="gray60", lty=3, cex=0.8)
      ss_10=densidad$x[near(densidad$x,l_10, 0.06)]
      ss_10=ss_10[length(ss_10)/2+1];  altura_10=densidad$y[densidad$x==ss_10]
      segments(l_10, 0, l_10, altura_10, col= 'gray', lty=3)   
      ss_90=densidad$x[near(densidad$x,l_90, 0.06)]
      ss_90=ss_90[length(ss_90)/2+1];  altura_90=densidad$y[densidad$x==ss_90]
      segments(l_90, 0, l_90, altura_90, col= 'gray', lty=3)   
      ss_16=densidad$x[near(densidad$x,l_16, 0.06)]
      ss_16=ss_16[length(ss_16)/2+1];  altura_16=densidad$y[densidad$x==ss_16]
      segments(l_16, 0, l_16, altura_16, col= 'pink', lty=4)   
      ss_84=densidad$x[near(densidad$x,l_84, 0.06)]
      ss_84=ss_84[length(ss_84)/2+1];  altura_84=densidad$y[densidad$x==ss_84]
      segments(l_84, 0, l_84, altura_84, col= 'pink', lty=4)   
   }
# }





windows(title=paste(country, "r", sep=""))
#par(mfrow=c(3,2))
par(mfrow=c(2,2))
#for (sector in 1:3){
  for (sector in 4:5){
    for (rho in 0:1){plot(density(eval(as.name(paste("theta", sector, rho, sep="")))[,2]), xlim=c(0,1), col="red", xlab=NA, ylab=NA,main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
                        curve((prior.rhat(rhat.fun(x))/(1-x)^2),lty=3, add=TRUE)}
}

windows(title=paste(country, "R", sep=""))
par(mfrow=c(3,2))
for (sector in 1:3){
  for (rho in 0:1){plot(density(eval(as.name(paste("theta", sector, rho, sep="")))[,3]), xlim=c(0,1), col="red", xlab=NA, ylab=NA,main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
                        curve((prior.Rhat(Rhat.fun(x))/(1-x)^2),lty=3, add=TRUE)}
}

windows(title=paste(country, "Gamma", sep=""))
par(mfrow=c(3,2))
for (sector in 1:3){
  for (rho in 0:1){plot(density(eval(as.name(paste("theta", sector, rho, sep="")))[,4]), xlim=c(0,2), col="red", xlab=NA, ylab=NA,main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))
    curve(prior.Ghat(x),lty=3, add=TRUE)}
}

# Plot diagnostics presented in the Appendix to the paper
windows(title=paste(country, "lambda","_ACF", sep=""))
par(mfrow=c(3,2))
for (sector in 1:3){
  for (rho in 0:1){acf(eval(as.name(paste("theta", sector, rho, sep="")))[,1], main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))}
}

windows(title=paste(country, "r","_ACF", sep=""))
par(mfrow=c(3,2))
for (sector in 1:3){
  for (rho in 0:1){acf(eval(as.name(paste("theta", sector, rho, sep="")))[,2], main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))}
}

windows(title=paste(country, "R","_ACF", sep=""))
par(mfrow=c(3,2))
for (sector in 1:3){
  for (rho in 0:1){acf(eval(as.name(paste("theta", sector, rho, sep="")))[,3], main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))}
}

windows(title=paste(country, "Gamma","_ACF", sep=""))
par(mfrow=c(3,2))
for (sector in 1:3){
  for (rho in 0:1){acf(eval(as.name(paste("theta", sector, rho, sep="")))[,4], main=TeX(sprintf("sector = %d , $\\rho$ = %d", sector, rho)))}
}

# Save the results of the the estimation
save.image(paste("Publication/", Sys.Date(),"_",lags,"_completo_",country, "_results.RData", sep=""))

