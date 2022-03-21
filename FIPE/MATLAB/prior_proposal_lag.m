
%%% Set prior and covariance matrix S for proposal distribution
% Define prior distributions and variace_covariance S for proposal distribution
% Note: the mean of the gamma distribution is equal to shape*scale, the variance is shape*scale^2

% Parameters for the priors
shape_rhat= 10 %4.0 ;              
scale_rhat= (1/4)*20 %1/4 ;
shape_Rhat= 10 %4.0 ;  % 2.0
scale_Rhat= 2*10 %2.0 ;  % 1/4
%shape_Ghat= 2.0 ;
%scale_Ghat= 10  ;
mean_Ghat=0   ;  % for the normal distribution
sd_Ghat=0.2 ;  % for the normal distribution 
mean_lambda=0   ;  % for the normal distribution
sd_lambda=2*1.5 ;  % for the normal distribution 
shape_lambda=8  ;  % for the gamma distribution
scale_lambda=0.043;% for the gamma distribution


% Define the prior @s fot the (transformed) parameters rhat, Rhat, Gammahat
%prior.rhat=@(rhat) dgamma(rhat, shape=shape.rhat, scale = scale.rhat, log = FALSE) ;
%prior.rhat=@(rhat) dgamma(rhat, shape=shape.rhat, scale = scale.rhat, log = FALSE) ;

%prior_rhat = @(rhat) gamma2_pdf(rhat, shape_rhat, scale_rhat);
prior_rhat = @(rhat) gamma2_pdf(rhat, 0, 1);
%prior_rhat = @(rhat) gampdf(rhat, shape_rhat, scale_rhat);
 
prior_Rhat = @(Rhat) gamma2_pdf(Rhat, shape_Rhat, scale_Rhat) ;
%prior_Rhat = @(Rhat) gampdf(Rhat, shape_Rhat, scale_Rhat) ;
 
prior_Ghat=@(Ghat) normpdf(Ghat, mean_Ghat, sd_Ghat) ;
%prior_Ghat = @(Ghat) uniform_pdf(Ghat, shape_Ghat, scale_Ghat) ; 
%prior_Ghat = @(Ghat) unifpdf(Ghat, 0, 2) ; 

% Define the prior for lambda. The paper uses the normal distribution, i.e. type.prior==1 
if type_prior==1 
    prior_lambda=@(lambda) normpdf(lambda, mean_lambda, sd_lambda) ;
    'Normal prior for lambda'
elseif (type_prior==0)
    %mean.lambda=shape.lambda*scale.lambda
    %prior_lambda=@(lambda) gamma2_pdf(lambda, shape_lambda, scale_lambda);
    prior_lambda=@(lambda) gampdf(lambda, shape_lambda, scale_lambda);
    'Gamma prior for lambda'
elseif type_prior==2 
    prior_lambda=@(lambda) dtruncnorm(lambda, -2, 2, mean_lambda, sd_lambda) ;
    'Truncated Normal prior for lambda'
end

type_prior

% Set initial variance covariance matrix S for the MCMC draws. This code can be adjusted to have differente S for different country/sectro-groups
if strcmp(country,'USA') || strcmp(country,'UK') || strcmp(country,'JPN')
  if sector==1 || sector==2 || sector==3 || sector==0  
      S=tau*[ 0.04, -0.0000, 0.0000, 0.0000   ;
             -0.0000,  0.0100,-0.0000, 0.0000 ; 
              0.0000, -0.0000, 0.0200,-0.0000 ; 
             -0.0000,  0.0000, 0.0000, 0.0400 ] ;
  end
end
if strcmp(country,'COL')
  if sector==1||sector==2||sector==3||sector==0
         S=tau*[ 0.06  , -0.0000, 0.0000, 0.0000 ; 
                -0.0000,  0.0200,-0.0000, 0.0000 ; 
                 0.0000, -0.0000, 0.0300,-0.0000 ; 
                -0.0000,  0.0000, 0.0000, 0.0600 ]; 
  end
end
% Prior function: collect priors
prior=@(theta_hat) prior_lambda(theta_hat(1))*prior_rhat(theta_hat(2))*prior_Rhat(theta_hat(3))*prior_Ghat(theta_hat(4));

% Output list
%%prior_list=list("covariance_proposal"=S, "prior_distribution"=prior)
%prior_list=list('covariance_proposal'=S, 'prior_distribution'=prior)

