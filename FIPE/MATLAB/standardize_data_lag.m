function return_list = standardize_data_lag(Dmci, Dxii, nyears, nsectors)
% This file creates the vector X of covariates in the likelihood, and standardize all the sectoral data by an
% estimated standard deviation of the measurement error (obtained from a preliminary regression)
global lags
Dmci_matrix=zeros(nsectors, (nyears+2)) ;
Dxii_matrix=zeros(nsectors, nyears) ;
%size_Dxii_matrix = size(Dxii_matrix)

Dxii_lag  =Dxii(:,1:(nyears-1)) ;
Dmci_lag  =Dmci(:,2:nyears) ;
Dmci_cont =Dmci(:,3:(nyears+1)) ;
Dmci_fut  =Dmci(:,4:(nyears+2)) ;
Dxii_cont =(Dxii(:,2:nyears))' ;

for i = 1:nsectors
  x=[ Dxii_lag(i,:)',Dmci_lag(i,:)', Dmci_cont(i,:)', Dmci_fut(i,:)' ];
  %size_x = size(x)
  e=Dxii_cont(:,i)- x * inv(x'*x)*x'*Dxii_cont(:,i); % preliminary regression
  %size_e = size(e)
  %mean_e = mean(e)
  stdev_e=std(e) ;
  Dxii_matrix(i,:) = Dxii(i,:)/stdev_e ;
  Dmci_matrix(i,:) = Dmci(i,:)/stdev_e ;
end

X = zeros((nyears-1)*nsectors, 4) ;
%size(X)
%size(reshape(Dxii_matrix(:,1:(nyears-1)),[],1) )
X(:,1) =  reshape(Dxii_matrix(:,1:(nyears-1))',[],1);  % matrix(t(Dxii.matrix[,1:(nyears-1)]), ncol=1)
X(:,2) =  reshape(Dmci_matrix(:,2:nyears)',[],1) ;
X(:,3) =  reshape(Dmci_matrix(:,3:(nyears+1))',[],1) ;
X(:,4) =  reshape(Dmci_matrix(:,4:(nyears+2))',[],1) ;

%Dxii=reshape((Dxii_matrix(:,1:nyears))',[],1)  ; %, ncol=1)
Dxii=reshape((Dxii_matrix(:,2:nyears))',[],1)  ; %, ncol=1)

% Label data
%colnames(X)=c("Dxi_lag", "Dmc_lag", "Dmc_cont", "Dmc_fut")
if lags==0
  X=X(:,2:4); 
end
%colnames(Dxii)="Dxii_cont"

% Return 
%return_list=list("regressors"=X, "regressand"=Dxii)
return_list.regressors=X;
return_list.regressand=Dxii;

%return(return_list)
