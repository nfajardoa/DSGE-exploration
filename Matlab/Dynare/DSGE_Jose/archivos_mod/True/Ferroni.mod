var y c k h e_a e_b y_obs h_obs gy_obs gh_obs;
varexo v_a v_b;

parameters alpha beta delta chi rho_a rho_b sigma_a sigma_b;

alpha = 0.3;
beta = 0.99;
delta = 0.025;
chi = 1;
rho_a = 0.8;
rho_b = 0.8;
sigma_a = 1;
sigma_b = 0.5;

model;
h^(1+(1/chi))=((1-alpha)*(y/c));

beta*(c/c(+1))*exp(-e_a(+1)-e_b(+1))*((alpha*(y(+1)/k)*exp(e_a(+1)+e_b(+1)))+(1-delta))=1;

y=(k(-1)^alpha)*(h^(1-alpha))*(exp(-alpha*(e_a+e_b)));

y=c+k-((1-delta)*k(-1))*(exp(-e_a-e_b));

e_a=(rho_a*e_a(-1))+v_a;

e_b=(rho_b*e_b(-1))+v_b;

y_obs/y_obs(-1)=(y/y(-1))*exp(e_a+e_b);

h_obs/h_obs(-1)=(h/h(-1))*exp(e_b);

gy_obs=y_obs/y_obs(-1);
gh_obs=h_obs/h_obs(-1);

end;

initval;
y = 2.3664095;
y_obs = 1;
gy_obs = 1;
c = 1.86078099;
h = 0.94350963;
h_obs = 1;
gh_obs = 1;
k = 20.2251401;
e_a = 0;
e_b = 0;
v_a = 0;
v_b = 0;

end;
steady;
resid; 


shocks;
var v_a = sigma_a^2;
var v_b = sigma_b^2;
end;

stoch_simul(periods=240, order=1);
%set_dynare_seed(10);