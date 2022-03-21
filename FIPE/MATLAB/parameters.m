
% Parameters to choose. 
country='UK'  ;   % Country: UK, USA or JPN 
sector = 0    ;   % Select of group of sectors. To replicate the paper choose values 1, 2, 3. A value =0 stands for all sectors grouped together (not in the paper)
rho=1         ;   % Autocorrelation of shocks. Takes values 0, 1 
npc_Dmc='a'   ;   % Number of principal components to be removed from Dmc. If = 'a' then selection is automatic
npc_xi ='a'   ;   % Number of principal components to be removed from xi. If = 'a' then selection is automatic
type_test='ER';   % Test for automatic selection of npc. Values 'ER' or 'GR'.
type_prior=1  ;   % Type of prior for lambda. Takes value 1 for normal, 0 for gamma, 2 truncated Normal(-2,2)
   if type_prior==2
       require(truncnorm) 
   end
%global lags country rho burn_ini;
lags=1   % 1 for hybrid Phillips Curve 0 for just forward looking
iters=2*10^4 % Number of effective draws in the MCMC
burn_ini=10000   % Number of draws to drop at the begining in the MCMC
adapt_par=[100, 20, 0.5, 0.75] ; %[burn_ini/2, iters/40, 0.5, 0.75] ;

beta=0.97    ;   % subjective discount factor
chi0=1/beta  ;   % chi_0
tau=0.95     ;   % This is a scaling parameter for quickly adjusting the initial covariance matrix of the proposal distribution in the MCMC. 
