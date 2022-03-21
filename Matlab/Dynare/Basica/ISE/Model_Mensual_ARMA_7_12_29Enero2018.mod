%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modelo Neo-Keynesiano con inflaci?n de alimentos MENSUAL                %
% Se estima la curva de Phillips, la regla (?) y las desviaciones y       %
% persistencias de los choques.                                           %
% La inflacion de alimentos primarios (SA) sigue el proceso ARMA(5,7)     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Variables
  var	  i_t 			; % Tasa de interes de politica
  var	  r_t 			; % Tasa de interes real
  var	  x_t		   	; % Brecha
  var	  pi_t			; % Inflacion SA
  var	  pi_all_t		; % Inflacion total
  var	  pi_food_t		; % Inflacion de alimentos
  var	  y_pi_t 		; % Inflacion SA anual
  var	  y_pi_all_t	; % Inflacion total SA
  var     y_pi_food_t   ; % Inflacion de alimentos anual
  var	  expect		; % Expectativas de inflacion SA
  var	  expect_all 	; % Expectativas de inflacion total
  var     y_pi_bas_t    ; % Inflacion Basica (sin Alim P sin choque de oferta) - Anual
  var     pi_bas_t      ; % Inflacion Basica (sin Alim P sin choque de oferta) - Trimestral Anualizada
% var     dum_2016m07   ; % variable dicotómica modela outlier en Julio-2016

% Choques 
  var		zu_t 			; % Choque de demanda
  var		zinf_t			; % Choque de oferta
  var		zi_t			; % Choque de politica
  
% Auxiliares
  var		pitar_t    		; % Inflacion Meta

% Ecuaciones de medida
  var		iobs_t			; % Tasa de inter?s observada
  var		piobs_t    	 	; % Inflacion Total observada  
  var		pi_food_obs_t	; % Inflacion de alimentos observada
  
% Variables exogenas
  varexo	 sh_zu 			; % Choque de demanda
  varexo	 sh_zinf 		; % Choque de oferta		
  varexo	 sh_zi 			; % Choque de politica	
  varexo	 sh_inf_food	; % Choque de alimentos

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametros                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inflacion de alimentos										
    parameters	gamma 				 ;	gamma 				=	0.0388														;	% 	Participaci?n alimentos en inflaci?n total
    parameters	rho_inf_food_1 		 ;	rho_inf_food_1 		=	2.170725966596599    												;	% 	Par?metros ARMA alimentos
    parameters	rho_inf_food_2 		 ;	rho_inf_food_2 		=  -1.961193815214334											;	% 	Par?metros ARMA alimentos
    parameters	rho_inf_food_3 		 ;	rho_inf_food_3 		=	0.7280797281232739											;	% 	Par?metros ARMA alimentos
    parameters	rho_inf_food_7		 ;	rho_inf_food_7		=  -0.09426529178704675											;	% 	Par?metros ARMA alimentos
    parameters	rho_inf_ma_food_1	 ;	rho_inf_ma_food_1	=	0.5484406624921521 										    ;	% 	Par?metros ARMA alimentos
    parameters	rho_inf_ma_food_3	 ;	rho_inf_ma_food_3	=  -0.1109030580336203  										    ;	% 	Par?metros ARMA alimentos
    parameters	rho_inf_ma_food_10 	 ;	rho_inf_ma_food_10 	=	0.4730427555155248											;	%	Par?metros ARMA alimentos
    parameters	rho_inf_ma_food_12   ;	rho_inf_ma_food_12 	=  -0.1298859951466384											;	%	Par?metros ARMA alimentos
  % parameters	rho_dum_2016m08      ;	rho_dum_2016m08 	=	0.733792773776												;	%	Par?metro OUTLIER ARMA alimentos
  % INF_ALI_D12_MENANU_META = AR(1)=2.13767963533,AR(2)=-1.91604509408,AR(3)=0.711441139563,AR(7)=-0.107029854361,MA(1)=0.611526768501,MA(3)=-0.15963569356,MA(10)=0.530872196705,MA(12)=-0.241868630924,UNCOND,ESTSMPL="1999M12 2017M02"]


