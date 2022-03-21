
% These file defines tehoretical @s that are uswed to construct the theoretical FIPE moments: the matrices
% Sigmab and Sigmaah are the projection matrices used in the likelihood

% Trasnfromations for priors
i        = @(rho) 1-rho  ;
r_fun    = @(rhat) rhat./(1+rhat); %y=r_fun(1) %z=r_fun(2) %r_fun=@(rhat){rhat/(1+rhat)}
R_fun    = @(Rhat) Rhat./(1+Rhat);   %d=R_fun(16)
G_fun    = @(Ghat) Ghat./(1+Ghat);
rhat_fun = @(r) r./(1-r);
Rhat_fun = @(R) R./(1-R);
Ghat_fun = @(G) G./(1-G);

% Define basic FUNCTIONs 
chi1=@(r)r+chi0/r;
kappa=@(r)(chi1(r)-1-chi0)/chi0;
a0=@(r,rho)(1-rho)*(chi0-rho)/(rho^2-rho*chi1(r)+chi0)-chi0*(chi1(r)-1-chi0)/((rho^2-rho*chi1(r)+chi0)*(chi1(r)-r)) ; %s=a0(2,3)

zeta0 = @(r,Rhat,rho) (a0(r,rho))^2+i(rho)*r^2+(a0(r, rho)+i(rho)*r)^2+((1-a0(r, rho))^2+(i(rho)+r-a0(r, rho)-i(rho)*r)^2)*Rhat ;
zeta1 = @(r,Rhat,rho) -(a0(r,rho)+i(rho)*r)^2-(i(rho)+r-a0(r, rho)-i(rho)*r)*(1-a0(r,rho))*Rhat ;
zeta2 = @(r,Rhat,rho) a0(r, rho)*i(rho)*r ;

zetat0  = @(r,Rhat,rho) (1-a0(r, rho))/(chi0*kappa(r))*(a0(r, rho)-(chi0*kappa(r)+1-a0(r, rho)+chi0*kappa(r)/(1-a0(r,rho))*(i(rho)+r-a0(r,rho)-i(rho)*r)*i(rho))*Rhat) ;
zetat1  = @(r,Rhat,rho) (1-a0(r, rho))*i(rho)*Rhat ;
zetat_1 = @(r,Rhat,rho) (1-a0(r, rho))/(chi0*kappa(r))*((1-a0(r, rho)+(i(rho)+r-a0(r, rho)-i(rho)*r)*(chi0*kappa(r)/(1-a0(r, rho))+1))*Rhat-2*a0(r, rho)-i(rho)*r) ;
zetat_2 = @(r,Rhat,rho) (1-a0(r, rho))/(chi0*kappa(r))*(2*i(rho)*r+a0(r, rho)-(i(rho)+r-a0(r, rho)-i(rho)*r)*Rhat) ;

zetah0 = @(lambda, r,Rhat,Ghat,rho) 2*(((1+i(rho))/2+(1-a0(r, rho))/(chi0*kappa(r)))*lambda^2*Rhat+(1-a0(r, rho))^2/(chi0*kappa(r))^2*(1+Rhat)*(lambda^2+Ghat)) ;
zetah1 = @(lambda, r,Rhat,Ghat,rho) -(((1+i(rho))*(1-a0(r, rho))/(chi0*kappa(r))+i(rho))*lambda^2*Rhat+(1-a0(r, rho))^2/(chi0*kappa(r))^2*(1+Rhat)*(lambda^2+Ghat)) ;

v      = @(r,Rhat,rho) (zeta0(r,Rhat,rho)+2*r*zeta1(r,Rhat,rho)+2*r^2*zeta2(r,Rhat,rho))/(1-r^2) ;
alpha1 = @(r,Rhat,rho) r+(zeta1(r,Rhat,rho)+r*zeta2(r,Rhat,rho))/v(r,Rhat,rho) ;
alpha2 = @(r,Rhat,rho) r*alpha1(r,Rhat,rho)+zeta2(r,Rhat,rho)/v(r,Rhat,rho) ;

