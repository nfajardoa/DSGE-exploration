% Replica simpificada del paper Borradores de Economia 1034 de Sebastian
% Amador (2018) "New Keynesian NAIRU and the Okun Law: An application for Colombia"

% Variables
var y_t             $Y$             ; % PIB
var y_bar_t         $\bar{Y}$       ; % PIB potencial
var pi_t            $\pi$           ; % Inflación
%var pi_us_t         $\pi^{US}_{t}$ ; % Inflación Extranjera
var i_t             $I$             ; % Tasa de interes nominal
%var i_us_t          $I^{US}$        ; % Tasa de interes nominal extranjera
var r_t             $R$             ; % Tasa de interes real
var r_us_t          $R^{US}$        ; % Tasa de interes real extranjera
var r_bar_t         $\bar{R}$       ; % Tasa de interes real neutral
var r_usbar_t       $\bar{R}^{US}$  ; % Tasa de interes real neutral extranjera
var z_t             $Z$             ; % Tasa de cambio
var z_bar_t         $\bar{Z}$       ; % Tasa de cambio en equilibrio
%var g_ybar_t        $g^{\bar{Y}}$   ; % Crecimiento del PIB potencial
var zgap_t          $z$             ; % Brecha de tasa de cambio
var rgap_t          $r$             ; % Brecha de tasa de interes
var ygap_t          $y$             ; % Brecha del producto 

% Choques
var x_t             $\chi$          ; % Demanda
var psi_t           $\Psi$          ; % Oferta

% Auxiliares
var pi_tar          $\pi^{TAR}$     ; % Tasa de interés de política

% Variables exogenas
varexo u_ybar_t     $\epsilon^{\bar{Y}}$        ; % Choque permanente al PIB 
%varexo u_gy_t       $\epsilon^{g^{Y}}$          ; % Choque transitorio al PIB
varexo u_rbar_t     $\epsilon^{\bar{R}}$        ; % Choque a la tasa de interes neutral
varexo u_rus_t      $\epsilon^{R^{US}}$         ; % Choque a la brecha de tasas de interes
varexo u_rusbar_t   $\epsilon^{\bar{R^{US}}}$   ; % Choque a la tasa de interes neutral extranjera
varexo u_zbar_t     $\epsilon^{\bar{Z}}$        ; % Choque a la tasa de cambio neutral
varexo u_y_t        $\epsilon^{Y}$              ; % Choque de Persistencia por el lado de la demanda
varexo u_i_t        $\epsilon^{I}$              ; % Choque a la tasa de interes nominal
varexo u_zz_t       $\epsilon^{Z-Z^{e}}$        ; % Choque a la paridad de tasas de interes
varexo u_pi_t       $\epsilon^{\pi}$            ; % Choque de Persistencia por el lado de la oferta


