# 
# install.packages()
# install.packages('latex2exp')
# install.packages('xlsx')
# install.packages('AER')
# install.packages('gdata')
# install.packages('mvtnorm')
# install.packages('lmtest')
# install.packages('MHadaptive')
  require('latex2exp')
  require(xlsx)
  library(AER)
  require('gdata')
  library(mvtnorm)
  library(lmtest)
  library(MHadaptive)

# install.packages('truncnorm')
# require(truncnorm)

# Parameters to choose. 

country="COL"    # Country: UK, USA or JPN 
sector =1       # Select of group of sectors. To replicate the paper choose values 1, 2, 3. A value =0 stands for all sectors grouped together (not in the paper)
#rho=1           # Autocorrelation of shocks. Takes values 0, 1 
npc.Dmc=3 # "a"     # Number of principal components to be removed from Dmc. If = "a" then selection is automatic
npc.xi =3 # "a"     # Number of principal components to be removed from xi. If = "a" then selection is automatic
type.test="ER"  # Test for automatic selection of npc. Values "ER" or "GR".
type.prior=0   # Type of prior for lambda. Takes value 1 for normal, 0 for gamma, 2 truncated Normal(-2,2)
   if (type.prior==2){ require(truncnorm) }
type.prior.Ghat=1   # Type of prior for lambda. Takes value 1 for normal, 0 for uniform

lags=0   # 1 for hybrid Phillips Curve 0 for just forward looking
iters=4.01*10^5 # Number of draws in the MCMC

beta=0.97       # subjective discount factor
chi0=1/beta     # chi_0
tau=0.95        # This is a scaling parameter for quickly adjusting the initial covariance matrix of the proposal distribution in the MCMC. 
transables=1    # Activar (1) o no (0) la clasificacion por transables/no-transables
alimentos=0     # Incluir (1) o no (0) alimentos

#pseudo-COL  2000:2017
#tau=0.75 then acceptance_rate= 0.1879429  with iters=140,001                mean(theta10)=0.002449482 0.426483022 0.328205548 1.039114995 

#tau=0.75 then acceptance_rate= 0.2276286 thin=5 with iters=140,001 dim(trace)=28,001 mean=0.0109431   0.4617211   0.8520098   1.0240828 
# cbind(t(quantile(theta10[,1],probs=c(0.10,0.16,0.50))),estimate_mode(theta10[,1]),t(quantile(theta10[,1],probs=c(0.84,0.90))))
# 10%         16%        50%                  84%      90%
# [1,] -0.0009222311 0.001533455 0.01001929 0.01025935 0.02051483 0.02419284
# [1,] -0.0008897654 0.0007138835 0.007021301 0.01353191 0.06842424 0.07960132
# [1,] -0.03269554 -0.02626087 -0.00667444 -0.001856668 0.02346935 0.03230365
# [1,] -0.02992064 -0.02086238 -0.005144854 -0.002531104 0.005470259 0.009213532
# [1,] -0.001342965 0.0001197545 0.005104518 0.008584771 0.011689 0.01414707
# [1,] -0.0001485507 0.000759785 0.003958956 0.007533252 0.009071089 0.01125296

#IDEM WITH SEED.SET(1968) IN LINE 16 OF FIPE_lag_auto.R


# UK 
#tau=0.2 then acceptance_rate= 0.1081  with iters=100,001
#tau=0.4 then acceptance_rate= 0.1212  with iters= 5,001
#tau=0.4 then acceptance_rate= 0.1353  with iters=50,001

#tau=0.5 then acceptance_rate= 0.1198  with iters=140,001
#tau=0.6 then acceptance_rate= 0.1212  with iters= 5,001
#tau=0.6 then acceptance_rate= 0.13036 with iters=50,001
#tau=0.75 then acceptance_rate= 0.1239  with iters=140,001   -0.1506907  0.4607002  0.2957331  1.0442028 

#tau=0.8 then acceptance_rate= 0.1174  with iters=140,001 0.09828188 0.58926493 0.76275022 1.06681840


#tau=1.2 then acceptance_rate= 0.12564 with iters=50,001
#tau=4.2 then acceptance_rate= 0.1059  with iters=100,001
#tau=8.2 then acceptance_rate= 0.11707 with iters=100,001

#tau= then acceptance_rate= 0. with iters=100,001