% Hogares										
    parameters	sigma 				;	sigma 				=	4																		;	% 	Inverso de la elasticidad de sustituci?n
    parameters	invsigma			;	invsigma			=	1/sigma																	;	% 	Elasticidad de sustituci?n
    parameters	eta					;	eta					=	1																		;	% 	Inverso de la elasticidad de Frish
    parameters	r_bar 				;	r_bar 				=	(1+0.025)^(1/12)															;	% 	Tasa de inter?s real 
    parameters	beta 				;	beta 				=	1/r_bar																	;	% 	Factor de descuento
% Regla de Taylor										
    parameters	varphi_pi 			;	varphi_pi 			=	3.86																	;	% 	Peso de la inflaci?n
    parameters	varphi_x 			;	varphi_x 			=	1.4																	;	% 	Peso de la brecha
    parameters	rho_i				;	rho_i				=	0.9																		;	% 	Suavizador
% Firmas										
    parameters	theta 				;	theta 				=	1-1/12																	;	% 	Probabilidad de no ajuste
    parameters	omega 				;	omega 				=	0.5																		;	% 	Probabilidad de ajustar sub?ptimamente
    parameters	psi 				;	psi 				=	(1-gamma)*(theta+omega*(1-theta*(1-beta)))																;	% 	Auxiliar
    parameters	phi1 				;	phi1 				=	0.27; % omega/psi																;	% 	Curva de Phillips Backward
    parameters	phi2 				;	phi2 				=	beta*theta/psi															;	% 	Curva de Phillips Forward
    parameters	kappa				;	kappa				=	0.001; %(1-omega)*(1-theta)*(1-beta*theta)*(1-gamma)/psi*(eta+sigma)			;	% 	Curva de Phillips Brecha
% Choques										
    parameters	rho_zu				;	rho_zu				=	0.8																		;	% 	Persistencia choque de demanda
    parameters	rho_zinf 			;	rho_zinf 			=	0.25																		;	% 	Persistencia choque de oferta
    parameters	rho_zi				;	rho_zi				=	0																		;	% 	Persistencia choque de pol?tica
    parameters	tau					;	tau					=	0.05																	;	% 	Persistencia choque de crecimiento
  % parameters	growth_ss 			;	growth_ss 			=	4/100																	;	% 	Crecimiento de s.s.
    parameters	pitar_ss 			;	pitar_ss 			=	0																;	% 	Inflaci?n meta

model(linear);
  % Local linear trend:
  % Curva IS:
    x_t = x_t(+1)-(invsigma)*r_t+zu_t;
  % Regla de Taylor
    i_t = rho_i*i_t(-1)+(1-rho_i)*(varphi_pi*pi_t+varphi_x*x_t)+zi_t;
  % Curva de Phillips
    pi_t = kappa*x_t+(1-phi1)*pi_all_t(+1)+phi1*pi_all_t(-1)+zinf_t;
  % Inflaci?n de alimentos (E-Views: Inf_Alimetos.wf1)
    pi_food_t = rho_inf_food_1*pi_food_t(-1)+rho_inf_food_2*pi_food_t(-2)+rho_inf_food_3*pi_food_t(-3)+rho_inf_food_7*pi_food_t(-7)+sh_inf_food+rho_inf_ma_food_1*sh_inf_food(-1)+rho_inf_ma_food_3*sh_inf_food(-3)+rho_inf_ma_food_10*sh_inf_food(-10)+rho_inf_ma_food_12*sh_inf_food(-12) ;
    % INF_ALI_D12_MENANU_META = AR(1)=2.13767963533,AR(2)=-1.91604509408,AR(3)=0.711441139563,AR(7)=-0.107029854361,MA(1)=0.611526768501,MA(3)=-0.15963569356,MA(10)=0.530872196705,MA(12)=-0.241868630924,UNCOND,ESTSMPL="1999M12 2017M02"]

  % Choques
    zu_t   = rho_zu*zu_t(-1)+sh_zu;
    zinf_t = rho_zinf*zinf_t(-1)+sh_zinf;
    zi_t   = rho_zi*zi_t(-1)+sh_zi;
  % Definiciones 
    i_t         = r_t+pi_t(+1);
    pi_all_t    = (1-gamma)*pi_t+gamma*pi_food_t;
    y_pi_t      = (pi_t+pi_t(-1)+pi_t(-2)+pi_t(-3)+pi_t(-4)+pi_t(-5)+pi_t(-6)+pi_t(-7)+pi_t(-8)+pi_t(-9)+pi_t(-10)+pi_t(-11))/12;
    y_pi_all_t  = (pi_all_t+pi_all_t(-1)+pi_all_t(-2)+pi_all_t(-3)+pi_all_t(-4)+pi_all_t(-5)+pi_all_t(-6)+pi_all_t(-7)+pi_all_t(-8)+pi_all_t(-9)+pi_all_t(-10)+pi_all_t(-11))/12;
    y_pi_food_t = (pi_food_t+pi_food_t(-1)+pi_food_t(-2)+pi_food_t(-3)+pi_food_t(-4)+pi_food_t(-5)+pi_food_t(-6)+pi_food_t(-7)+pi_food_t(-8)+pi_food_t(-9)+pi_food_t(-10)+pi_food_t(-11))/12;
    expect      = y_pi_t(+12);
    expect_all  = y_pi_all_t(+12);
    pi_bas_t    = pi_t - zinf_t;
    y_pi_bas_t  = (pi_bas_t+pi_bas_t(-1)+pi_bas_t(-2)+pi_bas_t(-3)+pi_bas_t(-4)+pi_bas_t(-5)+pi_bas_t(-6)+pi_bas_t(-7)+pi_bas_t(-8)+pi_bas_t(-9)+pi_bas_t(-10)+pi_bas_t(-11) )/12;

  % Ecuaciones de medida
    piobs_t       = pi_all_t;
    pitar_t       = pitar_ss;
    iobs_t        = i_t;
    pi_food_obs_t = pi_food_t+pitar_t;
