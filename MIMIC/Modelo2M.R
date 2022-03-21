library(data.table)
library(MARSS)
library(openxlsx)
library(ggplot2)
#library(gridExtra)
#library(latex2exp)

rm(list=ls())

####

#setwd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC')
setwd('/home/gfnun/Nicolas')
data <- read.xlsx('Datos.xlsx')

#### MODELO 2 Modificado

  y.selector = c(2,3)
  y = t(data[y.selector])
  
  d.selector = c(9,13,19,21,14)
  d = t(data[d.selector]) 
  
  ln_U_lead = t(data[21])
  ln_U_lead = shift(ln_U_lead, n=1, fill=NA, type="lead")
  ln_U_lead[28] = ln_U_lead[27]*(1+(data[28,21]/data[27,21]-1))
  
  d[4,] = ln_U_lead
  row.names(d)[4] = "Ut"
  
  ln_Y_r_lag = t(data[14])
  ln_Y_r_lag = shift(ln_Y_r_lag, n=1, fill=NA, type="lag")
  ln_Y_r_lag[1] = ln_Y_r_lag[2]/(1+(1 - data[1,14]/data[2,14]))
  
  c.selector = c(16,17,18,21,22)
  c = rbind(ln_Y_r_lag,t(data[c.selector])) 
  
  # Orden de las restricciones
  
  Z = matrix(list("theta1","theta2"),2,1)
  D = matrix(list("theta4","theta5",0,0,"theta6",0,0,"theta7","theta8",0),2,5,byrow = TRUE)
  A = matrix(0,2,1)
  R = matrix(list("theta17",0,0,"theta18"),2,2,byrow = TRUE)
  B = matrix(list("theta10"),1,1)
  C = matrix(list("theta11","theta12","theta13","theta14","theta15","theta16"),1,6)
  U = matrix(0,1,1)
  Q = matrix(list("theta20"),1,1)
  V0 = matrix(100,1,1)
  
  # ?ltima corresponde a x0
  
  ctl = list(lower = c(
    .Machine$double.xmin, #theta1
    -Inf,                 #theta2
    .Machine$double.xmin, #theta3
    -Inf,                 #theta4
    -Inf,                 #theta5
    .Machine$double.xmin, #theta6
    .Machine$double.xmin, #theta7
    .Machine$double.xmin, #theta8
    .Machine$double.xmin, #theta9
    .Machine$double.xmin, #theta17
    .Machine$double.xmin, #theta18
    .Machine$double.xmin, #theta19
    .Machine$double.xmin, #theta10
    -Inf,                 #theta11
    .Machine$double.xmin, #theta12
    .Machine$double.xmin, #theta13
    .Machine$double.xmin, #theta14
    .Machine$double.xmin, #theta15
    .Machine$double.xmin, #theta16
    .Machine$double.xmin, #theta20
    .Machine$double.xmin) #x0
    ,upper = c(
      Inf,                   #theta1
      -.Machine$double.xmin, #theta2
      Inf,                   #theta3 
      -.Machine$double.xmin, #theta4
      -.Machine$double.xmin, #theta5
      Inf,                   #theta6
      Inf,                   #theta7
      Inf,                   #theta8
      Inf,                   #theta9
      Inf,                   #theta17
      Inf,                   #theta18
      Inf,                   #theta19
      Inf,                   #theta10
      -.Machine$double.xmin, #theta11
      Inf,                   #theta12
      Inf,                   #theta13
      Inf,                   #theta14
      Inf,                   #theta15
      Inf,                   #theta16
      Inf,                   #theta20
      Inf)                   #x0
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
      { model2.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = TRUE, fun.kf = "MARSSkfss")
      model2.bfgs.cons.ci = MARSSparamCIs(model2.bfgs.cons)
      
      # Gr?ficas
      
      year = data[1]
      plot.state = data.frame(year = year, value = t(model2.bfgs.cons$states), se.upp = t(model2.bfgs.cons$states)+t(model2.bfgs.cons$states.se), se.low = t(model2.bfgs.cons$states)-t(model2.bfgs.cons$states.se))
      names(plot.state) = c("year", "X", "Up", "Low")
      
      assign(paste0("estimators.",init), model2.bfgs.cons$coef)
      
      p = ggplot(data = plot.state, aes(y=X, x=year)) + 
        geom_line(color = "#dc322f", size = 1) + 
        geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
        theme_bw() + 
        labs(y = NULL, caption = paste("tetha10 = ",round(model2.bfgs.cons$par$B[1],5)), title = "Economia Subterranea", subtitle = "(Modelo 2 Modificado)", x = "Año")
      
      file.name = paste0("plot.state_modelo2M_",init,".png")
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
