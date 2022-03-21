% %addpath c:\dynare\4.4.3\matlab
% % Cambiar el siguiente directorio por cualquier carpeta que desee y que contenga
% % la carpeta archivos_mod
% %addpath C:\Users\USR_PracticanteGT42\Documents\Programacion\filt
% %cd C:\Users\USR_PracticanteGT42\Documents\Programacion
% 
% 
% %{
% En la carpeta archivos_mod se encuentran todos los archivos necesarios para 
% correr la programación y todos los modelos en cualquier computador simplemente
% al ejecutar este archivo 
% %}
% 
% %%%%% Simulación de variables lnY y lnH
% 
%   %{
%   Realizar las simulaciones iniciales de 120 observaciones de lnY y lnH a partir
%   del modelo de Chang, Doh, and Schorfheide (2007) y los parámetros calibrados de 
%   acuerdo a Ferroni (2011)
%   %}
% %Número de simulaciones
% 
% %%%%%%%%%%%%%%%%%%%%%%

mkdir True
copyfile('Ferroni.mod','True')
cd './True'

dynare Ferroni.mod %nograph

clear y h
y=y_obs;
h=h_obs;
y(1:120,:)=[ ];
h(1:120,:)=[ ];
gy_obs(1:120,:)=[ ];
gh_obs(1:120,:)=[ ];

save 'variables_simuladas.mat' y_obs h_obs %t_trend
copyfile('variables_simuladas.mat','../')
clear all

cd '../'

load('variables_simuladas.mat', 'h_obs')
load('variables_simuladas.mat', 'y_obs')

figure
subplot(2,1,1)  
plot(1:numel(y_obs),y_obs)
title('Y observado')

subplot(2,1,2)  
plot(1:numel(y_obs),h_obs)
title('H observado')

%%%%% Estimación Modelo Verdadero
  %{
  Realizar la estimación de algunos parámetros del modelo teniendo las variables
  simuladas lnY y lnH, usando la transformación verdadera del modelo para volver
  estas variables estacionarias
  %}

mkdir true_model
copyfile('Ferroni_2.mod','true_model')
copyfile('variables_simuladas.mat','true_model')

cd './true_model'
dynare Ferroni_2.mod
clear all
cd '../'

% %%%% Estimación Modelo mala especificación
%   {
%   a
%   }

mkdir tech_UR
copyfile('Ferroni_3.mod','tech_UR')
copyfile('variables_simuladas.mat','tech_UR')

cd './tech_UR'
dynare Ferroni_3.mod
clear all
cd '../'

% %%%%% Estimación Modelo con filtro HP
%   %{
%   HP
%   %}

mkdir HP_lineal
copyfile('Ferroni_4.mod','HP_lineal')
copyfile('variables_simuladas.mat','HP_lineal')

cd './HP_lineal'
load variables_simuladas.mat
y_obs = HP(y,1600,0);
h_obs = HP(h,1600,0);
% print(y, '-djpeg', 'y_HP.jpeg');
% plot(h);
% print -djpeg h_HP.jpg;
save 'variables_simuladas.mat' y_obs h_obs h

dynare Ferroni_4.mod
clear all
cd '../'

% %%%%% Estimación Modelo con filtro HP-One-Sided
%   %{
%   HP_One_Sided
%   %}

mkdir HP_lineal_OS
copyfile('Ferroni_4.mod','HP_lineal_OS')
copyfile('variables_simuladas.mat','HP_lineal_OS')

cd './HP_lineal_OS'
load variables_simuladas.mat
[y_cicle,y_obs] = one_sided_hp_filter_serial(y,1600,0);
[h_cicle,h_obs] = one_sided_hp_filter_serial(h,1600,0);
% print(y, '-djpeg', 'y_HP.jpeg');
% plot(h);
% print -djpeg h_HP.jpg;
save 'variables_simuladas.mat' y_obs h_obs h

dynare Ferroni_4.mod
clear all
cd '../'

% %%%% Estimación Modelo con filtro Baxter-King
%   {
%   BK
%   }

mkdir BK_lineal
copyfile('Ferroni_4.mod','BK_lineal')
copyfile('variables_simuladas.mat','BK_lineal')

cd './BK_lineal'
load variables_simuladas.mat
y_obs = BK(y,8,32,12);
h_obs = BK(h,8,32,12);
% plot(y);
% print -djpg y_BK.jpg;
% plot(h);
% print -djpg h_BK.jpg;
save 'variables_simuladas.mat' y_obs h_obs

dynare Ferroni_4.mod
clear all
cd '../'

% %%%% Estimación Modelo con filtro Christiano-Fitzgerald
%   {
%   CF
%   }

mkdir CF_lineal
copyfile('Ferroni_4.mod','CF_lineal')
copyfile('variables_simuladas.mat','CF_lineal')

cd './CF_lineal'
load variables_simuladas.mat
y_obs= CF(y,8,32);
h_obs= CF(h,8,32);
% plot(y);
% print -djpg y_CF.jpg;
% plot(h);
% print -djpg h_CF.jpg;
save 'variables_simuladas.mat' y_obs h_obs

dynare Ferroni_4.mod
clear all
cd '../'

% %%%% Estimación Modelo con filtro Butterworth
%   {
%   CF
%   }

mkdir BW_lineal
copyfile('Ferroni_4.mod','BW_lineal')
copyfile('variables_simuladas.mat','BW_lineal')

cd './BW_lineal'
load variables_simuladas.mat
y_obs= butterworth(y,32,6);
h_obs= butterworth(h,32,6);
% plot(y);
% print -djpg y_BW.jpg;
% plot(h);
% print -djpg h_BW.jpg;
save 'variables_simuladas.mat' y_obs h_obs

dynare Ferroni_4.mod
clear all
cd '../'


% %%%% Estimación Modelo con Linear Detrending
%   {
%   LD
%   }

mkdir LD_lineal
copyfile('Ferroni_4.mod','LD_lineal')
copyfile('variables_simuladas.mat','LD_lineal')

cd './LD_lineal'
load variables_simuladas.mat
y_obs= detrend(y);
h_obs= detrend(h);
% plot(y);
% print -djpg y_LD.jpg;
% plot(h);
% print -djpg h_LD.jpg;
save 'variables_simuladas.mat' y_obs h_obs

dynare Ferroni_4.mod
clear all
cd '../'
% 
% %%%% Estimación Modelo con Primeras Diferencias
%   {
%   PD
%   }

mkdir PD_lineal
copyfile('Ferroni_4.mod','PD_lineal')
copyfile('variables_simuladas.mat','PD_lineal')

cd './PD_lineal'
load variables_simuladas.mat
y_obs= diff(y);
h_obs= diff(h);
% plot(y);
% print -djpg y_PD.jpg;
% plot(h);
% print -djpg h_PD.jpg;
save 'variables_simuladas.mat' y_obs h_obs

dynare Ferroni_4.mod
clear all
cd '../'