end;


steady_state_model;
    x_t           = 0;
    pi_t          = 0;
    y_pi_t        = 0;
    pi_food_t     = 0;
    pi_all_t      = 0;
    y_pi_all_t    = 0;
    y_pi_food_t   = 0;
    pitar_t       = pitar_ss;
    expect        = 0;
    expect_all    = 0;
    i_t           = 0;
    pi_obs_t      = pitar_ss;
    pi_food_obs_t = pitar_ss;
    iobs_t        = 2.5/100*0+pitar_t;
    zi_t          = 0;
    zu_t          = 0;
    r_t           = 0;
    zinf_t        = 0;
    y_pi_bas_t    = 0;
    pi_bas_t      = 0; 
end;

steady(nocheck);

%% Varianza de los choques
shocks;  
    var sh_zinf  ;   stderr 0.006;
    var sh_zu    ;   stderr 0.01;
    var sh_zi    ;   stderr 0.004;
    var sh_inf_food; stderr 0.01;
end;

% con metodos bayesianos (Metrolis-Hastings)
estimated_params;

      % Parameter               , InitVal       , L-Bound   , U-Bound   , PriorShape    , PriorMean     , Prior SE  , 3erPar, 4toPar    ;      
        rho_zinf                , beta_pdf      , 0.30      , 0.15      , 0             , 1                         ; % Persistencia choque de oferta
        rho_zu                  , beta_pdf      , 0.70      , 0.15      , 0             , 1                         ;
        rho_i                   , beta_pdf      , 0.75      , 0.15      , 0             , 1                         ; % Suavizador regla
        stderr   sh_zinf        , inv_gamma_pdf , 0.005     , inf                                                   ; % Phillips
        stderr	 sh_zu          , inv_gamma_pdf , 0.058     , inf                                                   ; % IS 
        stderr	 sh_zi          , inv_gamma_pdf , 0.0125    , inf                                                   ; % Taylor
        stderr	 sh_inf_food    , inv_gamma_pdf , 0.0200    , inf                                                   ; % Alimentos
        varphi_pi               ,               ,           ,           , gamma_pdf     , 4             , 0.15      ; % Importancia de la inflaci?n en la regla
        varphi_x                ,               ,           ,           , gamma_pdf     , 1.1           , 0.15      ; % Importancia de la brecha en la regla
        invsigma                , beta_pdf      , 0.500     , 0.05      , 0.005         , 1                         ;
    end;
    
varobs
       x_t
       piobs_t
       iobs_t
       pi_food_obs_t
;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESTIMACION                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

estimation(first_obs=2, datafile='Data_Model_Mensual.mat', endogenous_prior,plot_priors=0,prior_trunc=0, 
mh_nblocks=4,  mh_replic=10000, mode_compute=0, mode_file=Model_Mensual_ARMA_7_12_29Enero2018_mode , mode_check, mode_check_symmetric_plots=0 ) piobs_t ;