% Parametros
%parameters tau          $\tau$              ; tau       = 0.5    ; % Velocidad de convergencia del crecimiento del PIB potencial
parameters rho          $\rho$              ; rho       = 0.1082    ; % Velocidad de convergencia de la tasa de interes real
parameters rho_us       $\rho_{US}$         ; rho_us    = 0.9482    ; % Inverso aditivo de la velocidad de convergencia de la tasa de interes real extranjera
parameters kappa        $\kappa$            ; kappa     = 0.5043    ; % Párametro del proceso autoregresivo de la brecha de tasas de interes extranjeras
parameters phi          $\phi$              ; phi       = 0.8620    ; % Parámetro de las expectativas de tasa de interés
parameters beta1        $\beta_{1}$         ; beta1     = 0.6393    ; % Elasticidad de la brecha del PIB con respecto a su primer rezago
parameters beta2        $\beta_{2}$         ; beta2     = 0.1964    ; % Elasticidad de la brecha del PIB con respecto a las expectativas del siguiente periodo
parameters beta3        $\beta_{3}$         ; beta3     = 0.0863    ; % Elasticidad de la brecha del PIB con respecto a la brecha de tasas de interes en el periodo anterior
parameters beta4        $\beta_{4}$         ; beta4     = 0.0684    ; % Elasticidad de la brecha del PIB con respecto a la brecha de tasas de cambio en el periodo anterior 
parameters rho_y        $\rho_{y}$          ; rho_y     = 0.2470    ; % Persistencia choque de demanda y oferta
parameters lambda1      $\lambda_{1}$       ; lambda1   = 0.8156    ; % Ponderación de la inflación presente con respecto a las expectativas anuales y el periodo rezagado inmediatamente anterior       
parameters lambda2      $\lambda_{2}$       ; lambda2   = 0.0910    ; % Elasticidad de la inflación con respecto a la brecha del producto en un periodo anterior
parameters lambda3      $\lambda_{3}$       ; lambda3   = 0.0314    ; % Elasticidad de la demanda ante un cambio en la brecha de tasa de cambio
parameters gamma1       $\gamma_{1}$        ; gamma1    = 0.8695    ; % Ponderación de la tasa de interes nominal con respecto a la tasa de interes nominal pasada y la regla de taylor
parameters gamma2       $\gamma_{2}$        ; gamma2    = 0.0896    ; % Sensibilidad de la regla de Taylor a la brecha de inflación
parameters gamma3       $\gamma_{3}$        ; gamma3    = 0.7709    ; % Sensibilidad de la regla de Taylor a la bracha del producto
parameters g_ss         $g_{ss}$            ; g_ss      = 0.037     ; % Estado estacionario del crecimiento del PIB potencial
parameters r_ss         $r_{ss}$            ; r_ss      = 0         ; % Estado estacionario de la tasa de interes real
parameters r_us_ss      $r^{US}_{ss}$       ; r_us_ss   = 0         ; % Estado estacionario de la tasa de interes real extranjera
%parameters pi_us_t      $\pi_{US}$          ; pi_us_t   = 0         ; % Inflación Extranjera

% Especificacion

model(linear);
    
    % Definiciones  (1) a (6)
   
    y_bar_t                 = y_bar_t(-1) + u_ybar_t;  %(g_ybar_t/12) + u_ybar_t                                    ;   % Eq (1)
    r_us_t                  = kappa*(r_us_t(-1) - r_usbar_t(-1)) + u_rus_t + r_usbar_t                  ;   % Eq (8)   
    r_t                     = i_t - pi_t(+12)                                                           ;   % Eq (5)
    %i_us_t                  = r_us_t + pi_us_t(+12)                                                     ;   % Eq (6.5)
    z_bar_t                 = z_bar_t(-1) + u_zbar_t                                                    ;   % Eq (9)
    z_t(+1)                 = phi*z_t(+1) + (1-phi)*z_t(-1)                                             ;   % Eq (10)
    
    % Brechas    (7)  a  (10)
   
    ygap_t                  = y_t - y_bar_t                                                             ;   % Eq (0.5)
    ygap_t                  = beta1*ygap_t(-1) - beta2*ygap_t(+1) - beta3*r_t(-1) + beta4*z_t(-1)+x_t   ;   % Eq (11)
    rgap_t                  = r_t - r_bar_t                                                             ;   % Eq (5.5)
    zgap_t                  = z_t - z_bar_t                                                             ;   % Eq (8.5)
    
    % Choques    (11)  (12)
    
    x_t                     = rho_y*x_t(-1)   + u_y_t                                                   ;   % Eq (12)
    psi_t                   = rho_y*psi_t(-1) + u_pi_t                                                  ;   % Eq (14 Modificada)
    
    % Condiciones de equilibrio
    
    % Curva de Phillips     (13)       
    pi_t                    = lambda1*pi_t(+12) + (1-lambda1)*pi_t(-1) + lambda2*y_t(-1) + lambda3*(z_t-z_t(-12)) + psi_t             ;  % Eq (13)
    
    % Regla de Taylor       (14)     
    i_t                     = gamma1*i_t(-1) + (1-gamma1)*(r_bar_t + pi_t(+12) + gamma2*(pi_t(+12) - pi_tar) + gamma3*ygap_t) + u_i_t ;  % Eq (15)
    
    % Paridad de tasas de interés  (15)  a  (18)
    12*(z_t(+1) - z_t(-1))  = (r_t - r_us_t) - (r_bar_t - r_usbar_t) + u_zz_t                                                         ;  % Eq (16)
    
    %g_ybar_t                = tau*g_ss + (1-tau)*g_ybar_t(-1) + u_gy_t                                  ;  % Eq (2)
    r_bar_t                 = (rho)*r_ss + (1-rho)*r_bar_t(-1) + u_rbar_t                               ;  % Eq (6)
    r_usbar_t               = (1-rho_us)*r_us_ss + rho_us*r_usbar_t(-1) + u_rusbar_t                    ;  % Eq (7)
