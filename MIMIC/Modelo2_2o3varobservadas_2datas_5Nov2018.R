rm(list=ls())

setwd("C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC")
#setwd("D:/Users/NRO/DEPE/ESPE/DemandadeDinero/MIMIC")
#setwd("C:/Users/NRO/DEPE/ESPE/DemandadeDinero/MIMIC")

library(data.table)
library(MARSS)
library(openxlsx)
library(ggplot2)
library(stargazer)
#library(gridExtra)
#library(latex2exp)

n_vars_obs = 3
data_used = 2017
# Especificaciones con cambios en el valor inicial
#initial.values = c(-90,-15,8,15,60,100)   
#initial.values = seq(-900,1000,20)   #,-5,0,5,10)
initial.values = c(-90,12)
                   
#### MODELO 2
if (data_used == 2003){ 
   data <- read.xlsx('Datos.xlsx')
   last_obs = 28 
   col_Ut_1  = 21  
   col_LVAEAM = 14
   if (n_vars_obs == 2){    #y.selector = c(2,3,4)   #  ln(EFR)	CP	BM
   y.selector = c(2,3)    #  ln(EFR)	CP	W(GWh)(Ln)
  } else {y.selector = c(2,3,5)    #  ln(EFR)	CP	W(GWh)(Ln)  
    }
   d.selector  = c(9,13,19,21,14)  #   DTM   DIPC  CL  Ut-1  LVAEAM
   cc.selector = c(16,17,18,21,22)   # IC  AN   SMReal  Ut-1   lnVCO
}
if (data_used == 2017){  
   data <- read.xlsx('DdaDinero_BaseDatos_17Octubre2018_ANUAL.xlsx', sheet = 1)
   last_obs   = 42
   col_Ut_1   = 22
   col_LVAEAM = 13
   if (n_vars_obs == 2){    #y.selector = c(2,3,4)   #  ln(EFR)	CP	BM
     y.selector = c(2,3)    #  ln(EFR)	CP
   }
   if (n_vars_obs==3){
      y.selector = c(2,3,4)    #  ln(EFR)	CP	BM
   }
   #d.selector = c(8,12,19,22,13)    #  DTF   DIPC   CL  Ut-1  LVAEAM 
   d.selector = c(24,11,19,26,13)   #   DTFR VIT       CL  Ut  LVAEAMt 
   cc.selector = c(14,16,17,18,22,23, 8)   #  LVAEAM_1  IC    AN     LSMReal   Ut-1   lnVCO   DTF
}
  y = t(data[y.selector])
  d = t(data[d.selector]) 
  
  ln_U_lead = t(data[col_Ut_1])
  ln_U_lead = shift(ln_U_lead, n=1, fill=NA, type="lead")
  ln_U_lead[last_obs] = ln_U_lead[last_obs-1]*(1+(data[last_obs,col_Ut_1]/data[last_obs-1,col_Ut_1]-1))
  
  d[4,] = ln_U_lead
  row.names(d)[4] = "Ut"
  
  ln_Y_r_lag = t(data[col_LVAEAM])
  ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
  ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,col_LVAEAM]/data[2,col_LVAEAM]))
  #cc = rbind(ln_Y_r_lag,t(data[cc.selector])) 
  cc = t(data[cc.selector]) 
