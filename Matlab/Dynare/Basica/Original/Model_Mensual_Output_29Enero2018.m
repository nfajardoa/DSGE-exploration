write = 0
% Dealing wiht DSGE estimation output to get Inflaci?n B?sica
% By Norberto Rodr?guez-Ni?o 28-Febrero-2017

%cd W:\BASICAS\
dynare Model_Mensual_ARMA_7_12_29Enero2018.mod
load Model_Mensual_ARMA_7_12_29Enero2018_results
Model_Mensual_ARMA_7_12_Dic2017_results
size(oo_.SmoothedVariables.y_pi_bas_t)
% PI_Meta = xlsread('Datos_HNKM.xls','Inflacion','H28:H94');
PI_Meta    = xlsread('Datos_HNKM_Joao_Diciembre2017.xlsx','Inflacion','E80:E293');
Brecha_PIB = xlsread('Datos_HNKM_Joao_Diciembre2017.xlsx','Datos_Mensuales','E4:E217');
T=size(PI_Meta,1);
rotulos = 2000+2/12:(1/12):2017+11/12;
dates = datetime(2000,1,1) + calmonths(1:T);
[ dates(1)  dates(end) ]

pi_basica_DSGE = oo_.SmoothedVariables.y_pi_bas_t + PI_Meta ;
size(pi_basica_DSGE)
[min(pi_basica_DSGE) max(pi_basica_DSGE)]

Inf_SinAliNP  =  pi_basica_DSGE + oo_.SmoothedVariables.zinf_t ;

%size(pi_basica_DSGE)
% comando Dynare para: Loads into the Matlab/Octave?s workspace informations about the previously saved MCMC draws generated by a mod file named MODFILENAME. Example
internals --load-mh-history Model_Mensual_ARMA_7_12_Dic2017
% This will create a structure called mcmc_informations (in the workspace) with the following fields:
% Nblck
% The number of MCMC chains.
% InitialParameters
% A Nblck*n, where n is the number of estimated parameters, array of doubles. Initial state of the MCMC.
% LastParameters
% A Nblck*n, where n is the number of estimated parameters, array of doubles. Current state of the MCMC.
% InitialLogPost
% A Nblck*1 array of doubles. Initial value of the posterior kernel.
% LastLogPost
% A Nblck*1 array of doubles. Current value of the posterior kernel.
% InitialSeeds
% A 1*Nblck structure array. Initial state of the random number generator.
% LastSeeds
% A 1*Nblck structure array. Current state of the random number generator.
% AcceptanceRatio
% A 1*Nblck array of doubles. Current acceptance ratios.
mcmc_informations.AcceptanceRatio


figure('Name','Inflaci?n b?sica DSGE y choque oferta')
% subplot(3,1,1:2),plot(dates(7:end), [pi_basica_DSGE(7:end) Inf_SinAliNP(7:end)]), title('Inflaci?n b?sica DSGE'), legend({'Inf B?sica DSGE'; 'Inflaci?n sin alimentos NP'})
% subplot(3,1,3) , plot(dates(7:end), [oo_.SmoothedVariables.zinf_t(7:end)  zeros(T-6)]), title('choque de oferta'), xlim([dates(1) dates(end)])
subplot(3,1,1:2),plot(rotulos(7:end), [pi_basica_DSGE(7:end) Inf_SinAliNP(7:end)]), title('Inflaci?n b?sica DSGE'), xlim([rotulos(6) rotulos(end)+2/12]), legend({'Inf B?sica DSGE'; 'Inflaci?n sin alimentos NP'},'Location','northwest')
     xtm = rotulos(12*(1:(length(rotulos)+1)/12)-7);      xt = get(gca, 'XTick');     set(gca, 'FontSize', 11, 'XTick',xtm);      grid on
subplot(3,1,3) , plot(rotulos(7:end), [oo_.SmoothedVariables.zinf_t(7:end)  zeros(T-6)]), title('choque de oferta'), xlim([rotulos(6) rotulos(end)+2/12])
     xtm = rotulos(12*(1:(length(rotulos)+1)/12)-7);      %xt = get(gca, 'XTick');     set(gca, 'FontSize', 11, 'XTick',xtm);  

% Brecha PIB
% figure('Name','Brecha PIB')
% %plot(dates,[Brecha_PIB zeros(T)]), title('Brecha PIB Mensual'), xlim([dates(1) dates(end)])
% plot(rotulos,[Brecha_PIB zeros(T)]), title('Brecha PIB Mensual'), xlim([rotulos(1) rotulos(end)+1/12])
%      xtm = rotulos(12*(1:(length(rotulos)+1)/12)-7);
%      xt = get(gca, 'XTick');
%      set(gca, 'FontSize', 11, 'XTick',xtm)
%      grid on
%           
% 

% choques de oferta
%figure('Name','choque de oferta')
%plot(oo_.SmoothedVariables.zinf_t), title('choque de oferta')

if write ==1 
    xlswrite('Datos_HNKM_Joao_Diciembre2017.xlsx',pi_basica_DSGE,'Inf_Basica_DSGE_Men','B2:B216')
end

