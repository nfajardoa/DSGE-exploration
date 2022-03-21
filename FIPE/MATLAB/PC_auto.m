% This file selects the numer of principal components using either the GR or ER tests in Bai and Ng (2002) and extract the
% idiosyncratic residual
function PC_list = PC_auto(data, test_type, variable)
  % Define tests in Bai, Ng (2002)   
  %ICp1.test=function(V, N, TT, k){log(V)+k*(N+TT)/(N*TT)*log((N*TT)/(N+TT))} 
  GR_test=@(k) log(V(k-1)/V(k))/log(V(k)/V(k+1)) ;
  ER_test=@(k) eig(k)/eig(k+1) ; %ER_test=@(k) eigenvalue(k)/eigenvalue(k+1) ;
  
  if test_type=='GR'; test=GR_test ; end
  if test_type=='ER'; test=ER_test ; end
  if test_type ~= 'GR' & test_type ~= 'ER'
      'Warning: Test not avalable' 
  end
  
  % Define matrices
  [N, TT]=size(data);
  datai=zeros(TT, N) ;
  var_i=zeros(1, N)  ;
  m=min(TT,N) ;

  % Calculate principal components and eigenvalues. NOTE: we scale directly by sqrt(NT) 
  %pc_analysis=prcomp((data/sqrt(N*TT))', center = TRUE, scale=TRUE)
  [coeff, score, latent]=princomp(zscore((data/sqrt(N*TT))')) ;

  eigenvalue=latent ;  %eigenvalue=(pc_analysis.sdev)^2 ;
  %size_datat=size(data')
  %size_coeff=size(coeff)
  % Define V()
  V=@(k) sum(eigenvalue((k+1):m)) ;
  %m=m
  %size_eigenvalue=size(eigenvalue)
  % Find kmax
  V0=V(0) ;
  kmax_diff=abs(eigenvalue-V0/m) ;
  %kmax_star=max.col(t(-kmax.diff))    % Find the maximum position for each row of a matrix, breaking ties at random
  [ ~, kmax_star] = max((-kmax_diff)') ;

  kmax=round(min(kmax_star,2/3*m)) ;
  
  % Initialize test vector
  test_value=zeros(1, kmax) ;
    
  % Estimate number of principal components npc
  for k = 1:kmax 
      test_value(k)=test(k) ;
  end
  %npc=max.col(t(test.value(2:kmax)))+1 ;
  [~,npc]=max((test_value(2:kmax))) ;
  npc=npc+1 ;
  % Regress sectoral data on principal components and store the idiosyncratic residual
  pc_series=score(:,(1:npc)) ;  %pc_analysis$x(:,(1:npc)) ;    O J O : el primer factor tiene signo contrario respecto a R
%   size_pc_series=size(pc_series)
%   size_data=size(data)
%   size_datai=size(datai)
  
  for i = 1:size(data,1) 
      datai(:,i)= (data(i,:)'-pc_series*inv(pc_series'*pc_series)*(pc_series')*data(i,:)')'; % #ok<MINV>
  end
% size_dataiii=size(dataiii)
% dataiii
% Transpose and name   
datai=(datai)' ;
%colnames(datai)=colnames(data)
  
% Message
{'Number of factors automatically selected for ', variable, ': ',npc }
{'Variance of ', variable, ' explained by common factors: ', round(100*sum(eigenvalue(1:npc))/V0), '%' }
  
% Create return list
%PC_list=list('datai'=datai, 'npc'=npc)  
PC_list.datai=datai ;
PC_list.npc =npc ;
  
% Return  
%return(PC_list)
end
