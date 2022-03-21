function val = Metro_Hastings(fcnHandle,pars,prop_sigma,par_names,iterations,burn_in,adapt_par )
%Metro_Hastings function(li_func,pars,prop_sigma=NULL,par_names=NULL,iterations=50000,burn_in=1000,adapt_par=c(100,20,0.5,0.75),quiet=FALSE,...)
if iterations <= burn_in ; error('number of iterations has to be greater than number of burn_in'); end;  %return ; end
if nargin<5 ; iterations=50000 ; burn_in=1000 ; adapt_par=[100,20,0.5,0.75] ; end
if nargin<6 ; burn_in=1000 ; adapt_par=[100,20,0.5,0.75] ; end
if nargin<7 ; adapt_par=[100,20,0.5,0.75] ; end
%if (!is.finite(li_func(pars, ...)))
if fcnHandle(pars) == Inf
    'Seed parameter values <pars> are not in the defined parameter space.  Try new starting values for <pars>.'
end
quiet = 0
%length_out = 4;
NN =size(pars,1)*size(pars,2); 
if isempty(par_names)
    par_names=char(66:(66+length(pars))); % letters(1:length(pars));
end

%     if !is.null(dim(prop_sigma))
%         if( ( dim(prop_sigma)[1] ~=  length(pars) ||  dim(prop_sigma)[2] ~= length(pars) ) && !is.null(prop_sigma) )
%             stop('prop_sigma not of dimension length(pars) x length(pars)')
%         end
%     end

%     if(is.null(prop_sigma)) %if no proposal matrix given, estimate the Fisher information to use as the diagonal (start in the right variance scale)
%         if(length(pars)~=1)
%             fit=optim(pars,li_func,control=list('fnscale'=-1),hessian=TRUE,...)
%                 fisher_info=solve(-fit$hessian)
%             prop_sigma=sqrt(diag(fisher_info))
%             prop_sigma=diag(prop_sigma)
%         else
%             prop_sigma=1+pars/2
%         end
%     end

prop_sigma=makePositiveDefinite(prop_sigma) ;%mu=pars;
pi_X=fcnHandle(pars) ; % =li_func(pars);	       % initial likelihood evaluation
k_X=pars;
trace=NaN(iterations,NN) ; %NaN(iterations,length(pars)) ;
deviance=NaN(iterations,1) ;
announce=floor(iterations/10:iterations/10:iterations) ;
% size_trace=size(trace)
% size_k_X = size(k_X)

for i = 1:iterations
    k_Y=randn(1,NN)*prop_sigma + k_X ;	% mvrnorm(1,mu=k_X,Sigma=prop_sigma)	% Draw proposal point
    pi_Y=fcnHandle(k_Y)   ;         % pi_Y=li_func(k_Y) ;		        % evaluate likelihood at proposal point     
    a_X_Y = (pi_Y)-(pi_X) ;		    % Compare relative likelihoods
    if isnan(a_X_Y)
       a_X_Y=-Inf ;  % never jump outside the range of the parameter space
    end
    if log(rand(1)) <= a_X_Y	        % Make the jump according to MH probability
        k_X = k_Y ;
        pi_X = pi_Y ;
    end
    trace(i,:)=k_X ; 
    deviance(i)=(-2*pi_X) ;                     % Store the deviance for calculating DIC
    if i>adapt_par(1) && mod(i,adapt_par(2))==0 && i<(adapt_par(4)*iterations) 	        % adapt the proposal covariance structure
        'adapt the proposal covariance structure'
        len=floor(i*adapt_par(3)):i ;
        x=trace(len,:);
        N=length(len);
        p_sigma = (N-1) * cov(x)/N ;
        p_sigma = makePositiveDefinite(p_sigma) ;  % To deal with rounding problems that can de-symmetrize
        if ~ismember(0,p_sigma) 
           prop_sigma=p_sigma ;
        end
    end
    if ~quiet && ismember(i,announce)
        %prop_sigma=prop_sigma
        ['updating: ',num2str(i/iterations*100),'%']
    end
end
%burn_in=burn_in
%iterations=iterations
%size_trace_last=size(trace)

trace([1:5 end-4:end],:)

trace=trace((burn_in+1):iterations,:) ;
%size_trace_out=size(trace)
DIC=NaN;
%% Calculate the DIC
D_bar=mean(deviance(burn_in:iterations));
%if length(pars)>1
%    %theta_bar=sapply(1:length(pars),function(x){mean( trace[,x] )})
%    theta_bar=mean(trace) ;
%else
    theta_bar=mean( trace );
%end
D_hat=fcnHandle(theta_bar); %li_func(theta_bar);
pD=D_bar-D_hat ;
DIC=D_hat + 2*pD ;
if length(pars)>1
    accept_rate=length(unique(trace(:,1)))/(iterations-burn_in);
else
    accept_rate=length(unique(trace))/(iterations-burn_in);
end
%val=list('trace'=trace,'prop_sigma'=prop_sigma,'par_names'=par_names,'DIC'=DIC,'acceptance_rate'=accept_rate)
val.trace=trace;
val.prop_sigma=prop_sigma;
val.par_names=par_names;
val.DIC=DIC;
val.acceptance_rate=accept_rate;

%class(val)='MHposterior'
%return(val)
