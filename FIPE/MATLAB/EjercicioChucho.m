cd('C:/Users/USR_PracticanteGT42/Documents/DSGE_Ferroni/Nicolas Fajardo/FIPE/MATLAB')
%cd('W:\Nicolas Fajardo\FIPE\MATLAB')
load('FIPE_12-07-2018.mat')
grid_size = 20;

%% lambda

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = []; log_target_plot = []; log_like_plot = [];
      log_target_plot_o = []; log_like_plot_o = [];
      interval_size = 1;  %std(theta_plot(:,1))*4 
      step_size = interval_size/grid_size;
      for x = min(min(theta_plot(:,1))*interval_size, min(theta_plot(:,1))*-interval_size):step_size:max(max(theta_plot(:,1))*interval_size, max(theta_plot(:,1))*-interval_size)
        theta_plot_m = [x, mode(theta_plot(:,2)), mode(theta_plot(:,3)), mode(theta_plot(:,4))];
        theta_plot_o = [x, theta_opt(:,2), theta_opt(:,3), theta_opt(:,4)];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot = [log_like_plot, log_like(theta_plot_m)];
        log_target_plot_o = [log_target_plot_o, log_target(theta_plot_o)];
        log_like_plot_o = [log_like_plot_o, log_like(theta_plot_o)];
      end
      eval(['[','lambda', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_lambda', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_lambda', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
      eval(['[','log_target_o_lambda', num2str(sector),num2str(rho),']=log_target_plot_o;' ]) ;
      eval(['[','log_like_o_lambda', num2str(sector),num2str(rho),']=log_like_plot_o;' ]) ;
  end
end

%% r

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = []; log_target_plot = []; log_like_plot = [];
      log_target_plot_o = []; log_like_plot_o = [];
      interval_size = 1;  %std(theta_plot(:,2))*4 
      step_size = interval_size/grid_size;
      for x = min(min(theta_plot(:,2))*interval_size, min(theta_plot(:,2))*-interval_size):step_size:max(max(theta_plot(:,2))*interval_size, max(theta_plot(:,2))*-interval_size)
        theta_plot_m = [mode(theta_plot(:,1)), x, mode(theta_plot(:,3)), mode(theta_plot(:,4))];
        theta_plot_o = [theta_opt(:,1), x, theta_opt(:,3), theta_opt(:,4)];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot = [log_like_plot, log_like(theta_plot_m)];
        log_target_plot_o = [log_target_plot_o, log_target(theta_plot_o)];
        log_like_plot_o = [log_like_plot_o, log_like(theta_plot_o)];
      end
      eval(['[','r', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_r', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_r', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
       eval(['[','log_target_o_r', num2str(sector),num2str(rho),']=log_target_plot_o;' ]) ;
      eval(['[','log_like_o_r', num2str(sector),num2str(rho),']=log_like_plot_o;' ]) ;
  end
end

%% R

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = []; log_target_plot = []; log_like_plot = [];
      log_target_plot_o = []; log_like_plot_o = [];
      interval_size = 1;  %std(theta_plot(:,3))*4 
      step_size = interval_size/grid_size;
      for x = min(min(theta_plot(:,3))*interval_size, min(theta_plot(:,3))*-interval_size):step_size:max(max(theta_plot(:,3))*interval_size, max(theta_plot(:,3))*-interval_size)
        theta_plot_m = [mode(theta_plot(:,1)), mode(theta_plot(:,2)), x, mode(theta_plot(:,4))];
        theta_plot_o = [theta_opt(:,1), theta_opt(:,2), x, theta_opt(:,4)];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot = [log_like_plot, log_like(theta_plot_m)];
        log_target_plot_o = [log_target_plot_o, log_target(theta_plot_o)];
        log_like_plot_o = [log_like_plot_o, log_like(theta_plot_o)];
      end
      eval(['[','R', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_R', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_R', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
      eval(['[','log_target_o_R', num2str(sector),num2str(rho),']=log_target_plot_o;' ]) ;
      eval(['[','log_like_o_R', num2str(sector),num2str(rho),']=log_like_plot_o;' ]) ;
  end
end

%% Ghat

for sector = 1:3
  for rho = 0:1
      eval(['theta_plot = [','theta', num2str(sector),num2str(rho),'];' ]) ;
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      parameter_plot = []; log_target_plot = []; log_like_plot = [];
      log_target_plot_o = []; log_like_plot_o = [];
      interval_size = 1;  %std(theta_plot(:,4))*4 
      step_size = interval_size/grid_size;
      for x = min(min(theta_plot(:,4))*interval_size, min(theta_plot(:,4))*-interval_size):step_size:max(max(theta_plot(:,4))*interval_size, max(theta_plot(:,4))*-interval_size)
        theta_plot_m = [mode(theta_plot(:,1)), mode(theta_plot(:,2)), mode(theta_plot(:,3)), x];
        theta_plot_o = [theta_opt(:,1), theta_opt(:,2), theta_opt(:,3), x];
        parameter_plot = [parameter_plot, x];
        log_target_plot = [log_target_plot, log_target(theta_plot_m)];
        log_like_plot = [log_like_plot, log_like(theta_plot_m)];
        log_target_plot_o = [log_target_plot_o, log_target(theta_plot_o)];
        log_like_plot_o = [log_like_plot_o, log_like(theta_plot_o)];
      end
      eval(['[','Ghat', num2str(sector),num2str(rho),']=parameter_plot;' ]) ;
      eval(['[','log_target_Ghat', num2str(sector),num2str(rho),']=log_target_plot;' ]) ;
      eval(['[','log_like_Ghat', num2str(sector),num2str(rho),']=log_like_plot;' ]) ;
      eval(['[','log_target_o_Ghat', num2str(sector),num2str(rho),']=log_target_plot_o;' ]) ;
      eval(['[','log_like_o_Ghat', num2str(sector),num2str(rho),']=log_like_plot_o;' ]) ;
  end
end


%% MERGED PLOTS

figure('Name',[ country, ': Posterior con lambda variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_lambda', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)- log_like(theta_plot_o));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,1),log_target(theta_opt),'r*'), hold on
      plot(mode(theta_plot(:,1)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','log-target_o','log-like_o','optimum','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('Lambda'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Lambda' ,'t'); 
set(h3,'FontSize',30) 


figure('Name',[ country, ': Posterior con r variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_r', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)- log_like(theta_plot_o));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,2),log_target(theta_opt),'r*'), hold on
      plot(mode(theta_plot(:,2)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','log-target_o','log-like_o','optimum','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('r'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('r' ,'t'); 
set(h3,'FontSize',30) 


figure('Name',[ country, ': Posterior con R variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_R', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)- log_like(theta_plot_o));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,3),log_target(theta_opt),'r*'), hold on
      plot(mode(theta_plot(:,3)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','log-target_o','log-like_o','optimum','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('R'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('R' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con Ghat variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_Ghat', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o)
          shifter = 1
      else
          shifter = -1
      end
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)-log_like(theta_plot_o));
      subplot(4,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,4),log_target(theta_opt),'r*'), hold on
      plot(mode(theta_plot(:,4)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','log-target_o','log-like_o','optimum','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('Ghat'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Ghat' ,'t'); 
set(h3,'FontSize',30) 


%% METROPOLIS-HASTINGS 

figure('Name',[ country, ': Posterior con lambda variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_lambda', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)- log_like(theta_plot_o));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(mode(theta_plot(:,1)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('Lambda'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Lambda' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con r variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_r', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)- log_like(theta_plot_o));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(mode(theta_plot(:,2)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('r'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('r' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con R variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_R', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)- log_like(theta_plot_o));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(mode(theta_plot(:,3)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('R'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('R' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con Ghat variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_plot=[','theta', num2str(sector),num2str(rho),'];' ]);
      eval(['parameter_plot=[','Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot=[','log_target_Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot=[','log_like_Ghat', num2str(sector),num2str(rho),'];' ]);
      theta_plot_o = mode(theta_plot);
      if log_target(theta_plot_o) >= log_like(theta_plot_o)
          shifter = 1
      else
          shifter = -1
      end
      log_like_plot_shift = log_like_plot+shifter*abs(log_target(theta_plot_o)-log_like(theta_plot_o));
      subplot(4,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot), hold on
      plot(parameter_plot,log_like_plot_shift), hold on
      plot(mode(theta_plot(:,4)),log_target(theta_plot_o),'b*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target','log-like','mode'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('Ghat'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Ghat' ,'t'); 
set(h3,'FontSize',30) 

%% MAXIMUM LIKELIHOOD

figure('Name',[ country, ': Posterior con lambda variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_lambda', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_lambda', num2str(sector),num2str(rho),'];' ]);
      shift = 1
      if log_target(theta_opt) >= log_like(theta_opt);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shift*shifter*abs(log_target(theta_opt)- log_like(theta_opt));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,1),log_target(theta_opt),'r*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target_o','log-like_o','optimum'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('Lambda'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Lambda' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con r variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_r', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_r', num2str(sector),num2str(rho),'];' ]);
      shift = 1
      if log_target(theta_opt) >= log_like(theta_opt);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shift*shifter*abs(log_target(theta_opt)- log_like(theta_opt));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,2),log_target(theta_opt),'r*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target_o','log-like_o','optimum'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('r'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('r' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con R variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_R', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_R', num2str(sector),num2str(rho),'];' ]);
      shift = 1
      if log_target(theta_opt) >= log_like(theta_opt);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shift*shifter*abs(log_target(theta_opt)- log_like(theta_opt));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,3),log_target(theta_opt),'r*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target_o','log-like_o','optimum'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('R'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('R' ,'t'); 
set(h3,'FontSize',30) 

figure('Name',[ country, ': Posterior con Ghat variable'] )
i=1;
for sector = 1:3
  for rho = 0:1
      eval(['theta_opt = [','opt_max_like', num2str(sector),num2str(rho),'];' ]) ;
      eval(['parameter_plot=[','Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_target_plot_o=[','log_target_o_Ghat', num2str(sector),num2str(rho),'];' ]);
      eval(['log_like_plot_o=[','log_like_o_Ghat', num2str(sector),num2str(rho),'];' ]);
      shift = 1
      if log_target(theta_opt) >= log_like(theta_opt);
          shifter = 1;
      else;
          shifter = -1;
      end;
      log_like_plot_shift = log_like_plot+shift*shifter*abs(log_target(theta_opt)- log_like(theta_opt));
      subplot(3,2,i), title(['sector = ', num2str(sector),', \rho = ', num2str(rho)]), hold on
      plot(parameter_plot,log_target_plot_o), hold on
      plot(parameter_plot,log_like_plot_o), hold on
      plot(theta_opt(:,4),log_target(theta_opt),'r*'), hold off
      i=i+1;
  end
end
hL = legend({'log-target_o','log-like_o','optimum'});
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
[ax,h1]=suplabel('Ghat'); 
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Ghat' ,'t'); 
set(h3,'FontSize',30) 

%% DISTRIBUTION PLOT

x = [-100:.1:100];

figure
ax1 = subplot(1,2,1)
mean_lambda=0   ;  % for the normal distribution
sd_lambda=2*1.5 ;  % for the normal distribution 
norm = normpdf(x, mean_lambda, sd_lambda)
plot(x, norm);
annotation('textbox',[0.15 0.8 0.1 0.1],...
    'String',{['mean = ' num2str(mean_lambda)],['sd = ' num2str(sd_lambda)]});
ax2 = subplot(1,2,2)
mean_lambda=10   ;  % for the normal distribution
sd_lambda=20 ;  % for the normal distribution 
norm = normpdf(x, mean_lambda, sd_lambda)
plot(x, norm);
annotation('textbox',[0.59 0.8 0.1 0.1],...
    'String',{['media = ' num2str(mean_lambda)],['sd = ' num2str(sd_lambda)]});
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Priors (lambda)' ,'t'); 
set(h3,'FontSize',30) ;
linkaxes([ax1,ax2],'y');

x = [0:.1:25];

figure
ax1 = subplot(1,2,1);
shape_rhat= 4.0 ;              
scale_rhat= 1/4 ;
gamma = gamma2_pdf(x, shape_rhat, scale_rhat);
plot(x,gamma);
annotation('textbox',[0.15 0.8 0.1 0.1],...
    'String',{['shape = ' num2str(shape_rhat)],['scale = ' num2str(scale_rhat)]});
ax2 = subplot(1,2,2);
shape_rhat= 10 ;              
scale_rhat= (1/4)*20 ;
gamma = gamma2_pdf(x, shape_rhat, scale_rhat);
plot(x,gamma);
annotation('textbox',[0.59 0.8 0.1 0.1],...
    'String',{['shape = ' num2str(shape_rhat)],['scale = ' num2str(scale_rhat)]});
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Priors (rhat)' ,'t'); 
set(h3,'FontSize',30);
linkaxes([ax1,ax2],'y');

figure
ax1 = subplot(1,2,1);
shape_Rhat= 4.0 ;  % 2.0
scale_Rhat= 2.0 ;  % 1/4
gamma = gamma2_pdf(x, shape_Rhat, scale_Rhat);
plot(x,gamma);
annotation('textbox',[0.15 0.8 0.1 0.1],...
    'String',{['shape = ' num2str(shape_Rhat)],['scale = ' num2str(scale_Rhat)]});
ax2 = subplot(1,2,2);
shape_Rhat= 10 ;  % 2.0
scale_Rhat= 2*10 ;  % 1/4
gamma = gamma2_pdf(x, shape_Rhat, scale_Rhat);
plot(x,gamma);
annotation('textbox',[0.59 0.8 0.1 0.1],...
    'String',{['shape = ' num2str(shape_Rhat)],['scale = ' num2str(scale_Rhat)]});
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Priors (Rhat)' ,'t'); 
set(h3,'FontSize',30) ;
linkaxes([ax1,ax2],'y');

figure
x = [2:.1:10];
ax1 = subplot(1,2,1);
shape_Ghat= 2.0 ;
scale_Ghat= 10  ;
unif = uniform_pdf(x, shape_Ghat, scale_Ghat);
plot(x,unif);
annotation('textbox',[0.15 0.8 0.1 0.1],...
    'String',{['shape = ' num2str(shape_Ghat)],['scale = ' num2str(scale_Ghat)]});
x = [-10:.1:10];
ax2 = subplot(1,2,2);
mean_Ghat= 0 ;
sd_Ghat= 1  ;
norm = normpdf(x, mean_Ghat, sd_Ghat);
plot(x, norm);
annotation('textbox',[0.59 0.8 0.1 0.1],...
    'String',{['mean = ' num2str(mean_Ghat)],['sd = ' num2str(sd_Ghat)]});
[ax,h2]=suplabel('Probabilidad','y'); 
[ax,h3]=suplabel('Priors (Ghat)' ,'t'); 
set(h3,'FontSize',30) ;
linkaxes([ax1,ax2],'y');
