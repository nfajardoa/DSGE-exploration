var y c k h_obs e_a e_b y_obs;
varexo v_a v_b;

parameters alpha beta delta chi rho_a rho_b;

beta = 0.99;
delta = 0.025;
alpha = 0.3;
chi=1;
rho_a=0.8;
rho_b=0.8;

model;

(h_obs/exp(e_b))^(1+(1/chi))=((1-alpha)*(y/c));

beta*(c/c(+1))*exp(-e_a(+1))*((alpha*(y(+1)/k)*exp(e_a(+1)))+(1-delta))=1;

y=(k(-1)^alpha)*(h_obs^(1-alpha))*(exp(-alpha*e_a));

y=c+k-(((1-delta)*k(-1))*(exp(-e_a)));

e_a=(rho_a*e_a(-1))+v_a;

e_b=(rho_b*e_b(-1))+v_b;

y_obs=(y/y(-1))*exp(e_a);


end;

steady_state_model;
y = (((1-alpha)*(1/(1-(delta*(alpha/((1/beta)+delta-1))))))^(chi/(chi+1)))*(((alpha/((1/beta)+delta-1)))^(alpha/(1-alpha)));
k = y*(alpha /((1/beta)+delta-1));
h_obs = y*((k/y)^(alpha/(alpha-1)));
c = y*(1-(delta*(k/y)));
e_a = 0 ;
e_b = 0 ;
y_obs=1;
end;

varobs y_obs h_obs;

initval;
y = 2.3664095;
y_obs = 1;
c = 1.86078099;
h_obs = 0.94350963;
k = 20.2251401;
e_a = 0;
e_b = 0;
v_a = 0;
v_b = 0;
end;

steady; resid;

estimated_params;
alpha, beta_pdf, 0.5, 1/sqrt(12);
chi, gamma_pdf, 1, 0.8452;
rho_a, beta_pdf, 0.5, 1/sqrt(12);
rho_b, beta_pdf, 0.5, 1/sqrt(12);
stderr v_a, inv_gamma_pdf, 0.1, 4;
stderr v_b, inv_gamma_pdf, 0.1, 4;
end;

estimated_params_init;
alpha, 0.3;
chi, 1;
rho_a, 0.8;
rho_b, 0.8;
stderr v_a, 1;
stderr v_b, 0.5;
end;

identification;

estimation(datafile=variables_simuladas, bayesian_irf, mode_check, mh_conf_sig=0.95 ,mh_replic=50000,selected_variables_only, mode_compute=6); %gy_obs h;