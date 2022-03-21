# This file extract the numer of principal components explicitely specified in teh parameter nps and store the corresponding
# idiosyncratic residual


  idiosyncratic=function(data, npc, variable){
  # Calculate principal componennts  
  pc_analysis=prcomp(t(data), center = TRUE, scale.=TRUE)
  pc.series=pc_analysis$x[,(1:npc)]
  
  # Regress sectoral data on principal components and store the idiosyncratic residual
  datai=matrix(0, ncol=nrow(data), nrow=ncol(data))
  
  for (i in 1:nrow(data)) {datai[,i]= data[i,]-pc.series %*%solve(t(pc.series)%*%pc.series)%*%t(pc.series)%*%data[i,]
  }
  datai=t(datai)
  colnames(datai)=colnames(data)
  
  # Eigenvalues, variance and cumulative variance
if (npc>0){eig_data <- (pc_analysis$sdev)^2
           variance <- eig_data*100/sum(eig_data)
           cumvar <- cumsum(variance)
           print(paste("Variance of ", variable, " explained by common factors: ", round(cumvar[npc]),"%", sep=""))
}else{datai=data
      print(paste("Variance of ", variable, " explained by common factors: 0"))} 
  
  
  # return idiosyncratic component
  return(datai)
}
  