b1  = @(r,Rhat,rho) alpha1(r,Rhat,rho)+zetat1(r,Rhat,rho)/v(r,Rhat,rho) ;
b0  = @(r,Rhat,rho) 1+(r*zetat1(r,Rhat,rho)+zetat0(r,Rhat,rho))/v(r,Rhat,rho) ;
b_1 = @(r,Rhat,rho) alpha1(r,Rhat,rho)+(r^2*zetat1(r,Rhat,rho)+r*zetat0(r,Rhat,rho)+zetat_1(r,Rhat,rho))/v(r,Rhat,rho) ;
b_2 = @(r,Rhat,rho) r*b_1(r,Rhat,rho)+(zeta2(r,Rhat,rho)+zetat_2(r,Rhat,rho))/v(r,Rhat,rho) ;

b1h=@(lambda,r,Rhat,Ghat,rho)lambda^2*b1(r,Rhat,rho)+lambda^2*(r^2*zetat1(r,Rhat,rho)+r*zetat0(r,Rhat,rho)+zetat_1(r,Rhat,rho))/v(r,Rhat,rho)+zetah1(lambda, r,Rhat,Ghat,rho)/v(r,Rhat,rho) ;
alphah0=@(lambda,r,Rhat,Ghat,rho) lambda^2*b0(r, Rhat,rho)+lambda^2*(zetat0(r,Rhat,rho)+r*zetat1(r,Rhat,rho))/v(r,Rhat,rho)+zetah0(lambda, r,Rhat,Ghat,rho)/v(r,Rhat,rho) ;

% Define @s for projection
if lags == 1
    Sigmabh=@(lambda, r,Rhat,Ghat,rho) [b1h(lambda, r,Rhat,Ghat,rho),lambda*b1(r,Rhat,rho), lambda*b0(r,Rhat,rho), lambda*b_1(r,Rhat,rho) ] ;
    Sigmaah=@(lambda, r,Rhat,Ghat,rho) [alphah0(lambda,r,Rhat,Ghat,rho),lambda*b0(r,Rhat,rho),lambda*b_1(r,Rhat,rho),lambda*b_2(r,Rhat,rho);...
                                        lambda*b0(r,Rhat,rho)          ,          1          , alpha1(r,Rhat,rho)   , alpha2(r,Rhat,rho)   ;...
                                        lambda*b_1(r,Rhat,rho)         ,  alpha1(r,Rhat,rho) ,   1                  , alpha1(r,Rhat,rho)   ;...
                                        lambda*b_2(r,Rhat,rho)         ,  alpha2(r,Rhat,rho) , alpha1(r,Rhat,rho)   ,     1                 ];
else
    Sigmabh=@(lambda, r,Rhat,Ghat,rho) [ lambda*b1(r,Rhat,rho), lambda*b0(r,Rhat,rho), lambda*b_1(r,Rhat,rho) ];
    Sigmaah=@(lambda, r,Rhat,Ghat,rho) [      1            , alpha1(r,Rhat,rho), alpha2(r,Rhat,rho)  ;...
                                        alpha1(r,Rhat,rho),     1             , alpha1(r,Rhat,rho)  ;...
                                        alpha2(r,Rhat,rho), alpha1(r,Rhat,rho),     1              ];
end


bh=@(theta_hat,rho) Sigmabh(theta_hat(1),r_fun(theta_hat(2)),theta_hat(3),theta_hat(4),rho)*inv(Sigmaah(theta_hat(1),r_fun(theta_hat(2)),theta_hat(3),theta_hat(4),rho)) ;
  
 

% Output list
%basic_list=list("chi1"=chi1, "a0"=a0,"bh"=bh)
basic_list.chi1 = chi1;
basic_list.a0   = a0;
basic_list.bh   = bh ;
