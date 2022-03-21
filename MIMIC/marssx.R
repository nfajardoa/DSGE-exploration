
#install.packages("MARSS")
require("MARSS")

#See the MARSS man page for examples
?MARSS

RShowDoc("UserGuide",package="MARSS")
RShowDoc("Quick_Start",package="MARSS")


inits = list(B=1, U=0, Q=0.05, Z=1, A=0, R=0.05, x0=-99, V0=0.05, G=0, H=0, L=0, C=0,D=0, c=0, d=0)
model = list(Z="identity", A="scaling", R="diagonal and equal", B="identity", U="unconstrained",
             Q="diagonal and unequal", x0="unconstrained", V0="zero", C="zero",D="zero",c=matrix(0,0,1),
             d=matrix(0,0,1), tinitx=0, diffuse=FALSE)
control=list(minit=15, maxit=5000, abstol=0.001, trace=1, sparse=FALSE, safe=TRUE, allow.degen=TRUE, min.degen.iter=50, 
             degen.lim=1.0e-04, min.iter.conv.test=15, conv.test.deltaT=9,
             conv.test.slope.tol= 0.5, demean.states=FALSE)
#For method="BFGS", type MARSS:::alldefaults$BFGS to see the defaults.

dat=t(datos_ES)
y <- as.vector(dat[2,])


#MARSS(y, inits=NULL, model=NULL, miss.value=as.numeric(NA), method = "kem", form = "marxsS")
#MARSS(y, inits=inits, model=model,  method = "kem")
# 

B1=matrix(list("b",0,0,"b"),2,2)
U1=matrix(0,2,1)
Q1=matrix(c("q11","q12","q12","q22"),2,2)
Z1=matrix(c(1,0,1,1,1,0),3,2)
A1=matrix(list("a1",0,0),3,1)
R1=matrix(list("r11",0,0,0,"r",0,0,0,"r"),3,3)
pi1=matrix(0,2,1); 
V1=diag(1,2)
model.list=list(B=B1,U=U1,Q=Q1,Z=Z1,A=A1,R=R1,x0=pi1,V0=V1,tinitx=0)

y3 <- dat[c(2,3,4),]

#fit=MARSS(y3, model=model.list)
#Stopped at iter=84 in MARSSkem: solution became unstable. Q update is not positive definite.
#par, kf, states, iter, loglike are the last values before the error.
#Try control$safe=TRUE which uses a slower but slightly more robust algorithm.
#Use control$trace=1 to generate a more detailed error report. See user guide for insight.

fit=MARSS(y3, model=model.list )



# Ahora 1 estados 2 observables
y2 <- dat[c(2,3),]

B1=matrix(list("b"),1,1)
U1=matrix(0,1,1)
Q1=matrix(c("q11"),1,1)
Z1=matrix(c(1,0),2,1)
A1=matrix(list("a1",0),2,1)
R1=matrix(list("r11",0,0,"r"),2,2)
pi1=matrix(0,1,1); 
V1=diag(1,1)
model.list=list(B=B1,U=U1,Q=Q1,Z=Z1,A=A1,R=R1,x0=pi1,V0=V1,tinitx=0)

control=list(minit=15, maxit=5000, abstol=0.001, trace=1, sparse=FALSE, safe=TRUE, allow.degen=FALSE, 
             min.degen.iter=100, degen.lim=1.0e-04, min.iter.conv.test=15, conv.test.deltaT=9,
             conv.test.slope.tol= 0.5, demean.states=FALSE)
fit=MARSS(y2, model=model.list )
# Standard errors have not been calculated. 
# Use MARSSparamCIs to compute CIs and bias estimates.



# Ahora 2 estados 2 observables
y2 <- dat[c(2,3),]

B1=matrix(list("b",0,0,"b"),2,2)
U1=matrix(0,2,1)
Q1=matrix(c("q11","q12","q12","q22"),2,2)
Z1=matrix(c(1,0,1,1),2,2)
A1=matrix(list("a1",0),2,1)
R1=matrix(list("r11",0,0,"r"),2,2)
pi1=matrix(0,2,1); 
V1=diag(1,2)
inits = list(B=1, U=0, Q=0.05, Z=1, A=0, R=0.5, x0=-99, V0=0.05, G=0, H=0, L=0, C=0,D=0, c=0, d=0)
model.list=list(B=B1,U=U1,Q=Q1,Z=Z1,A=A1,R=R1,x0=pi1,V0=V1,tinitx=1)
fit=MARSS(y2, model=model.list, inits=inits, method = "kem" )

MARSSboot(fit, nboot=10, output="parameters", sim="parametric", param.gen="MLE", control= NULL, silent=FALSE)

hess.list <- MARSSboot(fit, param.gen="hessian", nboot=4)

# bootstrapped parameter estimates
hess.list$boot.params


