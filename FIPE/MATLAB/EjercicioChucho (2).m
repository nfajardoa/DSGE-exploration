
%cd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE/MATLAB')
cd('D:/Users/NRO/DEPE/CurvaPhillipsSectorial/FIPE/MATLAB')
load('COL_results.mat')
grid_size = 20;

%% lambda

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = [];      log_target_plot = [];    log_like_plot = [];
      mode_plot = mode(theta_plot) ;
      optimum = IRF_closser(mode_plot',theta_plot')';
      interval_size = 1  %std(theta_plot(:,1))*4 
      step_size = interval_size/grid_size
      for x = min(min(theta_plot(:,1))*interval_size, min(theta_plot(:,1))*-interval_size):step_size:max(max(theta_plot(:,1))*interval_size, max(theta_plot(:,1))*-interval_size)
        theta_plot_m = [x, optimum(:,2), optimum(:,3), optimum(:,4)];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot   = [log_like_plot, log_like(theta_plot_m)];
      end
      eval(['[','lambda', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_lambda', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_lambda', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
  end
end

%% rhat

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = [];      log_target_plot = [];    log_like_plot = [];
      mode_plot = mode(theta_plot) ;
      optimum = IRF_closser(mode_plot',theta_plot')';
      interval_size = 1  %std(theta_plot(:,2))*4 
      step_size = interval_size/grid_size
      for x = min(min(theta_plot(:,2))*interval_size, min(theta_plot(:,2))*-interval_size):step_size:max(max(theta_plot(:,2))*interval_size, max(theta_plot(:,2))*-interval_size)
        theta_plot_m = [optimum(:,1), x, optimum(:,3), optimum(:,4)];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot   = [log_like_plot, log_like(theta_plot_m)];
      end
      eval(['[','rhat', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_rhat', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_rhat', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
  end
end

%% Rhat

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = [];      log_target_plot = [];    log_like_plot = [];
      mode_plot = mode(theta_plot) ;
      optimum = IRF_closser(mode_plot',theta_plot')';
      interval_size = 1  %std(theta_plot(:,3))*4 
      step_size = interval_size/grid_size
      for x = min(min(theta_plot(:,3))*interval_size, min(theta_plot(:,3))*-interval_size):step_size:max(max(theta_plot(:,3))*interval_size, max(theta_plot(:,3))*-interval_size)
        theta_plot_m = [optimum(:,1), optimum(:,2), x, optimum(:,4)];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot   = [log_like_plot, log_like(theta_plot_m)];
      end
      eval(['[','Rhat', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_Rhat', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_Rhat', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
  end
end

%% Ghat

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = [];      log_target_plot = [];    log_like_plot = [];
      mode_plot = mode(theta_plot) ;
      optimum = IRF_closser(mode_plot',theta_plot')';
      interval_size = 1  %std(theta_plot(:,4))*4 
      step_size = interval_size/grid_size
      for x = min(min(theta_plot(:,4))*interval_size, min(theta_plot(:,4))*-interval_size):step_size:max(max(theta_plot(:,4))*interval_size, max(theta_plot(:,4))*-interval_size)
        theta_plot_m = [optimum(:,1), optimum(:,2), optimum(:,3), x];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot   = [log_like_plot, log_like(theta_plot_m)];
      end
      eval(['[','Ghat', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_Ghat', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_Ghat', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
  end
end


%% PLOTS

figure('Name',[ country, ': Posterior con lambda variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_lambda', num2str(sector),num2str(rho),'];' ]);
      mode_plot = mode(theta_plot) ;
      theta_plot_o = IRF_closser(mode_plot',theta_plot')';
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot), hold on
      plot(mode(theta_plot(:,1)),log_target(theta_plot_o),'r*'), hold off
      i=i+1;
  end
end

figure('Name',[ country, ': Posterior con rhat variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','rhat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_rhat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_rhat', num2str(sector),num2str(rho),'];' ]);
      mode_plot = mode(theta_plot) ;
      theta_plot_o = IRF_closser(mode_plot',theta_plot')';
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot), hold on
      plot(mode(theta_plot(:,2)),log_target(theta_plot_o),'r*'), hold off
      i=i+1;
  end
end

figure('Name',[ country, ': Posterior con Rhat variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','Rhat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_Rhat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_Rhat', num2str(sector),num2str(rho),'];' ]);
      mode_plot = mode(theta_plot) ;
      theta_plot_o = IRF_closser(mode_plot',theta_plot')';
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot), hold on
      plot(mode(theta_plot(:,3)),log_target(theta_plot_o),'r*'), hold off
      i=i+1;
  end
end

figure('Name',[ country, ': Posterior con Ghat variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_Ghat', num2str(sector),num2str(rho),'];' ]);
      mode_plot = mode(theta_plot) ;
      theta_plot_o = IRF_closser(mode_plot',theta_plot')';
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot), hold on
      plot(mode(theta_plot(:,4)),log_target(theta_plot_o),'r*'), hold off
      i=i+1;
  end
end


