# This file creates the vector X of covariates in the likelihood, and standardize all the sectoral data by an
# estimated standard deviation of the measurement error (obtained from a preliminary regression)

standardize=function(Dmci, Dxii, nyears, nsectors){

Dmci.matrix=matrix(0, nrow=nsectors, ncol=(nyears+2))
Dxii.matrix=matrix(0, nrow=nsectors, ncol=nyears)

Dxii_lag=Dxii[,1:(nyears-1)]
Dmci_lag=Dmci[,2:nyears]
Dmci_cont=Dmci[,3:(nyears+1)]
Dmci_fut=Dmci[,4:c(nyears+2)]
Dxii_cont=t(Dxii[,2:nyears])

for (i in 1:nsectors){
  x=cbind(Dxii_lag[i,],Dmci_lag[i,], Dmci_cont[i,],Dmci_fut[i,])
  e=Dxii_cont[,i]- x  %*%  solve(t(x)%*%x)%*%t(x)%*%Dxii_cont[,i] # preliminary regression
  stdev.e=sd(e)
  Dxii.matrix[i,]=Dxii[i,]/stdev.e
  Dmci.matrix[i,]=Dmci[i,]/stdev.e
}
X=matrix(0, ncol=4, nrow=c((nyears-1)*nsectors))
X[,1]=  matrix(t(Dxii.matrix[,1:(nyears-1)]), ncol=1)
X[,2]=  matrix(t(Dmci.matrix[,2:nyears]), ncol=1)
X[,3]=  matrix(t(Dmci.matrix[,3:(nyears+1)]), ncol=1)
X[,4]=  matrix(t(Dmci.matrix[,4:(nyears+2)]), ncol=1)

Dxii=matrix(t(Dxii.matrix[,2:nyears]), ncol=1)

# Label data
colnames(X)=c("Dxi_lag", "Dmc_lag", "Dmc_cont", "Dmc_fut")
if (lags==0){
  X=X[,2:4] 
  }
colnames(Dxii)="Dxii_cont"

# Return 
return_list=list("regressors"=X, "regressand"=Dxii)

return(return_list)
}
