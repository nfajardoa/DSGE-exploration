library(data.table)
library(MARSS)
library(openxlsx)
library(ggplot2)
library(gridExtra)
library(latex2exp)

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
x0 = matrix(0,1,1)
V0 = matrix(100,1,1)

# Última corresponde a x0

ctl = list(trace = 1, lower = c(
  .Machine$double.xmin, #theta1
  -Inf,                 #theta3
  -Inf,                 #theta4
  -Inf,                 #theta5
  .Machine$double.xmin, #theta6
  -Inf,                 #theta7
  .Machine$double.xmin, #theta8
  .Machine$double.xmin, #theta2
  .Machine$double.xmin, #theta19
  .Machine$double.xmin, #theta9
  .Machine$double.xmin, #theta10
  .Machine$double.xmin, #theta11
  .Machine$double.xmin, #theta12
  .Machine$double.xmin, #theta13
  .Machine$double.xmin, #theta14
  .Machine$double.xmin, #theta15
  -Inf,                 #theta16
  .Machine$double.xmin, #theta17
  .Machine$double.xmin, #theta18
  .Machine$double.xmin, #theta20
  .Machine$double.xmin) #x0
  ,upper = c(
  Inf,                   #theta1
  -.Machine$double.xmin, #theta3
  -.Machine$double.xmin, #theta4
  -.Machine$double.xmin, #theta5
  Inf,                   #theta6
  -.Machine$double.xmin, #theta7
  Inf,                   #theta8
  Inf,                   #theta2
  Inf,                   #theta19
  Inf,                   #theta9
  Inf,                   #theta10
  Inf,                   #theta11
  Inf,                   #theta12
  Inf,                   #theta13
  Inf,                   #theta14
  Inf,                   #theta15
  -.Machine$double.xmin, #theta16
  Inf,                   #theta17
  Inf,                   #theta18
  Inf,                   #theta20
  Inf)                   #x0
  )

# Especificaciones

model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,x0=x0,V0=V0)

# Maximización

model1.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = FALSE, fun.kf = "MARSSkfss")
model1.bfgs.cons.ci = MARSSparamCIs(model1.bfgs.cons)

#model1.bfgs = MARSS(y = y, model = model.specs, method = "BFGS", silent = FALSE)
#model1.bfgs.ci = MARSSparamCIs(model1.bfgs)

#model1.em = MARSS(y = y, model = model.specs, silent = FALSE)
#model1.em.ci = MARSSparamCIs(model1.em)

# Ojo, solo es calculado con EM

#model1.boot = MARSSboot(model1.bfgs.cons, nboot=20, output="parameters", sim="parametric")

# Gráficas

year = data[1]
plot.state = data.frame(year = year, value = t(model1.bfgs.cons$states), se.upp = t(model1.bfgs.cons$states)+t(model1.bfgs.cons$states.se), se.low = t(model1.bfgs.cons$states)-t(model1.bfgs.cons$states.se))
names(plot.state) = c("Año", "X", "Up", "Low")
ggplot(data = plot.state, aes(y=X, x=Año)) + geom_line(color = "#00AFBB", size = 2) + geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + xlim(min(plot.state$Año),max(plot.state$Año)) + theme_light()

rm(list=ls())

####

setwd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC')
data <- read.xlsx('Datos.xlsx')

#### MODELO 2

for (init in -100:100){

y.selector = c(2,3,4)
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

Z = matrix(list("theta1","theta2","theta3"),3,1)
D = matrix(list("theta4","theta5",0,0,"theta6",0,0,"theta7","theta8",0,0,0,0,0,"theta9"),3,5,byrow = TRUE)
A = matrix(0,3,1)
R = matrix(list("theta17",0,0,0,"theta18",0,0,0,"theta19"),3,3)
B = matrix(list("theta10"),1,1)
C = matrix(list("theta11","theta12","theta13","theta14","theta15","theta16"),1,6)
U = matrix(0,1,1)
Q = matrix(list("theta20"),1,1)
x0 = matrix(init,1,1)
V0 = matrix(100,1,1)

# Última corresponde a x0

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

# Especificaciones

model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,x0=x0,V0=V0)

# Maximización

model2.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = FALSE)
model2.bfgs.cons.ci = MARSSparamCIs(model2.bfgs.cons)

#model2.bfgs = MARSS(y = y, model = model.specs, method = "BFGS", silent = FALSE)
#model2.bfgs.ci = MARSSparamCIs(model2.bfgs)

#model2.em = MARSS(y = y, model = model.specs, silent = FALSE)
#model2.em.ci = MARSSparamCIs(model2.em)

# Ojo, solo es calculado con EM

#model2.boot = MARSSboot(model1.bfgs.cons, nboot=20, output="parameters", sim="parametric")

# Gráficas

year = data[1]
plot.state = data.frame(year = year, value = t(model2.bfgs.cons$states), se.upp = t(model2.bfgs.cons$states)+t(model2.bfgs.cons$states.se), se.low = t(model2.bfgs.cons$states)-t(model2.bfgs.cons$states.se))
names(plot.state) = c("Año", "X", "Up", "Low")

assign(paste0("plot.state.",init),ggplot(data = plot.state, aes(y=X, x=Año)) + geom_line(color = "#00AFBB", size = 2) + geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3)) 
}

rm(list=ls())

####

setwd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/MIMIC')
data <- read.xlsx('Datos.xlsx')

#### MODELO 2 Modificado

try(
  
  {
  for (init in seq(-100,100,2)){
  
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
  x0 = matrix(init,1,1)
  V0 = matrix(100,1,1)
  
  # Última corresponde a x0
  
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
  
  # Especificaciones
  
  model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,x0=x0,V0=V0)
  
  # Maximización
  
  model2.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = FALSE)
  model2.bfgs.cons.ci = MARSSparamCIs(model2.bfgs.cons)
  
  #model2.bfgs = MARSS(y = y, model = model.specs, method = "BFGS", silent = FALSE)
  #model2.bfgs.ci = MARSSparamCIs(model2.bfgs)
  
  #model2.em = MARSS(y = y, model = model.specs, silent = FALSE)
  #model2.em.ci = MARSSparamCIs(model2.em)
  
  # Ojo, solo es calculado con EM
  
  #model2.boot = MARSSboot(model1.bfgs.cons, nboot=20, output="parameters", sim="parametric")
  
  # Gráficas
  
  year = data[1]
  plot.state = data.frame(year = year, value = t(model2.bfgs.cons$states), se.upp = t(model2.bfgs.cons$states)+t(model2.bfgs.cons$states.se), se.low = t(model2.bfgs.cons$states)-t(model2.bfgs.cons$states.se))
  names(plot.state) = c("Año", "X", "Up", "Low")
  
  assign(paste0("estimators.",init), model1.bfgs.cons$coef)
  
  png(paste0("plot.state_",init,".png"))
  ggplot(data = plot.state, aes(y=X, x=Año)) + 
    geom_line(color = "#dc322f", size = 1) + 
    geom_ribbon(data= plot.state,aes(ymin=Low,ymax=Up),alpha=0.3) + 
    theme_bw() + 
    labs(y = NULL, caption = paste("tetha10 = ",round(model2.bfgs.cons$par$B[1],5)), title = "Economía Subterránea", subtitle = "(Modelo 2 Modificado)")
  dev.off()
  
  }
  }
  )

