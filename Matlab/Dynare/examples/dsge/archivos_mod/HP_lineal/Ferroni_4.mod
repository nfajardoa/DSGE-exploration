var y c k h e_a e_b y_obs h_obs;
varexo v_a v_b;

parameters alpha beta delta chi rho_a rho_b;

alpha = 0.3;
beta = 0.99;
delta = 0.025;
chi = 1;
rho_a = 0.8;
rho_b = 0.8;

model(linear);

# kratio = alpha/((1/beta)+delta-1);

# cratio = 1-(delta*kratio);

(h-e_b)*(1+(1/chi))=y-c;

0 = beta*((alpha*(1/kratio)*(c-c(+1)+y(+1)-k))+((1-delta)*(c-c(+1))));

y = (k(-1)*alpha)+((h+e_a)*(1-alpha));

y = (cratio*c)+(kratio*k)-((1-delta)*kratio*k(-1));

e_a=(rho_a*e_a(-1))+v_a;

e_b=(rho_b*e_b(-1))+v_b;

y_obs=y;
h_obs=h;

end;

varobs y_obs h_obs;

initval;

y = 0;
y_obs = 0;
c = 0;
h = 0;
h_obs = 0;
k = 0;
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

estimation(datafile=variables_simuladas, bayesian_irf, mode_check, mh_conf_sig=0.95 ,mh_replic=50000,selected_variables_only, mode_compute=6) y_obs h_obs;
identification;

