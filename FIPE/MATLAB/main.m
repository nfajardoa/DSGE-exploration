%%
% This file creates, for a selected country, the sets of 3x2 graphs used presented in the paper

% Preamble

% setwd('U:/My Documents/FIPE/Publication')
%cd('c:/Users/NRO/DEPE/CurvadePhillipsSectorial/FIPE')
%cd('d:/users/NRO/DEPE/CurvaPhillipsSectorial/FIPE')
cd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE/MATLAB')

% Load the file with the parameters.
run 'parameters.m'

%run 'FIPE_lag_auto.m'

% Calculate posteriors, looping over the three sector groups and the two values for rho. The vetor theta collecls the posteriors
% for r, R, Gamma. The matrix S collectes the variance covariance matrix of the proposal distribution used in the MCMC simulator
% PARA MAX VEROSIIMILITUD
sector=0
rho=1
Max_Lik = 1   % get Max like estimation especially Hessian matrix
 
for sector = 1:3
      sector = sector 
   for rho = 0:1
        rho = rho  
        run 'FIPE_lag_auto.m'
%                   assignin(ws, 'var', val)
%                   name=['theta', num2str(sector),num2str(rho)]
                  eval(['[','theta', num2str(sector),num2str(rho),']=theta;' ]) ;
                  eval(['[','opt_max_like', num2str(sector),num2str(rho),']=PARAM_HAT;' ]) ;
                  eval(['[','S', num2str(sector),num2str(rho),']=S_adapted;' ]) ;
                  %assign(paste('S'    , sector,rho,sep=''), S_adapted)

    dif_mat_cov=mcmc_r.prop_sigma-cov(mcmc_r.trace);
    det(dif_mat_cov) % from manual: While Metro_Hastings has an adaptive proposal structure built in, if prop_sigma differs greatly
                 % from the covariance structure of the target distribution, stationarity may not be achieved. 
    mcmc_r.trace([1:5 end-4:end],:)
  end
end

save('FIPE_12-07-2018.mat')

%%

% draws plot
figure('Name','draw 1')
plot(mcmc_r.trace(:,1))

% Plot posteriors
figure('Name',[ country, '_lambda'] )
i=1; x=-1.5:0.01:1.5;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), ksdensity(eval([ '[','theta', num2str(sector), num2str(rho),'(:,1)]' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), hold on
      plot(x,prior_lambda(x))    , hold off
%       ))), xlim=c(-1.5,1.5), col='red', xlab=NA, ylab=NA,  main=TeX(sprintf('sector = %d , $\\rho$ = %d', sector, rho)))
%                      curve(prior.lambda(x),lty=3, add=TRUE)
%         plot(ksdensity(eval(as.name(paste('theta', sector, rho, sep='')))[,1]), xlim=c(-1.5,1.5), col='red', xlab=NA, ylab=NA,  main=TeX(sprintf('sector = %d , $\\rho$ = %d', sector, rho)))
%                curve(prior.lambda(x),lty=3, add=TRUE)
      i=i+1;
  end
end

figure('Name',[ country, '_r'] )
i=1; x_r=0:0.01:1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), ksdensity(eval([ '[','theta', num2str(sector), num2str(rho),'(:,2)]' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), hold on
      plot(x_r,prior_rhat(rhat_fun(x_r))./((1-x_r).^2))    , hold off
                       % curve((prior.rhat(rhat.fun(x))/(1-x)^2),lty=3, add=TRUE)}
      i=i+1;
  end
end

figure('Name',[ country, '_R'] )
i=1; x_R=0:0.01:1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), ksdensity(eval([ '[','theta', num2str(sector), num2str(rho),'(:,3)]' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), hold on
      plot(x_R,prior_Rhat(Rhat_fun(x_R))./((1-x_R).^2))    , hold off
      i=i+1;
  end
end

figure('Name',[ country, '_Gamma'] )
i=1; x_G=0:0.01:1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), ksdensity(eval([ '[','theta', num2str(sector), num2str(rho),'(:,4)]' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), hold on
      plot(x_G,prior_Ghat(x_G))    , hold off
      i=i+1;
  end
end

% Plot diagnostics presented in the Appendic to the paper
figure('Name',[ country, '_lamda ACF'])
i=1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), plot(eval([ 'acf([','theta', num2str(sector), num2str(rho),'(:,1)],25)' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), ylim([-1 1])
      i=i+1;
  end
end

figure('Name',[ country, '_r ACF'])
i=1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), plot(eval([ 'acf([','theta', num2str(sector), num2str(rho),'(:,2)],25)' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), ylim([-1 1])
      i=i+1;
  end
end

figure('Name',[ country, '_r ACF'])
i=1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), plot(eval([ 'acf([','theta', num2str(sector), num2str(rho),'(:,3)],25)' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), ylim([-1 1])
      i=i+1;
  end
end

figure('Name',[ country, '_Gamma ACF'])
i=1;
for sector = 1:3
  for rho = 0:1
      subplot(3,2,i), plot(eval([ 'acf([','theta', num2str(sector), num2str(rho),'(:,4)],25)' ]) ), title(['sector= ', num2str(sector),', \rho= ', num2str(rho)]), ylim([-1 1])
      i=i+1;
  end
end

% Save the results of the the estimation
save([country, '_results_chucho'])

