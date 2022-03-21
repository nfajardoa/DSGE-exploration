library(data.table)
library(MARSS)
library(openxlsx)

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

# Última corresponde a x0

ctl = list(lower = rep(.Machine$double.xmin,21), upper = rep(1, 21))

# Especificaciones

model.specs = list(Z=Z,R=R,B=B,Q=Q,d=d,c=c,C=C,D=D,A=A,U=U,tinitx=0)

# Maximización

model1.bfgs.cons = MARSS(y = y, model = model.specs, method = "BFGS", control = ctl, silent = FALSE)
model1.bfgs.cons.ci = MARSSparamCIs(model1.bfgs.cons)

model1.bfgs = MARSS(y = y, model = model.specs, method = "BFGS", silent = FALSE)
model1.bfgs.ci = MARSSparamCIs(model1.bfgs)

model1.em = MARSS(y = y, model = model.specs, silent = FALSE)
model1.em.ci = MARSSparamCIs(model1.em)

# Ojo, solo es calculado con EM

model1.boot = MARSSboot(model1, nboot=20, output="parameters", sim="parametric")

#### MODELO 2

y.selector = c(2,3,4)
y = t(data[y.selector])

d.selector = c(9,13,19,21,14)
d = t(data[d.selector]) 

ln_U_lead = t(data[21])
ln_U_lead = shift(ln_U_leap, n=1, fill=NA, type="lead")
ln_U_lead[28] = ln_U_lead[27]*(1+(data[28,21]/data[27,21]-1))

d[4,] = ln_U_lead
row.names(d)[4] = "Ut"

c.selector = c(15,16,17,18,19,20,21,22)
c = rbind(ln_Y_r_lag,t(data[c.selector])) 

