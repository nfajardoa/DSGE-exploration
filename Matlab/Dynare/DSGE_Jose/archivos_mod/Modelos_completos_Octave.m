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
copyfile("./archivos_mod/Ferroni.mod","True")
cd "./True"

dynare Ferroni.mod nograph

y(1:120,:)=[ ];
h(1:120,:)=[ ];
y_obs(1:120,:)=[ ];
h_obs(1:120,:)=[ ];
gy_obs(1:120,:)=[ ];
gh_obs(1:120,:)=[ ];


save 'variables_simuladas.mat' y h y_obs h_obs gy_obs gh_obs
copyfile('variables_simuladas.mat','../')
clear all

cd "../"

%%%%% Estimación Modelo Verdadero
  %{
  Realizar la estimación de algunos parámetros del modelo teniendo las variables
  simuladas lnY y lnH, usando la transformación verdadera del modelo para volver
  estas variables estacionarias
  %}

mkdir true_model
copyfile("./archivos_mod/Ferroni_2.mod","true_model")
copyfile("variables_simuladas.mat","true_model")

cd "./true_model"
dynare Ferroni_2.mod
clear all
cd "../"

% %%%% Estimación Modelo mala especificación
%   {
%   a
%   }

mkdir tech_UR
copyfile("./archivos_mod/Ferroni_3.mod","tech_UR")
copyfile("variables_simuladas.mat","tech_UR")

cd "./tech_UR"
dynare Ferroni_3.mod
clear all
cd "../"

% %%%%% Estimación Modelo con filtro HP
%   %{
%   HP
%   %}

mkdir HP
copyfile("./archivos_mod/Ferroni_4.mod","HP")
copyfile("variables_simuladas.mat","HP")

cd "./HP"
load variables_simuladas.mat
y_obs = HP(y,1600,0);
h_obs = HP(h,1600,0);
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"

% %%%% Estimación Modelo con filtro Baxter-King
%   {
%   HP
%   }

mkdir BK
copyfile("./archivos_mod/Ferroni_4.mod","BK")
copyfile("variables_simuladas.mat","BK")

cd "./BK"
load variables_simuladas.mat
y_obs = BK(y,8,32,12);
h_obs = BK(h,8,32,12);
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"

% %%%% Estimación Modelo con filtro Christiano-Fitzgerald
%   {
%   CF
%   }

mkdir CF
copyfile("./archivos_mod/Ferroni_4.mod","CF")
copyfile("variables_simuladas.mat","CF")

cd "./CF"
load variables_simuladas.mat
y_obs = CF(y,8,32);
h_obs = CF(h,8,32);
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"

% %%%% Estimación Modelo con filtro Butterworth
%   {
%   CF
%   }

mkdir BW
copyfile("./archivos_mod/Ferroni_4.mod","BW")
copyfile("variables_simuladas.mat","BW")

cd "./BW"
load variables_simuladas.mat
y_obs = butterworth(y,32,6);
h_obs = butterworth(h,32,6);
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"


% %%%% Estimación Modelo con Linear Detrending
%   {
%   LD
%   }

mkdir LD
copyfile("./archivos_mod/Ferroni_4.mod","LD")
copyfile("variables_simuladas.mat","LD")

cd "./LD"
load variables_simuladas.mat
y_obs = detrend(y);
h_obs = detrend(h);
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"
% 
% %%%% Estimación Modelo con Primeras Diferencias
%   {
%   PD
%   }

mkdir PD
copyfile("./archivos_mod/Ferroni_4.mod","PD")
copyfile("variables_simuladas.mat","PD")

cd "./PD"
load variables_simuladas.mat
y_obs = diff(y);
h_obs = diff(h);
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd "../Prior_2"

mkdir true_model
copyfile("./archivos_mod/Ferroni_2.mod","true_model")
copyfile("variables_simuladas.mat","true_model")

cd "./true_model"
dynare Ferroni_2.mod
clear all
cd "../"

% %%%% Estimación Modelo mala especificación
%   {
%   a
%   }

mkdir tech_UR
copyfile("./archivos_mod/Ferroni_3.mod","tech_UR")
copyfile("variables_simuladas.mat","tech_UR")

cd "./tech_UR"
dynare Ferroni_3.mod
clear all
cd "../"

% %%%%% Estimación Modelo con filtro HP
%   %{
%   HP
%   %}

mkdir HP
copyfile("./archivos_mod/Ferroni_4.mod","HP")
copyfile("variables_simuladas.mat","HP")

cd "./HP"
load variables_simuladas.mat
y_obs = y
h_obs = h
save "variables_simuladas.mat" y_obs h_obs

dynare Ferroni_4.mod
clear all
cd "../"

% %%%% Estimación Modelo con filtro Baxter-King
%   {
%   HP
%   }

mkdir BK
copyfile("./archivos_mod/Ferroni_4.mod","BK")
copyfile("variables_simuladas.mat","BK")

cd "./BK"
load variables_simuladas.mat
y = BK(y,8,32,12);
h = BK(h,8,32,12);
save "variables_simuladas.mat" y h

dynare Ferroni_4.mod
clear all
cd "../"

% %%%% Estimación Modelo con filtro Christiano-Fitzgerald
%   {
%   CF
%   }

mkdir CF
copyfile("./archivos_mod/Ferroni_4.mod","CF")
copyfile("variables_simuladas.mat","CF")

cd "./CF"
load variables_simuladas.mat
y = CF(y,8,32);
h = CF(h,8,32);
save "variables_simuladas.mat" y h

dynare Ferroni_4.mod
clear all
cd "../"

% %%%% Estimación Modelo con filtro Butterworth
%   {
%   CF
%   }

mkdir BW
copyfile("./archivos_mod/Ferroni_4.mod","BW")
copyfile("variables_simuladas.mat","BW")

cd "./BW"
load variables_simuladas.mat
y = butterworth(y,32,6);
h = butterworth(h,32,6);
save "variables_simuladas.mat" y h

dynare Ferroni_4.mod
clear all
cd "../"


% %%%% Estimación Modelo con Linear Detrending
%   {
%   LD
%   }

mkdir LD
copyfile("./archivos_mod/Ferroni_4.mod","LD")
copyfile("variables_simuladas.mat","LD")

cd "./LD"
load variables_simuladas.mat
y = detrend(y);
h = detrend(h);
save "variables_simuladas.mat" y h

dynare Ferroni_4.mod
clear all
cd "../"
% 
% %%%% Estimación Modelo con Primeras Diferencias
%   {
%   PD
%   }

mkdir PD
copyfile("./archivos_mod/Ferroni_4.mod","PD")
copyfile("variables_simuladas.mat","PD")

cd "./PD"
load variables_simuladas.mat
y = diff(y);
h = diff(h);
save "variables_simuladas.mat" y h

dynare Ferroni_4.mod
clear all
cd "../"








