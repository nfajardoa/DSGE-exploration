% This file calls all the need satellite files to perform the estimations. I can be easily modified to work 
% in isolation from the the 'main.R' file. To do this, just call the model's parameters directly from here, i.e. activate:
% source('parameters.R')


%Preamble
% library(AER)
% library(mvtnorm)
% library(lmtest)
% library(MHadaptive)


%Set seed
%set.seed(12345)
%set.seed(0)
%set.seed(1968)

% Load the file with the parameters. Omit this if the current file is already called from outside
% source('parameters.R')

% Print on screen the country and sector-group being estimated
{'Country: ', country}
{'sector = ', sector}
{'rho = '   , rho}

% Load dataset. The dataset is constructed using the program file 'Extract_Bayes_data.R' stanrtin gfrom teh orignal EXcel files in EUKLEMS
% NB: the matrix of (first difference) real marignal costs Dmc starts one year earlier than the matrix of 
% (first difference) inflation DDp, and thus contains one extra observation.
%load(paste(country,'_Bayes_data.RData', sep=''))
eval ([ 'load ', country, '_Bayes_data' ]) ;

%repmat(mean(Dmc,2)',(nyears+1),1)'
% De-mean and calculate the (first difference) inflation gap Dxi
Dmc = Dmc - reshape(repmat(mean(Dmc,2)', (nyears+1),1)', [], nyears+1 ) ;
%mean(Dmc,2)
%Dmc = Dmc - reshape(repmat(mean(Dmc,2)', (nyears+1),1), [(nyears+1),(nyears+1) ] ) ;
DDp = DDp - reshape(repmat(mean(DDp,2)', nyears,1)', [], nyears ) ;
%            repmat(mean(DDp),  nyears   ,nyears)  ;
Dxi=DDp(:,1:(nyears-1))-beta*DDp(:,2:nyears)  ;
nyears=nyears-1;

% Select the appropriate sector-group: Keep only the sectors chosen by the parameter 'sector'.
Dmc = Dmc(first_sector(sector+1):last_sector(sector+1),:) ;
Dxi = Dxi(first_sector(sector+1):last_sector(sector+1),:) ;
nsectors=last_sector(sector+1)-first_sector(sector+1)+1 ;

%size_Dmc=size(Dmc)
% Extract residual from Principal Component analysis. Use the file 'PC_auto.R' if extraction is set to automatic; 
% use 'PC_idiosyncratic.R'if extraction is manual 
if npc_Dmc=='a'
       %run 'PC_auto.m'
       %PC_list_Dmc=idiosyncratic_auto(Dmc, type_test, 'Dmc') ;
       PC_list_Dmc=PC_auto(Dmc, type_test, 'Dmc' ) ;
       Dmci=PC_list_Dmc.datai   ;
       Dmc_npc= PC_list_Dmc.npc ;
else
    source('PC_idiosyncratic.R')
         {'number of factors for Dmc:', npc_Dmc }
         Dmci=idiosyncratic(Dmc, npc_Dmc, 'Dmc') ;
end
     
if npc_xi=='a'
         %source('PC_auto.R')
         PC_list_xi=PC_auto(Dxi, type_test, 'Dxii') ;
         Dxii_matrix=PC_list_xi.datai ;
         Dxi_npc= PC_list_xi.npc ;
else 
   %source('PC_idiosyncratic.R')   ; 
   {'number of factors for Dxi: '  npc_xi  }
   Dxii_matrix=idiosyncratic(Dxi, npc_xi, 'xii')   ;
end       

% Standardize idiosyncratic variables data by the variance of the prelimanary regression (variance of the residual error term, see appendix of the paper)
%run 'standardize_data_lag.m'
standardized_list=standardize_data_lag(Dmci, Dxii_matrix, nyears, nsectors) ;
X=standardized_list.regressors ;
Dxii=standardized_list.regressand ;

% Load the basic theoretical functions used to construct the FIPE moments
run 'basic_functions_lag.m'

% Load Prior distribution and covaraince matrix for the proposal
run 'prior_proposal_lag.m'

%Likelihood 
log_like   = @(theta_hat) -0.5*(Dxii-X*bh(theta_hat,rho)')'*(Dxii-X*(bh(theta_hat,rho))') ; 
log_prior  = @(theta_hat) log(prior(theta_hat)) ;
log_target = @(theta_hat) log_like(theta_hat)+log_prior(theta_hat) ;

% MCMC simulation. Initial value of the chain uses transformed values rhat and Rhat of, respectively, r=0.2 and R=1/3

theta_hat0 = [0.0001,rhat_fun(0.2), Rhat_fun(1/3), 1] ;
%theta_hat0 = [0.1,rhat_fun(0.2), Rhat_fun(1/3), 0.5 ] ;
%bh0 = bh(theta_hat0,rho)
log_like0   = log_like(theta_hat0)   
%log_prior0  = log_prior(theta_hat0)  
log_target0 = log_target(theta_hat0) 


if Max_Lik == 1 
   options = optimoptions('fminunc','display','iter-detailed' ,'Algorithm','quasi-newton','FunctionTolerance',10e-8,'FiniteDifferenceType','central','OptimalityTolerance',10e-5,'HessUpdate','dfp','MaxFunctionEvaluations',5000,'MaxIterations',5000);
   [PARAM_HAT,fval,exitflag,output,grad,hessian] = fminunc(@(PARAM) -log_like(PARAM),theta_hat0,options);
   PARAM_HAT=PARAM_HAT
   Var_0 = makePositiveDefinite(hessian^-1)   % O J O : NO se multiplica por (-1) pues esta minimizando el negativo de la Likelihood
   DDiag = diag(Var_0)
   SD = (diag(hessian^-1)).^0.5 ;
   theta_hat0 = PARAM_HAT
   log_like0   = log_like(theta_hat0)   % Initialize from optimized values.
   log_target0 = log_target(theta_hat0) % Initialize from optimized values.
    % %% 4.3. Likelihood Maximization by using unconstrained (with hessian computation) optimization's method 
% 
%   options = optimoptions('fminunc','display','iter-detailed' ,'Algorithm','quasi-newton','FunctionTolerance',10e-8,'FiniteDifferenceType','central','OptimalityTolerance',10e-5,'HessUpdate','dfp');
%   [PARAM_HAT,fval,exitflag,output,grad,hessian] = fminunc(@(PARAM) -NKM_LIKF(PARAM,X_1_0,W),PARAM0,options);
% 
%   SD = diag(hessian^-1).^0.5;
%   
% %% Reporting Outcomes
%   
%     fprintf(['\n                       Estimation Outcomes \n'])     
%     fprintf('\n --------------------------------------------------------------    \n')
%     fprintf('\n  Parameter          Value          Std.Error     t-statistic      \n')
%     fprintf('\n                                                                  \n')
%     fprintf('     sigma:             %5.4f          %5.4f         %5.4f\n', PARAM_HAT(1), SD(1), PARAM_HAT(1)/SD(1))
%     fprintf('     beta:              %5.4f          %5.4f         %5.4f\n', PARAM_HAT(2), SD(2), PARAM_HAT(2)/SD(2))
%     fprintf('     alpha:             %5.4f          %5.4f         %5.4f\n', PARAM_HAT(3), SD(3), PARAM_HAT(3)/SD(3))
%     fprintf('     eta:               %5.4f          %5.4f         %5.4f\n', PARAM_HAT(4), SD(4), PARAM_HAT(4)/SD(4))
% %%    fprintf('     phi_pie:           %5.4f          %5.4f         %5.4f\n', PARAM_HAT(5), SD(5), PARAM_HAT(5)/SD(5))
% %%    fprintf('     phi_x:             %5.4f          %5.4f         %5.4f\n', PARAM_HAT(6), SD(6), PARAM_HAT(6)/SD(6))
% %%    fprintf('     rho_e:             %5.4f          %5.4f         %5.4f\n', PARAM_HAT(7), SD(7), PARAM_HAT(7)/SD(7))
% %%    fprintf('     rho_u:             %5.4f          %5.4f         %5.4f\n', PARAM_HAT(8), SD(8), PARAM_HAT(8)/SD(8))
%    fprintf('\n --------------------------------------------------------------    \n')


end

% install.packages('PAWL')
% library(PAWL)
% showClass('tuningparameters')
% mhparameters <- tuningparameters(nchains = 2, niterations = 10000, adaptiveproposal = TRUE)
% 
% %mcmc_P=adaptiveMH(log_target, AP, proposal, verbose)
% mcmc_P=adaptiveMH(log_target, mhparameters)

%function Metro_Hastings(fcnHandle , pars      ,prop_sigma,       par_names               ,iterations, burn_in , adapt_par )
%mcmc_r = Metro_Hastings(log_target, theta_hat0,  S       ,{'lambda','rhat','Rhat','Ghat'},   iters   , burn_ini, adapt_par ) ;

%function out = MetropolisHastings(fcnHandle,pars,prop_sigma,par_names,iterations,burn_in, tau) 
mcmc_r = MetropolisHastings(log_target, theta_hat0,  S       ,{'lambda','rhat','Rhat','Ghat'},   iters   , burn_ini, 0.9 ) ;

mcmc_r.trace([1:5 end-4:end],:)

mcmc_all=mcmc_r
mcmc_r=mcmc_thin(mcmc_all,  3)
S_adapted=mcmc_r.prop_sigma ;
theta_hat=mcmc_r.trace ;
size_theta_hat=size(theta_hat)
%size(S_adapted)

% Create the vector theta of posteriors to be used for the graphs (rhat and Rhat transformed back to r and R)
theta     = theta_hat ;
theta(:,2)= r_fun(theta_hat(:,2));
theta(:,3)= R_fun(theta_hat(:,3));
%colnames(theta)= {'lambda', 'r', 'R', 'G'}

