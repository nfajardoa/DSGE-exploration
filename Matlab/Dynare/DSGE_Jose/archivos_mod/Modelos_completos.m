%addpath c:\dynare\4.4.3\matlab
% Cambiar el siguiente directorio por cualquier carpeta que desee y que contenga
% la carpeta archivos_mod
%addpath C:\Users\USR_PracticanteGT42\Documents\Programacion\filt
%cd C:\Users\USR_PracticanteGT42\Documents\Programacion


%{
En la carpeta archivos_mod se encuentran todos los archivos necesarios para 
correr la programación y todos los modelos en cualquier computador simplemente
al ejecutar este archivo 
%}

%%%%% Simulación de variables lnY y lnH

  %{
  Realizar las simulaciones iniciales de 120 observaciones de lnY y lnH a partir
  del modelo de Chang, Doh, and Schorfheide (2007) y los parámetros calibrados de 
  acuerdo a Ferroni (2011)
  %}
%Número de simulaciones

%%%%%%%%%%%%%%%%%%%%%%

mkdir True
copyfile('./archivos_mod/Ferroni.mod','True')
cd './True'

dynare Ferroni.mod nograph

save 'variables_simuladas.mat' y h e_a e_b y_obs h_obs

clearall
%Número de simulaciones que ejecutará Dynare
numsim=240;
%Número de observaciones que se mantendrán como muestra
numobs=120;
load 'variables_simuladas.mat'

lnB=ones(numsim,1);
for i =2:numsim
  lnB(i,1)=lnB(i-1,1)+e_b(i,1);
endfor

lnH=zeros(numsim,1);
for i =1:numsim
  lnH(i,1)=h(i,1)+lnB(i,1)+log(0.94350963);
endfor

lnA=ones(numsim,1);
for i =2:numsim
  lnA(i,1)=lnA(i-1,1)+e_a(i,1);
endfor

lnY=zeros(numsim,1);
for i =1:numsim
  lnY(i,1)=y(i,1)+lnB(i,1)+lnA(i,1)+log(2.3664095);
endfor

clear y h

for i =1:numobs
  y(i,1)=lnY(i+numobs);
endfor

for i =1:numobs
  h(i,1)=lnH(i+numobs);
endfor

y_obs = y;
h_obs= h;


save '../variables_simuladas.mat' lnY lnH lnA lnB y h y_obs h_obs
clear all
cd '../'

%%%%% Estimación Modelo Verdadero
  %{
  Realizar la estimación de algunos parámetros del modelo teniendo las variables
  simuladas lnY y lnH, usando la transformación verdadera del modelo para volver
  estas variables estacionarias
  %}

mkdir true_model
copyfile('./archivos_mod/Ferroni_2.mod','true_model')
copyfile('variables_simuladas.mat','true_model')

cd './true_model'
dynare Ferroni_2.mod nograph
clear all
cd '../'

%%%%% Estimación Modelo mala especificación
  %{
  a
  %}

mkdir tech_UR
copyfile('./archivos_mod/Ferroni_3.mod','tech_UR')
copyfile('variables_simuladas.mat','tech_UR')

cd './tech_UR'
dynare Ferroni_3.mod nograph
clear all
cd '../'

%%%%% Estimación Modelo con filtro HP
  %{
  HP
  %}

mkdir HP
copyfile('./archivos_mod/Ferroni_4.mod','HP')
copyfile('variables_simuladas.mat','HP')

cd './HP'
load variables_simuladas.mat
y = HP(lnY,1600,0);
h = HP(lnH,1600,0);
plot(y);
print -djpg y.jpg;
plot(h);
print -djpg h.jpg;

a=y;
b=h;
clear y h;
for i =1:120
  y(i,1)=a(i+120)
endfor

for i =1:120
  h(i,1)=b(i+120)
endfor
save 'variables_simuladas.mat' y h

clear all
dynare Ferroni_4.mod nograph
clear all
cd '../'

%%%%% Estimación Modelo con filtro Baxter-King
  %{
  HP
  %}

mkdir BK
copyfile('./archivos_mod/Ferroni_4.mod','BK')
copyfile('variables_simuladas.mat','BK')

cd './BK'
load variables_simuladas.mat
y = BK(y,8,32,12);
h = BK(h,8,32,12);
plot(y);
print -djpg y.jpg;
plot(h);
print -djpg h.jpg;
save 'variables_simuladas.mat' y h

clear all
dynare Ferroni_4.mod nograph
clear all
cd '../'

%%%%% Estimación Modelo con filtro Christiano-Fitzgerald
  %{
  CF
  %}

mkdir CF
copyfile('./archivos_mod/Ferroni_4.mod','CF')
copyfile('variables_simuladas.mat','CF')

cd './CF'
load variables_simuladas.mat
y = CF(y,8,32,12);
h = CF(h,8,32,12);
plot(y);
print -djpg y.jpg;
plot(h);
print -djpg h.jpg;
save 'variables_simuladas.mat' y h

clear all
dynare Ferroni_4.mod nograph
clear all
cd '../'

%%%%% Estimación Modelo con filtro Butterworth
  %{
  CF
  %}

mkdir BW
copyfile('./archivos_mod/Ferroni_4.mod','BW')
copyfile('variables_simuladas.mat','BW')

cd './BW'
load variables_simuladas.mat
y = butterworth(y,4,8);
h = butterworth(h,4,8);
plot(y);
print -djpg y.jpg;
plot(h);
print -djpg h.jpg;
save 'variables_simuladas.mat' y h

clear all
dynare Ferroni_4.mod nograph
clear all
cd '../'


%%%%% Estimación Modelo con Linear Detrending
  %{
  LD
  %}

mkdir LD
copyfile('./archivos_mod/Ferroni_4.mod','LD')
copyfile('variables_simuladas.mat','LD')

cd './LD'
load variables_simuladas.mat
y = detrend(y);
h = detrend(h);
plot(y);
print -djpg y.jpg;
plot(h);
print -djpg h.jpg;
save 'variables_simuladas.mat' y h

clear all
dynare Ferroni_4.mod nograph
clear all
cd '../'

%%%%% Estimación Modelo con Primeras Diferencias
  %{
  PD
  %}

mkdir PD
copyfile('./archivos_mod/Ferroni_4.mod','PD')
copyfile('variables_simuladas.mat','PD')

cd './PD'
load variables_simuladas.mat
y = diff(y);
h = diff(h);
plot(y);
print -djpg y.jpg;
plot(h);
print -djpg h.jpg;
save 'variables_simuladas.mat' y h

clear all
dynare Ferroni_4.mod nograph
clear all
cd '../'






