%% Data Retrieval With Prior
% This program extracts the data from a CSV file and generates column
% vectors with the variables

Data_Mensual = xlsread('Datos_rev_ISE.xlsx','Datos_Mensuales','B3:F217');

piobs_t       = Data_Mensual(:,1);
iobs_t        = Data_Mensual(:,2);
pi_food_obs_t = Data_Mensual(:,3);
x_t           = Data_Mensual(:,4);
dum_2016m08   = Data_Mensual(:,5);

% figure
% plot(ise_t)
% hold on
% plot(xhp_t)
% hold off

% Data_Mensual = xlsread('Anex_ISE_total_nov_17.xls','ISE','C12:E226');
% 
% org_t       = Data_Mensual(:,1);
% des_t       = Data_Mensual(:,2);
% trend_t     = Data_Mensual(:,3);

% figure
% plot(org_t,':')
% hold on
% plot(des_t,'Color',[0 1 0])
% hold on
% plot(trend_t,'Color',[1 0 0])
% legend('Original','Desestacionalizada','Tendencia-Ciclo','Location','southeast')
% hold off

% growth=(ise_t(2:end)./ise_t(1:end-1)-1);
% plot(growth)
% growth2=(brecha_t(2:end)./brecha_t(1:end-1)-1);
% plot(growth2)

figure('Name','Series Observadas Mensuales')
subplot(2,2,1),plot(piobs_t),       title('Inflación Obs.')
subplot(2,2,2),plot(iobs_t),        title('Tasa Interes Obs.'), 
subplot(2,2,3),plot(pi_food_obs_t), title('Inflación Alimentos Obs.')
subplot(2,2,4),plot(x_t ),          title('Brecha PIB Obs.'), %Graficar diferente primeras 14 observaciones


%  dates_orig = datetime(2000,1,1) + calmonths(1:size(piobs_t,1));
%     [ dates_orig(1)  dates_orig(end) ]
%     size_datesorig=size(dates_orig)
% 
% date
% pi_sa = x13(dates_orig,piobs_t)
%  tratando de hacer x13 en MATLAB  véase C:\dynare\x13tbx\
%  y WEB:
%  https://www.mathworks.com/matlabcentral/fileexchange/49120-x-13-toolbox-for-seasonal-filtering 
% pi_sa = x13(dates_orig,piobs_t, 'noflags');
% pi_sa = x13([dates_orig, piobs_t]);
% pi_sa = x13([dates_orig, piobs_t], 'noflags' )

clear Data_Mensual;

save Data_Model_Mensual