end;

steady_state_model;
    y_bar_t     = 0         ;
    y_t         = 0         ;
    pi_t        = 0         ; % 0.03 
    i_t         = 0         ; % iobs_t = 2.5/100*0+pitar_ss;    
    i_us_t      = 0         ;
    r_t         = 0         ;
    r_us_t      = 0         ;
    r_bar_t     = 0         ;
    r_usbar_t   = 0         ;
    z_t         = 0         ;
    z_bar_t     = 0         ;
    %g_ybar_t    = 0 ;%.001776         ;
    zgap_t      = 0         ;
    ygap_t      = 0         ;
    rgap_t      = 0         ;
    x_t         = 0         ;
    psi_t       = 0         ;
    pi_tar      = 0         ;
end;

%resid(1);
steady;  %(nocheck);

% Varianza de los choques
shocks;  
    var u_ybar_t    ;   stderr 0.001;
    var u_zbar_t    ;   stderr 0.006;
    var u_y_t       ;   stderr 0.01 ;
    var u_pi_t      ;   stderr 0.004;
    var u_rusbar_t  ;   stderr 0.01 ;    
    var u_rbar_t    ;   stderr 0.02 ;  
    %var u_gy_t      ;   stderr 0.01 ;
    var u_zz_t      ;   stderr 0.01 ;
    var u_i_t       ;   stderr 0.01 ;
end;

stoch_simul(order=1,irf=1);

estimated_params;
% Parameter , InitVal   , L-Bound   , U-Bound   , PriorShape    , PriorMean     , Prior SE  , 3erPar    , 4toPar;        
   %tau      , 0.4800    ,           ,           , Beta_pdf      , 0.05          , 0.01                          ;
   rho      , 0.1082    ,           ,           , Beta_pdf      , 0.50          , 0.10                          ;
   rho_us   , 0.9482    ,           ,           , Beta_pdf      , 0.80          , 0.05                          ;
   kappa    , 0.5043    ,           ,           , Beta_pdf      , 0.50          ,                               ;
   phi      , 0.8620    ,           ,           , Beta_pdf      , 0.50          ,                               ;
   beta1    , 0.6393    ,           ,           , Beta_pdf      , 0.75          ,                               ;
   beta2    , 0.1964    ,           ,           , gamma_pdf     , 0.25          , 0.05                          ;
   beta3    , 0.0863    ,           ,           , Gamma_pdf     , 0.075         , 0.01                          ;
   beta4    , 0.0684    ,           ,           , Gamma_pdf     , 0.10          , 0.05                          ;
   rho_y    , 0.2470    ,           ,           , Beta_pdf      , 0.50          ,                               ;
   lambda1  , 0.8156    ,           ,           , Beta_pdf      , 0.30          ,                               ;
   lambda2  , 0.0910    ,           ,           , Gamma_pdf     , 0.20          , 0.05                          ;
   lambda3  , 0.0314    ,           ,           , Gamma_pdf     , 0.50          , 0.025                         ;
   gamma1   , 0.8695    ,           ,           , Beta_pdf      , 0.70          ,                               ;
   gamma2   , 0.0896    ,           ,           , Beta_pdf      , 0.20          ,                               ;
   gamma3   , 0.7709    ,           ,           , Beta_pdf      , 0.80          ,                               ;
end;

% Estimacion
    write_latex_original_model;
