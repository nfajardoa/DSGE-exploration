% Dealing wiht DSGE estimation output to get Inflación Básica
% By Norberto Rodríguez-Niño 28-Febrero-2017

    write   =   1   ;

%cd W:\BASICAS\
dynare Model_Mensual_ARMA_ISE.mod

PI_Meta         = xlsread('Datos_rev_ISE.xlsx','Inflacion','E217:E430') ;
T               = size(PI_Meta,1)                                                               ;
rotulos         = 2000+2/12:(1/12):2017+11/12                                                   ;
dates           = datetime(2000,1,1) + calmonths(1:T)                                           ;

[ dates(1)  dates(end) ]

pi_basica_DSGE  = oo_.SmoothedVariables.y_pi_bas_t + PI_Meta                                    ;
size(pi_basica_DSGE)                                                                            ;
dato_ini = 7+12                                                                                 ;
[min(pi_basica_DSGE(dato_ini:end)) max(pi_basica_DSGE(dato_ini:end))]                           ;

Inf_SinAliNP  =  pi_basica_DSGE + oo_.SmoothedVariables.zinf_t                                  ;

%mcmc_informations.AcceptanceRatio

figure('Name','Inflación básica DSGE y choque oferta')
subplot(3,1,1:2),
plot(rotulos(dato_ini:end), [pi_basica_DSGE(dato_ini:end) Inf_SinAliNP(dato_ini:end)]), title('Inflación básica DSGE'), xlim([rotulos(dato_ini-1) rotulos(end)]), legend({'Inf Básica DSGE'; 'Inflación sin alimentos NP'},'Location','northwest')
     xtm = rotulos(12*(1:(length(rotulos)+1)/12)-7);      xt = get(gca, 'XTick');     set(gca, 'FontSize', 11, 'XTick',xtm);      grid on
subplot(3,1,3)  , 
plot(rotulos(dato_ini:end), [oo_.SmoothedVariables.zinf_t(dato_ini:end)  zeros(numel(oo_.SmoothedVariables.zinf_t(dato_ini:end)),T-dato_ini+1)]), title('Choque de oferta'), xlim([rotulos(dato_ini-1) rotulos(end)])
     xtm = rotulos(12*(1:(length(rotulos)+1)/12)-7);      %xt = get(gca, 'XTick');     set(gca, 'FontSize', 11, 'XTick',xtm);  

write = 1
if write ==1 
    xlswrite('Datos_rev_ISE.xlsx',pi_basica_DSGE,'Inf_Basica_DSGE_Men_cali','B2:B216')
end

load Model_Mensual_ARMA_ISE\metropolis\Model_Mensual_ARMA_ISE_mh_history_0;

record.AcceptanceRatio