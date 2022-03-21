### Set prior and covariance matrix S for proposal distribution
# Define prior distributions and variace_covariance S for proposal distribution
# Note: the mean of the gamma distribution is equal to shape*scale, the variance is shape*scale^2

# Parameters for the priors
shape.rhat= 10 #4.0               
scale.rhat= (1/4)*20 #1/4
shape.Rhat= 10 #4.0   # 2.0
scale.Rhat= 2*10 #2.0   # 1/4
shape.Ghat= 2.0
scale.Ghat= 10
mean_Ghat=0 # for the normal distribution
sd_Ghat=0.2 # for the normal distribution 
mean.lambda=0     # for the normal distribution
sd.lambda=2*1.5   # for the normal distribution 
shape.lambda=8    # for the gamma distribution
scale.lambda=0.043# for the gamma distribution


# Define the prior functions fot the (transformed) parameters rhat, Rhat, Gammahat
prior.rhat=function(rhat){dgamma(rhat, shape=shape.rhat, scale = scale.rhat, log = FALSE)}
prior.Rhat=function(Rhat){dgamma(Rhat, shape=shape.Rhat, scale = scale.Rhat, log = FALSE)}

if(type.prior.Ghat==1){
prior.Ghat=function(Ghat){dnorm(Ghat, mean=mean_Ghat, sd = sd_Ghat)}
print("Normal prior for Ghat")}

if(type.prior.Ghat==0){
prior.Ghat=function(Ghat){dunif(Ghat,  min=0, max=2, log = FALSE)}
print("Uniform prior for Ghat")}

# Define the prior for lambda. The paper uses the normal distribution, i.e. type.prior==1 
if(type.prior==1){prior.lambda=function(lambda){dnorm(lambda, mean=mean.lambda, sd = sd.lambda)}
                  print("Normal prior for lambda")}


if(type.prior==0){mean.lambda=shape.lambda*scale.lambda
                  prior.lambda=function(lambda){dgamma(lambda, shape.lambda, scale = scale.lambda, log = FALSE)}
                  print("Gamma prior for lambda")}

if(type.prior==2){prior.lambda=function(lambda){dtruncnorm(lambda,a=-2, b=2, mean=mean.lambda, sd = sd.lambda)}
   print("Truncated Normal prior for lambda")}

type.prior

# Set initial variance covariance matrix S for the MCMC draws. This code can be adjusted to have differente S for different country/sectro-groups
if (country=="USA"||country=="UK"||country=="JPN"){
  if(sector==1||sector==2||sector==3||sector==4||sector==5||sector==0){S=tau*matrix(c(0.04, -0.0000, 0.0000, 0.0000, 
                                                               -0.0000,  0.0100,-0.0000, 0.0000, 
                                                                0.0000, -0.0000, 0.0200,-0.0000, 
                                                               -0.0000,  0.0000, 0.0000, 0.0400), ncol=4)}}
if (country=="COL"){
  if(sector==1||sector==2||sector==3||sector==4||sector==5||sector==0){S=tau*matrix(c(0.06, -0.0000, 0.0000, 0.0000, 
                                                                -0.0000,  0.0200,-0.0000, 0.0000, 
                                                                0.0000, -0.0000, 0.0300,-0.0000, 
                                                                -0.0000,  0.0000, 0.0000, 0.0600), ncol=4)}}
# Prior function: collect priors
prior=function(theta.hat){prior.lambda(theta.hat[1])*prior.rhat(theta.hat[2])*prior.Rhat(theta.hat[3])*prior.Ghat(theta.hat[4])}

# Output list
prior_list=list("covariance_proposal"=S, "prior_distribution"=prior)

