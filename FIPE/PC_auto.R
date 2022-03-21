# This file selects the numer of principal components using either the GR or ER tests in Bai and Ng (2002) and extract the
# idiosyncratic residual

idiosyncratic.auto=function(data, test.type, variable){
  
  # Define tests in Bai, Ng (2002)   
  #ICp1.test=function(V, N, TT, k){log(V)+k*(N+TT)/(N*TT)*log((N*TT)/(N+TT))} 
  GR.test=function(k){log(V(k-1)/V(k))/log(V(k)/V(k+1))}
  ER.test=function(k){eigenvalue[k]/eigenvalue[k+1]}
  
  if (test.type=="GR"){test=GR.test}
  if (test.type=="ER"){test=ER.test}
  if (test.type !="GR" & test.type!="ER"){print("Warning: Test not avalable")}
  
  # Define matrices
  TT=ncol(data)
  N=nrow(data)
  datai=matrix(0, ncol=N, nrow=TT)
  var_i=matrix(0, ncol=N, nrow=1)  
  m=min(TT,N)

  # Calculate principal components and eigenvalues. NOTE: we scale directly by sqrt(NT) 
  pc_analysis=prcomp(t(data/sqrt(N*TT)), center = TRUE, scale.=TRUE)
  eigenvalue=(pc_analysis$sdev)^2
  
  # Define V()
  V=function(k){sum(eigenvalue[(k+1):m])}
  
  # Find kmax
  V0=V(0)
  kmax.diff=abs(eigenvalue-V0/m)
  kmax.star=max.col(t(-kmax.diff))
  kmax=round(min(kmax.star,2/3*m))
  
  # Initialize test vector
  test.value=matrix(0, ncol=1, nrow=kmax)
    
  # Estimate number of principal components npc
  for (k in 1:kmax){test.value[k]=test(k)}
  npc=max.col(t(test.value[2:kmax]))+1

  # Regress sectoral data on principal components and store the idiosyncratic residual
  pc.series=pc_analysis$x[,(1:npc)]
  for (i in 1:nrow(data)) {datai[,i]= data[i,]-pc.series %*%solve(t(pc.series)%*%pc.series)%*%t(pc.series)%*%data[i,]}

# Transpose and name   
datai=t(datai)
colnames(datai)=colnames(data)
  
# Message
print(paste("Number of factors automatically selected for ", variable, ": ",npc, sep=""))
print(paste("Variance of ", variable, " explained by common factors: ", round(100*sum(eigenvalue[1:npc])/V0), "%", sep=""))
  
  
# Create return list
PC_list=list("datai"=datai, "npc"=npc)  
  
# Return  
return(PC_list)
}
