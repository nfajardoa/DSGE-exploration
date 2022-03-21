rm(list = ls())
source("MIMIC.R")

# MODELO 1

low = c(
  .Machine$double.xmin, #theta1
  -0.7385,              #theta3
  -0.1059,              #theta4
  -0.3948,              #theta5
  2.6041,              #theta6
  -0.6969,              #theta7
  0.7178,              #theta8
  0.8054,              #theta2
  .Machine$double.xmin, #theta19
  0.1436,              #theta9
  1.1385,              #theta10
  2.3723,              #theta11
  2.6904,              #theta12
  3.0974,              #theta13
  1.4874,              #theta14
  2.1775,              #theta15
  -3.7644,              #theta16
  0.9935,              #theta17
  1.3223,              #theta18
  2.5458,              #theta20
  -Inf)                 #x0

up = c(
  0.1198,               #theta1
  -0.5385,               #theta3
  -.Machine$double.xmin, #theta4
  -0.1948,               #theta5
  2.8041,               #theta6
  -0.4969,               #theta7
  0.9178,               #theta8
  1.0054,               #theta2
  0.1011,               #theta19
  0.3436,               #theta9
  1.3385,               #theta10
  2.5723,               #theta11
  2.8904,               #theta12
  3.2974,               #theta13
  1.6874,               #theta14
  2.3775,               #theta15
  -3.5644,               #theta16
  1.1935,               #theta17
  1.5223,               #theta18
  2.7458,               #theta20
  Inf)                  #x0

modelo = MIMIC(upper = up, lower = low, pc = "Nico")

# MODELO 2

# MODELO 3

init = modelo[[1]]$Modelo$kf$x0T
errors = modelo[[1]]$Modelo$kf$Innov
theta = modelo[[1]]$Modelo$coef[4]
sum_errors = matrix(0, nrow = 28, ncol = 1)
exog = apply(modelo[[1]]$Modelo$model$fixed$c, 3L, c)
pars = modelo[[1]]$Modelo$coef[12:20]
sum_c = matrix(0,nrow=1,ncol=28)

for (i in 0:27){
  sum_c[i+1] = (theta^i)*exog[28-i]
  sum_errors[i+1] = (theta^i)*errors[28-i]
}

ma = theta^28*init

y = sum(ma,sum_errors,sum_c)  
