function mcmc_object = mcmc_thin(mcmc_object,thin)
    if nargin<2 ; thin=5; end;
    num_params = length(mcmc_object.par_names) ;
    if num_params > 1
        ind = 1:thin:length(mcmc_object.trace(:,1)) ;
        mcmc_object.trace = mcmc_object.trace(ind,:) ;
    else
        ind = 1:thin:length(mcmc_object.trace) ; % seq(1,length(mcmc_object.trace),thin) ;
        mcmc_object.trace = mcmc_object.trace(ind) ;
    end
      %return(mcmc_object)
end