####
if (n_vars_obs == 2){ # Orden de las restricciones
    Z = matrix(list("theta1","theta2"),2,1)  
    D = matrix(list("theta4","theta5",0,0,"theta6",0,0,"theta7","theta8",0),2,5,byrow = TRUE)
    A = matrix(0,2,1)
    R = matrix(list("theta17",0,0,"theta18"),2,2)
    B = matrix(list("theta10"),1,1)
    C = matrix(list("theta11","theta12","theta13","theta14","theta15","theta16","theta19"),1,7)
    U = matrix(0,1,1)
    Q = matrix(list("theta20"),1,1)
    V0 = matrix(100,1,1)
    # Ultima corresponde a x0
    ctl = list(lower = c(
      .Machine$double.xmin, #theta1
      -1.4001,              #theta2
      -2.9414,              #theta4
      -2.1374,              #theta5
      0.0222236,              #theta6
      0.0000590,              #theta7
      0.0000575,              #theta8
      .Machine$double.xmin, #theta17
      .Machine$double.xmin, #theta18
      .Machine$double.xmin, #theta10
      -4.8225,              #theta11
      .Machine$double.xmin, #theta12
      .Machine$double.xmin, #theta13
      .Machine$double.xmin, #theta14
      0.0001,               #theta15
      0.0001,               #theta16
      0.0001,               #theta19
      .Machine$double.xmin, #theta20
      -1000) #x0
      ,upper = c(
        1.99,               #theta1
        1.22,               #theta2
        -.00001,               #theta4
        -.00001,               #theta5
        4.9036,               #theta6
        3.5590,               #theta7
        3.6575,               #theta8
        6.1040,               #theta17
        6.1002,               #theta18
        1.8873,               #theta10
       -0.0001,               #theta11
        3.1873,               #theta12
        2.9953,               #theta13
        2.7618,               #theta14
        4.1968,               #theta15
        2.5821,               #theta16
        2.5821,               #theta19
        12.960,               #theta20
        1000)                  #x0
    )
}  
if (n_vars_obs == 3)  { # Orden de las restricciones
    Z = matrix(list("theta1","theta2","theta3"),3,1)
    D = matrix(list("theta4","theta5",0,0,"theta6",0,0,"theta7","theta8",0,0,0,0,0,"theta9"),3,5,byrow = TRUE)
    A = matrix(0,3,1)
    R = matrix(list("theta17",0,0,0,"theta18",0,0,0,"theta19"),3,3)
    B = matrix(list("theta10"),1,1)
    C = matrix(list("theta11","theta12","theta13","theta14","theta15","theta16","theta21"),1,7)
    U = matrix(0,1,1)
    Q = matrix(list("theta20"),1,1)
    V0 = matrix(100,1,1)

  ctl = list(lower = c(
    .Machine$double.xmin, #theta1
    -0.2201,              #theta2
    .Machine$double.xmin, #theta3
    -0.9414,              #theta4
    -1.1374,              #theta5
    0.7036,              #theta6
    0.3590,              #theta7
    0.4575,              #theta8
    0.4497,              #theta9
    .Machine$double.xmin, #theta17
    .Machine$double.xmin, #theta18
    .Machine$double.xmin, #theta19
    0.6873,              #theta10
    -1.8225,              #theta11
    1.9873,              #theta12
    1.7953,              #theta13
    1.5618,              #theta14
    2.9968,              #theta15
    1.3821,              #theta16
    -1.8960,              #theta21
    9.8960,              #theta20
    -200) #x0
    ,upper = c(
      0.1009,               #theta1
      -.Machine$double.xmin, #theta2
      0.0092,               #theta3
      -0.7414,               #theta4
      -0.9374,               #theta5
      0.9036,               #theta6
      0.5590,               #theta7
      0.6575,               #theta8
      0.6497,               #theta9
      0.1040,               #theta17
      0.1002,               #theta18
      0.1046,               #theta19
      0.8873,               #theta10
      -1.7225,               #theta11
      2.1873,               #theta12
      1.9953,               #theta13
      1.7618,               #theta14
      3.1968,               #theta15
      1.5821,               #theta16
      1.8960,              #theta21
      10.960,               #theta20
      200)                  #x0
  )
}

    
  plot.list = list()
  
  Time <- txtProgressBar(min = min(initial.values), max = max(initial.values), style = 3)
  for (init in initial.values){
      x0 = matrix(init,1,1)
      model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=cc,C=C,D=D,A=A,U=U,x0=x0,V0=V0)
      # Maximizaci?n
     tryCatch(
       { model2.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = TRUE, fun.kf = "MARSSkfss")
         model2.bfgs.cons.ci = MARSSparamCIs(model2.bfgs.cons)
      
         # Graficas
      
         year = data[1]
         plot.state = data.frame(year = year, value = t(model2.bfgs.cons$states), se.upp = t(model2.bfgs.cons$states)+t(model2.bfgs.cons$states.se), se.low = t(model2.bfgs.cons$states)-t(model2.bfgs.cons$states.se))
         names(plot.state) = c("year", "X", "Up", "Low")
        
         assign(paste0("estimators.",init), model2.bfgs.cons$coef)
    
         p = ggplot(data = plot.state, aes(y=X, x=year)) + 
             geom_line(color = "#dc322f", size = 1) + 
             geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
             theme_bw() + 
             labs(y = NULL, caption = paste("tetha10 = ",round(model2.bfgs.cons$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 2)", x = "Año")
        
         file.name = paste0("plot.state_modelo2_",init,".png")
         png(file.name)
         print(p)
         dev.off()
        
         print(paste("Iteration of initial state:",init,"---> COMPLETED"))
         setTxtProgressBar(Time, init)
        
       }, error = function(e){
        print(paste("Skipping iteration of initial state:",init,"---> FAILED"))
        setTxtProgressBar(Time, init)
        } 
    ) 
}
  
close(Time)

