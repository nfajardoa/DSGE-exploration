library(data.table)
library(MARSS)
library(openxlsx)
library(ggplot2)
library(stargazer)
#library(gridExtra)
#library(latex2exp)

rm(list=ls())

setwd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC')
data <- read.xlsx('Datos.xlsx')

#### MODELO 1

y = t(data[2])
d.selector = c(9,10,11,12,13,14)
d = t(data[d.selector]) 

ln_Y_r_lag = t(data[14])
ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,14]/data[2,14]))

c.selector = c(15,16,17,18,19,20,21,22)
c = rbind(ln_Y_r_lag,t(data[c.selector])) 

# Orden de las restricciones

Z = matrix(list("theta1"),1,1)
D = matrix(list("theta3","theta4","theta5","theta6","theta7","theta8"),1,6)
A = matrix(list("theta2"),1,1)
R = matrix(list("theta19"),1,1)
B = matrix(list("theta9"),1,1)
C = matrix(list("theta10","theta11","theta12","theta13","theta14","theta15","theta16","theta17","theta18"),1,9)
U = matrix(0,1,1)
Q = matrix(list("theta20"),1,1)
V0 = matrix(100,1,1)

# Última corresponde a x0

ctl = list(trace = 1, lower = c(
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
  ,upper = c(
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
)

# Especificaciones con cambios en el valor inicial

  initial.values = c(-10,-5,0,5,10)
  plot.list = list()
  
Time <- txtProgressBar(min = min(initial.values), max = max(initial.values), style = 3)
for (init in initial.values){
    
  x0 = matrix(init,1,1)
  model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,x0=x0,V0=V0)
  
  # Maximizaci?n
  
  tryCatch(
    { model1.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = TRUE, fun.kf = "MARSSkfss")
    model1.bfgs.cons.ci = MARSSparamCIs(model1.bfgs.cons)
    
    # Gr?ficas
    
    year = data[1]
    plot.state = data.frame(year = year, value = t(model1.bfgs.cons$states), se.upp = t(model1.bfgs.cons$states)+t(model1.bfgs.cons$states.se), se.low = t(model1.bfgs.cons$states)-t(model1.bfgs.cons$states.se))
    names(plot.state) = c("year", "X", "Up", "Low")
    
    assign(paste0("estimators.",init), model1.bfgs.cons$coef)

    p = ggplot(data = plot.state, aes(y=X, x=year)) + 
        geom_line(color = "#dc322f", size = 1) + 
        geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
        theme_bw() + 
        labs(y = NULL, caption = paste("tetha9 = ",round(model1.bfgs.cons$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 1)", x = "Año")
    
    file.name = paste0("plot.state_modelo1_",init,".png")
    png(file.name)
    print(p)
    dev.off()
    
    print(paste("Iteration of initial state:",init,"---> COMPLETED"))
    setTxtProgressBar(Time, init)
    
    }, error = function(e){
      
      print(paste("Skipping iteration of initial state:",init,"---> FAILED"))
      setTxtProgressBar(Time, init)
      
    })
}
close(Time)

