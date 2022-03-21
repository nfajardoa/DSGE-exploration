# This file calls all the need satellite files to perform the estimations. I can be easily modified to work 
# in isolation from the the "main.R" file. To do this, just call the model's parameters directly from here, i.e. activate:
# source("parameters.R")


#Preamble
# library(AER)
# library(mvtnorm)
# library(lmtest)
 library(MHadaptive)


#Set seed
#set.seed(12345)
set.seed(0)
#set.seed(1968)
#set.seed(1973)
 
# Load the file with the parameters. Omit this if the current file is already called from outside
# source("parameters.R")

# Print on screen the country and sector-group being estimated
print(paste("Country:", country, sep=" "))
print(paste("sector =", sector, sep=" "))

# Load dataset. The dataset is constructed using the program file "Extract_Bayes_data.R" stanrtin gfrom teh orignal EXcel files in EUKLEMS
# NB: the matrix of (first difference) real marignal costs Dmc starts one year earlier than the matrix of 
# (first difference) inflation DDp, and thus contains one extra observation.

load(paste(country,if(alimentos==0){"_sinalim"},if(transables==1){"_trans"},"_Bayes_data.RData", sep=""))

# De-mean and calculate the (first difference) inflation gap Dxi
Dmc=Dmc-matrix(rep(rowMeans(Dmc), (nyears+1)),ncol=(nyears+1), byrow = FALSE)
DDp=DDp-matrix(rep(rowMeans(DDp),  nyears   ),ncol=nyears, byrow = FALSE)
Dxi=as.matrix(DDp[,1:(nyears-1)]-beta*DDp[,2:nyears])
nyears=nyears-1

# Select the appropriate sector-group: Keep only the sectors chosen by the parameter "sector".
Dmc=Dmc[first.sector[sector+1]:last.sector[sector+1],]
Dxi = Dxi[first.sector[sector+1]:last.sector[sector+1],]
nsectors=last.sector[sector+1]-first.sector[sector+1]+1

cat("paso por aca")

# Extract residual from Principal Component analysis. Use the file "PC_auto.R" if extraction is set to automatic; 
# use "PC_idiosyncratic.R"if extraction is manual 
if (npc.Dmc=="a"){
         source("PC_auto.R")
         PC_list.Dmc=idiosyncratic.auto(Dmc, type.test, "Dmc")
         Dmci=PC_list.Dmc$datai
         Dmc.npc= PC_list.Dmc$npc
   }else {source("PC_idiosyncratic.R")
         print(paste("number of factors for Dmc:", npc.Dmc, sep=" "))        
         Dmci=idiosyncratic(Dmc, npc.Dmc, "Dmc")}
     
if (npc.xi=="a"){
         source("PC_auto.R")
         PC_list.xi=idiosyncratic.auto(Dxi, type.test, "Dxii")
         Dxii.matrix=PC_list.xi$datai
         Dxi.npc= PC_list.xi$npc
   }else {source("PC_idiosyncratic.R")    
         print(paste("number of factors for Dxi:",  npc.xi, sep=" "))      
         Dxii.matrix=idiosyncratic(Dxi, npc.xi, "xii")}   
          

# Standardize idiosyncratic variables data by the variance of the prelimanary regression (variance of the residual error term, see appendix of the paper)
source("standardize_data_lag.R")
standardized.list=standardize(Dmci, Dxii.matrix, nyears, nsectors)
X=standardized.list$regressors
Dxii=standardized.list$regressand

# Load the basic theoretical functions used to construct the FIPE moments
source("basic_functions_lag.R")

# Load Prior distribution and covaraince matrix for the proposal
source("prior_proposal_lag.R")

#Likelihood 
log_like=function(theta.hat){-0.5*t(Dxii-X%*%t(bh(theta.hat,rho)))%*%(Dxii-X%*%t(bh(theta.hat,rho)))}
log_prior=function(theta.hat){log(prior(theta.hat))}
log_target<-function(theta.hat){log_like(theta.hat)+log_prior(theta.hat)}

# MCMC simulation. Initial value of the chain uses transformed values rhat and Rhat of, respectively, r=0.2 and R=1/3
#theta.hat0=c(0.0001,rhat.fun(0.2), Rhat.fun(1/3), 1)
#theta.hat0=c(0.0001,rhat.fun(0.4), Rhat.fun(1/4), 0.5)
theta.hat0=c(0.5, rhat.fun(0.45), Rhat.fun(1/6), 0.25)

# install.packages("PAWL")
# library(PAWL)
# showClass("tuningparameters")
# mhparameters <- tuningparameters(nchains = 2, niterations = 10000, adaptiveproposal = TRUE)
# 
# #mcmc_P=adaptiveMH(log_target, AP, proposal, verbose)
# mcmc_P=adaptiveMH(log_target, mhparameters)

mcmc_r=Metro_Hastings(li_func=log_target, pars=theta.hat0, prop_sigma=S, iterations=iters, burn_in=
                        10000, par_names=c('lambda','rhat','Rhat', 'Ghat'))

mcmc_all=mcmc_r
mcmc_r=mcmc_thin(mcmc_all, thin = 3)
S_adapted=mcmc_r$prop_sigma 
theta.hat=mcmc_r$trace


# Create the vector theta of posteriors to be used for the graphs (rhat and Rhat transformed back to r and R)
theta=theta.hat
theta[,2]=r.fun(theta.hat[,2])
theta[,3]=R.fun(theta.hat[,3])
colnames(theta)=c("lambda", "r", "R", "G")

