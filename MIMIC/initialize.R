rm(list = ls())

setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC")
source("MIMIC.R")

lower = c(
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

upper = c(
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

MIMIC(last.year = 2003, model = 1, initial.values = 0, upper = upper, lower = lower, pc = "Nico")

