function out = MetropolisHastings(fcnHandle,pars,prop_sigma,par_names,iterations,burn_in, tau) 
%function val = Metro_Hastings(fcnHandle,pars,prop_sigma,par_names,iterations,burn_in,adapt_par )
%==========================================================================
%                   Metropolis-Hastings Algorithm
%=========================================================================
% clc
% clear 
% close all
% delete *.asv

tic

l = path;

% path('Mfiles',path);
% path('Optimization Routines',path);
% path('LRE',path);
% path('Matfiles',path);


disp('                                                                  ');
disp('    BAYESIAN ESTIMATION OF FIPE MODEL: METROPOLIS-HASTINGS        ');
disp('                                                                  ');

%=========================================================================
%                  METROPOLIS-HASTINGS ALGORITHM 
% (Report the Acceptance Rate and Recursive Averages Every 500 draws) 
%=========================================================================

% load MH_candidate
Nsim    = iterations;     % = input('How Many Posterior Draws?:  ');
c             = tau;  %0.2;
c0            = tau; %0.2;
Nburn         = burn_in; %int32(0.50*Nsim)+2;
NN =size(pars,1)*size(pars,2); 
Thetasim      = zeros(Nsim,NN);
mode = pars ;
% Initialize by taking a draw from a distribution centered at mode
go_on = 0;
while go_on == 0
   Thetac = mvnrnd(mode',c0*prop_sigma);
   go_on = 1 ;  % (Thetac(8)<=1)*(Thetac(9)<=1)*(Thetac(10)<=1)*(Thetac(2)<=1);  % bounds
end
%Thetasim(1,:) = Thetac;
Thetasim(1,:) = pars ;


accept        = 0;
obj           = fcnHandle(Thetasim(1,:)) ; % dsgeliki(Thetasim(1,:)) + prior(Thetasim(1,:));
counter       = 0;
logposterior  = obj*ones(Nsim,1);

%log_like0   = log_like(theta_hat0)   
%log_prior0  = log_prior(theta_hat0)  
%log_target0 = log_target(theta_hat0) 


for i=1:Nsim
    %Thetac = mvnrnd(Thetasim(i,:),c*Sigma);
    Thetac = mvnrnd(Thetasim(i,:),c*prop_sigma);
    CheckBounds = 1 ; %(Thetac(8)<=1)*(Thetac(9)<=1)*(Thetac(10)<=1)*(Thetac(2)<=1);  % bounds
    if CheckBounds == 1 
       %prioc = prior(Thetac);    
       %likic = dsgeliki(Thetac);
       objc  = fcnHandle(Thetac);  %prioc+likic;       
       if objc == -Inf
          Thetasim(i+1,:) = Thetasim(i,:);
          logposterior(i+1) = obj;
       else % objc > -Inf
          alpha = min(1,exp(objc-obj));
          u = rand(1);
          if u<=alpha
             Thetasim(i+1,:)   = Thetac;
             accept            = accept+1;
             obj               = objc;
             logposterior(i+1) = objc;
          else
             Thetasim(i+1,:)   = Thetasim(i,:);
             logposterior(i+1) = obj;
          end
       end % if objc == -Inf
    else % CheckBounds NE 1
       Thetasim(i+1,:) = Thetasim(i,:);
       logposterior(i+1) = obj;
    end  % if CheckBounds == 1
    acceptancerate     = accept/i;
    counter            = counter + 1;

    if counter==50000
       disp('                                                                  ');
       disp(['                               DRAW NUMBER:', num2str(i)]         );
       disp('                                                                  ');
       disp('                                                                  ');    
       disp(['                           ACCEPTANCE RATE:', num2str(acceptancerate)]);
       disp('                                                                  ');
       disp('                                                                  ');    
       disp('                            RECURSIVE (Accum.) AVERAGES                    ');
       disp('                                                                  ');
       disp(' lambda         r           R          gamma ');
       disp(num2str(mean(Thetasim(1:i,:))));  
       disp('                                                                  ');
       counter = 0;
    end % if counter==500
    
end %for i=1:Nsim

Thetasim    = Thetasim(Nburn:end,:);

logposterior= logposterior(Nburn:end);

save mhdraws Thetasim logposterior   % Save posterior draws

%[Nsim,Npam] = size(Thetasim) ;

m = prctile(Thetasim(:,1:NN), [5 50 95],1)';  %moment(Thetasim(:,1:NN),1);
%[yy05, yy, yy95] = prctile(Thetasim(:,1:NN), [5 50 95],1)'  %moment(Thetasim(:,1:NN),1);
yy05 = m(:,1)' ;
yy   = m(:,2)' ;
yy95 = m(:,3)' ;

out.logposterior    = logposterior ;
out.trace           = Thetasim    ;
out.yy05            = yy05 ;
out.yy              = yy ;
out.yy95            = yy95 ;
out.par_names       = par_names ;
out.prop_sigma      = prop_sigma;
out.acceptance_rate = acceptancerate ;

%% description
    
% sum_vec = [yy' yy05' yy95'];
% vartype     = {'\tau','\kappa','\psi_1','\psi_2','r^{(A)}',...
%                '\pi^{(A)}','\gamma^{(Q)}',...
%                '\rho_{r}','\rho_{g}', '\rho_{z}', ...
%                '\sigma_{r}','\sigma_{g}', '\sigma_{z}'};
%       
% disp('=========================================================================');
% disp(' Variable Name                       Mean         5%        95%         ');
% disp('=========================================================================');
% for hh=1:length(vartype);
%     fprintf('%-30s %10.4f %10.4f %10.4f\n',vartype{hh},sum_vec(hh,1),...
%         sum_vec(hh,2),sum_vec(hh,3));    
% end
% disp('========================================================================='); 
% 
% 
% %=========================================================================
% %                  FIGURE 1: RECURSIVE AVERAGES 
% %=========================================================================
% 
% pnames = strvcat('\tau','\kappa', '\psi_{1}','\psi_{2}','r^{(A)}',...
%     '\pi^{(A)}','\gamma^{(Q)}','\rho_{r}','\rho_{g}', '\rho_{z}', '\sigma_{r}', '\sigma_{g}', '\sigma_{z}');
% 
% figure('Position',[20,20,900,600],'Name',...
%     'Recursive Averages','Color','w')
% 
% rmean = zeros(Nsim,Npam);
% 
% for i=1:Nsim
%     rmean(i,:) = mean(Thetasim(1:i,:),1);
% end
% 
% for i=1:(Npam-1)
%     
% subplot((Npam-1)/3,3,i), plot(rmean(:,i),'LineStyle','-','Color','b',...
%         'LineWidth',2.5), hold on
% title(pnames(i,:),'FontSize',12,'FontWeight','bold');    
% end
% 
% 
% 
% %=========================================================================
% %                  FIGURE 2: POSTERIOR MARGINAL DENSITIES 
% %=========================================================================
% 
% pnames = strvcat('\tau','\kappa', '\psi_{1}','\psi_{2}','r^{(A)}',...
%     '\pi^{(A)}','\gamma^{(Q)}','\rho_{r}','\rho_{g}', '\rho_{z}', '\sigma_{r}', '\sigma_{g}', '\sigma_{z}');
% 
% figure('Position',[20,20,900,600],'Name',...
%     'Posterior Marginal Densities','Color','w')
% 
% 
% for i=1:(Npam-1)
%     xmin = min(Thetasim(:,i));
%     xmax = max(Thetasim(:,i));
%     grid = linspace(xmin,xmax,100);
%     u    = (1+0.4)*max(ksdensity(Thetasim(:,i)));
% subplot((Npam-1)/3,3,i), plot(grid,ksdensity(Thetasim(:,i)),'LineStyle','-','Color','b',...
%         'LineWidth',2.5), hold on
% plot([mean(Thetasim(:,i)) mean(Thetasim(:,i))], [0 u],'LineStyle',':',...
%     'Color','black','LineWidth',2.5 ), hold off
% axis([xmin xmax 0 u]);
% title(pnames(i,:),'FontSize',12,'FontWeight','bold');    
% end
% 
% 
% disp('                                                                  ');
% disp(['                     ELAPSED TIME:   ', num2str(toc)]             );
% 
% elapsedtime=toc;
% 
% %path(l);
% 
% 
