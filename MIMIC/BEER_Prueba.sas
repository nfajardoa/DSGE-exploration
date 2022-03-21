
* ENSAYANDO PROC SSM para estimar modelo estructural como en:
* Chen_MacDonald_2015_Measuring the Dollar Euro Permanent Equilibrium Exchange Rate using the Unobserved Component Model.pdf;
* O J O : se debe ejecutar en "SAS (Inglés)" y  NOOO en "SAS (Español(Castellano))" u otro idioma;

DM "LOG;CLEAR;OUT;clear;ODSRESULTS;CLEAR;PGM";
* MEMSIZE=16147483648; * 2147483648;  *16106127360;

* options macrogen MPRINT MTRACE mautosource symbolgen  LINESIZE=180 NOTES;
options MPRINT NOMTRACE NOmautosource NOsymbolgen  LINESIZE=180 NOTES;
*options NOmacrogen NOMPRINT NOMTRACE NOmautosource NOsymbolgen  LINESIZE=180 NONOTES NOSOURCE;

*LIBNAME BEER "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\TasaCambioReal";
LIBNAME BEER "D:\users\NRO\DEPE\OTROS\TasaCambioReal";
/* Esta version 20 Agosto 2018 estandarizando las variables TODAS   */
/*
PROC IMPORT OUT=BEER.DATA_IPCS 
            DATAFILE= "D:\users\NRO\DEPE\OTROS\TasaCambioReal\datos_beer_vec_q.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Hoja1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
*ITCR_IPC	ITI_CE	Produc_usa_col	ConsPub	RemUtilid	Diff_usa_col	IED	Portafolio	Resto	EMBI	PIBsoc	DES1	DES2	DES3	
    dum96q1	dum97q1	dum02q3	dum03q4	dum08q4	dum09q4	dum10q3	dum13q4	dum15q4	IED_Corr	dum15q3
;
DATA BEER.DATA_HARVEY; 
   SET BEER.DATA_IPCS ;
   T = _N_ ;
   DATE = INTNX('QUARTER','01MAR1994'D,_N_-1);
   FORMAT DATE MONYY5.;
   Q = ITCR_IPC ;
   TOT = ITI_CE ;
   PD = Produc_usa_col ;
   GOV = ConsPub ;
   RD = Diff_usa_col ;
RUN;

DATA BEER.DATA_HARVEY; 
   SET  BEER.DATA_HARVEY; 
   WHERE DATE >= '01JAN2000'D ;
RUN;

PROC GPLOT DATA=BEER.DATA_HARVEY; ;
  PLOT Q*daTE ;
RUN;
QUIT;

PROC ARIMA DATA=BEER.DATA_HARVEY;
   *I VAR=TOT  STATIONARITY=(DICKEY) ; * NONSTATIONARY MEAN ADF ;
   *I VAR=PD  STATIONARITY=(DICKEY)  ; * NONSTATIONARY WITH TREND ADF;
   *I VAR=GOV  STATIONARITY=(DICKEY) ; * NONSTATIONARY MEAN (MAYBE BREAK) ADF ;
   *I VAR=RD  STATIONARITY=(DICKEY)  ;  * OK STATIONARY MENA ADF;
   I VAR=Q  STATIONARITY=(DICKEY)   ; * NONSTATIONARY WITH TREND ADF;
RUN; 
QUIT;
*/


/*
ticket 
Para su referencia ticket #7612495703 fue abierto en su nombre.
11 Julio 2018 11:05 AM de Colombia
*/

PROC STANDARD DATA=BEER.DATA_HARVEY MEAN=0 OUT=BEER.DATA_HARVEY_MEAN0;
   VAR TOT PD GOV RD;
RUN;

PROC MEANS DATA=BEER.DATA_HARVEY_MEAN0;
RUN;

PROC IML ;
  media = 1 ;
  ** Datos --> Matrices * ;
  *IF MEAN=0 THEN DO;
      use BEER.DATA_HARVEY_MEAN0;
	                                read all var{tot pd gov rd q} into y ;
  close BEER.DATA_HARVEY ;


  Y = standard(Y) ;
  n=nrow(y);   t = nrow(y);
  Ny = ncol(y);
  store y n Ny ;
  Q = y[,5] ;
  /*
  use alfa.param;
  read all into theta;
  close alfa.param;
  ttheta=t(theta);
  print ttheta;
  */
  *Conformación de Matrices*;
     *Matriz H*;
  *% Kalman Filer % Durbin y Koopmans, Chap 4.  
  *%[loglik, zf, Pf, D, zp] = kalman_u(y,H,F,W,a,b,V,Q,varargin)
  *% y_t = b_t + H_t*z_{t-1} + e_t         MEDIDA       Q = Var(e_t)
  *% z_t = a_t + F_t*z_{t-1} + W_t*n_t     TRANSICION   V = Var(W_t*n_t)
  *% paper ChenMcDonald (2015)   kalman_u(y,Z,T,H,d,b,V,Q,varargin)
  *% y_t = b + Z_t*a_{t}   + e_t           MEDIDA       Q = Var(e_t)
  *% a_t = d + T_t*a_{t-1} + H_t*n_t       TRANSICION   V = Var(H_t*n_t)
  *% de paper ChenMcDonald 2015: at=[tot_bar_t pd_bar_t gov_bar_t tot_t pd_t gov_t rid_t tot_t-1 pd_t-1 gov_t-1 rid_t-1 v_t];

  phi1_tot = 2.02 ;
  phi1_pd  = 0.9497 ;
  phi1_gov = 1.9048 ;
  phi1_rid = 1.2078 ;
  phi2_tot = -1.0230 ;
  phi2_pd  = -0.01009 ;
  phi2_gov = -0.9117 ;
  phi2_rid = -0.42629 ;

  K = 4 ;
  Tf1 = j(K,K,0);
  Tf1[1,1]  =  phi1_tot ;
  Tf1[2,2]  =  phi1_pd ;
  Tf1[3,3]  =  phi1_gov ;
  Tf1[4,4]  =  phi1_rid ;
  Tf2 = j(K,K,0);
  Tf2[1,1]  =  phi2_tot ;
  Tf2[2,2]  =  phi2_pd ;
  Tf2[3,3]  =  phi2_gov ;
  Tf2[4,4]  =  phi2_rid ;

  TMat = ( i(K-1)     || j(K-1,K,0) || j(K-1,K,0) || j(K-1,1,0) ) //
         ( j(K,K-1,0) || Tf1        || Tf2        || j(K,1,0) )   //
         ( j(K,K-1,0) || i(K)       || j(K,K,0)   || j(K,1,0) )   //
         ( j(1,K-1,0) || j(1,K,0)   || j(1,K,0)   || i(1)     )  ; 

  theta1 = -0.61 ;    * ToT ;
  theta2 =  0.22 ;    * Pd ;
  theta3 = -2.22 ;    * Gov ;
  vartheta1 = 0.48 ; * D(Tot) ;
  vartheta2 = 3.598 ; * D(Pd)) ;
  vartheta3 = 2.779 ; * D(Gov) ;
  vartheta4 = 0.176 ; * Rid ;

  ZMat = ( I(K-1) // J(1,K-1,0) ) || I(K) || J(K,K+1,0)   ; *print ZMat ;
  ZMat = ZMat // ( theta1||theta2||theta3||vartheta1||vartheta2||vartheta3||vartheta4||J(1,K,0)|| 1 ) ; *print ZMat ;

  beta_tot=0.162; beta_pd=-1.6; beta_gov=-0.73;
  d = (beta_tot || beta_pd|| beta_gov || j(1,ncol(TMat)-3,0))`;

  sig_n_tot=1.55; sig_n_pd=1.011; sig_n_gov=0.28;  sig_k_tot=-2.8; sig_k_pd=-2.69; sig_k_gov=-3.8; sig_k_rid=1.68; sig_n_1=-3.4;
  HMat = diag(exp(sig_n_tot||sig_n_pd||sig_n_gov || sig_k_tot || sig_k_pd || sig_k_gov|| sig_k_rid || j(1,K,0) || sig_n_1 ));
  *%VMat = eye(size(HMat,1))*0.2;
  VMat = HMat**2;

  Nz = nrow(TMat) ;
  Ny = ncol(Y) ;
  N = NROW(Y);
  b=j(Ny, 1, 0);
  sig_e_tot=-2.43; sig_e_pd=-0.16; sig_e_gov=1.48; sig_e_rid=1.48; sig_e_1=0.042;
  *QMat = diag((sig_e_tot || sig_e_1))**2 ;
  QMat = diag(exp(sig_e_tot||sig_e_pd||sig_e_gov||sig_e_rid||sig_e_1))**2 ;
  *%Q= eye(Ny)*0.0025 ; *%var-cov de v ruido de eq medida u observacion ;
  *%afini = zeros(Nz,1); *% tot_bar_t	 pd_bar_t	 gov_bar_t	 tot_t	 pd_t	 gov_t	 rid_t	 tot_t-1	 pd_t-1	 gov_t-1	 rid_t-1	 v_t
  **************************************************************************************;
  *Matriz total de var-cov*;
 	var=block(VMat,QMat);
  *Valores Iniciales*;
  * load z0;
  * load vz0;
  * afini = ( Y[1,1:3] || j(1,ncol(Tmat)-3,0) ) ;
  afini = ( Y[1,1:3] || 0 || 0 || 0 || Y[1,4] || j(1,ncol(Tmat)-7,0) ) ;
print afini ; 
  Pfini = i(nrow(TMat))*10000;
  z0=afini;
  vz0=Pfini;
  *Filtro de Kalman*;
    call kalcvf(pred,vpred,filt,vfilt,y,0,d,TMat,b,ZMat,var,z0,vz0);
    *call kalcvf(pred,vpred,filt,vfilt,y,0,d,TMat,b,ZMat,var);
	*call kalcvf(pred,vpred,filt,vfilt,y,0,a,f   ,b,h   ,var );
 	call kalcvs(sm,vsm,y,d,TMat,b,ZMat,var,pred,vpred);
  nrvsm = nrow(vsm);
  print nrvsm ;
  ncvsm = ncol(vsm);
  print ncvsm ;
  vsm_fin = vsm[ 865:876, ]; print vsm_fin ;
   *call kalcvf(pred,vpred,filt,vfilt,Y,0,A, F  ,B, H  ,VAR,T(A0),P0);
   *call kalcvf(pred,vpred,filt,vfilt,y,0,d,TMat,b,ZMat,var);


print sm[] ;
	peer = theta1*SM[,1] + theta2*SM[,2] + theta3*SM[,3] + SM[,12]  ;     
PRINT PEER;
x = do(1, Nz,1);
title "PEER Serie Plot";
call Series(x, PEER) ; *other="refline -2 2 / axis=x" grid={X Y};
quit;
run;

 SYMBOL1 INTERPOL=JOIN VALUE='' COLOR=BLUE W=1 L=0.5 ;
 SYMBOL2 LINE=3 I=JOIN ; *INTERPOL=NONE VALUE=*  COLOR=RED W=1.0 ; *L=0.9 ;
 axis1 label=('TRIMESTRE') order=('01MAR2000'd to '01MAR2018'd by year);
 legend1 label=none
        position=(top center inside)
        mode=share;

proc gplot data=SAL_PEER;
   plot high*year low*year / overlay legend=legend1
                             vref=1000 to 5000 by 1000
                             lvref=2
                             haxis=axis1 hminor=4
                             vaxis=axis2 vminor=1;
run;
quit;




     Nr_pred = NROW(pred);NC_pred = NCOL(pred);Nr_Vpred = NROW(Vpred);NC_Vpred = NCOL(Vpred);
     *print     nr_pred nc_pred nr_Vpred nc_Vpred ;

  store Y  N Ny ; *ZMat ;
    theta_0 = (theta1     || theta2    || theta3    || vartheta1 || vartheta2 || vartheta3 || vartheta4 || beta_tot   || beta_pd   || beta_gov || 
             sig_e_tot  || sig_e_pd  || sig_e_gov || sig_e_rid || sig_e_1   || sig_n_tot || sig_n_pd  ||  sig_n_gov || sig_k_tot ||  sig_k_pd || 
             sig_k_gov || sig_k_rid || sig_n_1 || 0 || 0 || 0|| 0|| 0|| 0|| 0|| 0) ; 
    theta_media_0 = (theta1     || theta2    || theta3    || vartheta1 || vartheta2 || vartheta3 || vartheta4 || beta_tot   || beta_pd   || beta_gov || 
             sig_e_tot  || sig_e_pd  || sig_e_gov || sig_e_rid || sig_e_1   || sig_n_tot || sig_n_pd  ||  sig_n_gov || sig_k_tot ||  sig_k_pd || 
             sig_k_gov || sig_k_rid || sig_n_1 || 0 || 0 || 0|| 0|| 0|| 0|| 0|| 0|| 0 ) ; 
   	     *theta_0=J(31,1,-0.01);
		 *c = j(31, 1,0); * seed);        /* generate random numbers from the same seed */
         *theta_0 = normal(c);
*theta_0=(-5.468398||1.682219||0.499727|| 0.752434|| -3.885606|| 0.228911|| -0.462149|| -0.479727|| 0.376005|| -1.636375|| -2.317034|| -0.590251|| 1.924908|| 1.719391|| -1.590768|| 1.505205|| 1.479987|| 2.228394||
-2.230355|| -2.381764|| -0.16438|| 1.415897|| -0.65113|| 1.03543|| 1.0729|| 1.552997|| 1.589438|| 0.00606|| -0.0341|| -0.570638|| -0.652432) ; 
   print theta_0 ;
   ttheta_0=theta_0`;
   print ttheta_0 ;
   nparam = ncol(theta_0)*nrow(theta_0); *31;
   *nparam = ncol(theta_media_0)*nrow(theta_media_0); *32;
   print nparam ;

   *Funcion objetivo*;
   START f_ob(theta);
       load Y  N Ny ; * ZMat ;     *load Y N V A F B H A0 P0 S;
       nr=Nrow(ZMat);  K = Ny-1 ; *print K ;
	   ZMat = ( I(K-1) // J(1,K-1,0) ) || I(K) || J(K,K+1,0)   ; *print ZMat ;
       ZMat = ZMat // ( theta[1]||theta[2]||theta[3]||theta[4]||theta[5]||theta[6]||theta[7]||J(1,K,0)|| 1 ) ; * print ZMat ;
       Tf1 = j(K,K,0); Tf1[1,1] = theta[24] ; Tf1[2,2] = theta[25] ;  Tf1[3,3] = theta[26] ; Tf1[4,4] = theta[27] ; 
       Tf2 = j(K,K,0); Tf2[1,1] = theta[28] ; Tf2[2,2] = theta[29] ;  Tf2[3,3] = theta[30] ; Tf2[4,4] = theta[31] ;
       TMat = ( i(K-1)     || j(K-1,K,0) || j(K-1,K,0) || j(K-1,1,0) ) //
              ( j(K,K-1,0) || Tf1        || Tf2        || j(K,1,0) )   //
              ( j(K,K-1,0) || i(K)       || j(K,K,0)   || j(K,1,0) )   //
              ( j(1,K-1,0) || j(1,K,0)   || j(1,K,0)   || i(1)     )  ; 
	   Nz = nrow(TMat) ;
       sig_n_tot_0=theta[16];sig_n_pd_0=theta[17];sig_n_gov_0=theta[18]; sig_k_tot_0=theta[19];sig_k_pd_0=theta[20];sig_k_gov_0=theta[21];sig_k_rid_0=theta[22];sig_n_1_0=theta[23];
       HMat = diag(exp(sig_n_tot_0||sig_n_pd_0||sig_n_gov_0||sig_k_tot_0||sig_k_pd_0||sig_k_gov_0||sig_k_rid_0||J(1,K,0)||sig_n_1_0) );
       VMat = HMat**2;
       sig_e_tot_0=theta[11]; sig_e_pd_0=theta[12]; sig_e_gov_0=theta[13]; sig_e_rid_0=theta[14]; sig_e_1_0=theta[15];
	   QMat = diag(exp(sig_e_tot_0||sig_e_pd_0||sig_e_gov_0||sig_e_rid_0||sig_e_1_0))**2 ;
       VAR=block(VMat,QMat);
 	*CALL KALDFF(pred, vpred, initial, s2   , data, lead, int, coef, var, intd, coefd <*>, n0 <*>, at <*>, mt <*>, qt ) ; 
    *call kalcvf(pred,vpred,filt,vfilt,y,0,d,TMat,b,ZMat,var,z0,vz0);
       nb=nz; nd=nz;
       int   = (( I(3) // J(9,3,0))` || J(5,3,0)` )` ;
	   int_media =  (( (I(3)||J(3,1,0)) // J(9,4,0))` || J(5,4,0)` )` ; int_media[17,4]=1;
       coef  = (TMat` || ZMat`)` ;
       intd  = j(15,1,0);  intd[13] = theta[8]; intd[14] = theta[9]; intd[15] = theta[10]; 
       intd_media=j(16,1,0);intd_media[13]=theta[8];intd_media[14]=theta[9];intd_media[15]=theta[10];intd_media[16]=theta[32];
       coefd = (j(3,12,0) || I(3) )` ; 
       coefd_media = (j(4,12,0) || I(4) )` ; 
       *call kaldff(pred, vpred,  init_difu  , s2 ,  y  ,  0  ,  int    , coef ,var, intd, coefd );        *print pred filt;
       call kaldff(pred, vpred,  init_difu  , s2 ,  y  ,  0  , int_media, coef ,var, intd_media, coefd_media );        *print pred filt;
       nc_Y = NCOL(Y); Nr_y = NROW(Y);
       Nr_pred = NROW(pred);NC_pred = NCOL(pred);
       Nr_Vpred = NROW(Vpred);NC_Vpred = NCOL(Vpred); *print  Nr_Vpred NC_Vpred ;
       nc_H = NCOL(H); Nr_H = NROW(H);       *print nr_y nc_y nr_H nc_H    nr_pred nc_pred nr_Vpred nc_Vpred ;
       et=y-pred*T(ZMat); *print et;      *et=y-VECDIAG(h*T(pred));  *print et;
       nc_et = NCOL(et); Nr_et = NROW(et);  *print nr_et nc_et;
       sum1=0; sum2=0;  *print n ;
       do i=1 to n;             *        posi=(i-1)*nz+1:i*nz; * print posi;
          vpred_i = vpred[(i-1)*nz+1:i*nz , ] ;  * OOOO JJJJ OOOO CON ESToooooooo !!!  VPRED ES TAMAÑO 29362 (=53*554) x 53 para EFECTIVO;            * PRINT VPRED_I ;
          et_i = et[i,];
                ft1= ZMat*vpred_i*T(ZMat);   *h[i]*vpred_i*h[i]`;
                ft2= var[K+2,K+2];  * var[54:54,54:54]; *var[nz+1:nz+V,nz+1:nz+V]; *CREO era eror antes ;
                ft = ft1+ft2 ; *Dt del manual;    *print ft1, ft2, ft;
                if det(ft) <=0 then sum1 =-20;                else do;                sum1 = sum1 + log(det(ft));           end;
          sum2 = sum2 + et_i*ginv(ft)*T(et_i);           *sum2 = sum2 + (et_i)*T(et_i)/ft;
       end;
	   *print vpred_i ;
	   *nrv = nrow(vpred_i); 	  *print nrv ;
 	   *ncv = ncol(vpred_i);   	  *print ncv ;
       *print sum1 sum2 ;
 	   const = nz*log(8*atan(1));
       fv=(-const-0.5*(sum1+sum2)/n);
      return(fv);
   finish;  * FINISH F_OB ;

   * print theta_0;
   *f_o = f_ob(theta_0);
   f_o = f_ob(theta_media_0);
   print     f_o ;

   *Procedimiento numerico BFGS para maximización de función de verosimilitud;
   tc={80000 100000};
   optn={1 3};    *blc=j(2,nparam,.); *blc[1,(nparam-13):nparam]=0.000001;
   *call nlpnms(rc,theta_opt,"f_ob",theta_0,optn, ,tc);     *call nlpnms(rc,theta_OPT,"f_ob",theta_0,optn);  
   call nlpnms(rc,theta_opt,"f_ob",theta_media_0,optn, ,tc);     *call nlpnms(rc,theta_OPT,"f_ob",theta_0,optn);  

   call nlpfdd(CRIT , grad, hess, "F_OB", theta_OPT,optn);
   *ttheta_opt = theta_opt` ;
   PRINT theta_opt ; 
   print grad;
   print hess;

   Tf1_opt = j(K,K,0); Tf1_opt[1,1] = theta_opt[24] ; Tf1_opt[2,2] = theta_opt[25] ;  Tf1_opt[3,3] = theta_opt[26] ; Tf1_opt[4,4] = theta_opt[27] ; 
   Tf2_opt = j(K,K,0); Tf2_opt[1,1] = theta_opt[28] ; Tf2_opt[2,2] = theta_opt[29] ;  Tf2_opt[3,3] = theta_opt[30] ; Tf2_opt[4,4] = theta_opt[31] ;
   TMat_opt = ( i(K-1)       || j(K-1,K,0) || j(K-1,K,0) || j(K-1,1,0)) //
              ( j(K,K-1,0) || Tf1_opt    || Tf2_opt    || j(K,1,0) )    //
              ( j(K,K-1,0) || i(K)       || j(K,K,0)   || j(K,1,0) )    //
              ( j(1,K-1,0) || j(1,K,0)   || j(1,K,0)   || i(1)     )  ; 
print TMat_opt ;

   ZMat_opt = ( I(K-1) // J(1,K-1,0) ) || I(K) || J(K,K+1,0)   ;   * print ZMat_opt ;
   ZMat_opt = ZMat_opt // ( theta_opt[1:7]`||J(1,K,0)|| 1 ) ;           
print ZMat_opt ;
     bvec=theta_opt[8:10];
	 sig_n_tot_opt=theta_opt[16];sig_n_pd_opt=theta_opt[17];sig_n_gov_opt=theta_opt[18]; sig_k_tot_opt=theta_opt[19];sig_k_pd_opt=theta_opt[20];sig_k_gov_opt=theta_opt[21];sig_k_rid_opt=theta_opt[22];sig_n_1_opt=theta_opt[23];
     HMat_opt = diag(exp(sig_n_tot_opt||sig_n_pd_opt||sig_n_gov_opt||sig_k_tot_opt||sig_k_pd_opt||sig_k_gov_opt||sig_k_rid_opt||J(1,K,0)||sig_n_1_opt) );
     VMat_opt = HMat_opt**2;
     sig_e_tot_opt=theta_opt[11]; sig_e_pd_opt=theta_opt[12]; sig_e_gov_opt=theta_opt[13]; sig_e_rid_opt=theta_opt[14]; sig_e_1_opt=theta_opt[15];
	 QMat_opt = diag(exp(sig_e_tot_opt||sig_e_pd_opt||sig_e_gov_opt||sig_e_rid_opt||sig_e_1_opt))**2 ;

     VAR_opt=block(VMat_opt,QMat_opt);
 *nb = 3 ;  
       int   = (( I(3) // J(9,3,0))` || J(5,3,0)` )` ; *int   = (( I(nb) // J(9,nb,0))` || J(5,nb,0)` )` ;
 nb = ncol(int);
       coef_opt  = (TMat_opt` || ZMat_opt`)` ;
       intd  = j(15,1,0);
       coefd = (j(nb,12,0) || I(nb) )` ; 
   *Nz = nrow(TMat_opt) ;
   nz = ncol(coef_opt);
   nd = ncol(coefd);  *nd = 1 ; print nd ;
   mt = j(t*nz,nz,0);
   qt = j(t*(nd+1),nd+1,0);
*  at = j(nz, nd+1, . );
*  mt = j(nz, nz, . );
*  qt = j(nd+1, nd+1, .);
  n0=-1; lead=0;
      *CALL KALDFF(pred   , vpred    , initial   , s2 , data , lead, int, coef     , var     , intd, coefd <*>, n0 <*>, at <*>, mt <*>, qt ) ; 
     *call kaldff(pred_opt, vpred_opt, init_difu , s2 ,  y   ,  0  , int, coef     , var     , intd, coefd );        *print pred filt;
  if media=0 then do;
      print media ;
      at = j(t*nz,nd+1,0);
      call kaldff(pred_opt, vpred_opt, init_difu , s2 ,  y  ,  lead , int, coef_opt , var_opt , intd, coefd, n0 , at, mt, QT );
  end;
  else do;
      print media ;
      at_media = j(t*nz,nd+1+1,0);
      int_media =  (( (I(3)||J(3,1,0)) // J(9,4,0))` || J(5,4,0)` )` ; int_media[17,4]=1;
      intd_media=j(16,1,0);intd_media[13]=theta_opt[8];intd_media[14]=theta_opt[9];intd_media[15]=theta_opt[10];intd_media[16]=theta_opt[32];
      print intd_media;
      coefd_media = (j(4,12,0) || I(4) )` ; 
      QT_media = j(t*(nd+1+1),nd+1+1,0);
      call kaldff(pred_opt, vpred_opt , init_difu , s2 ,  y  ,  0    , int_media, coef_opt ,var_opt, intd_media, coefd_media, n0 , at_media, mt, QT_media  );     
	  *print pred filt;
	  print init_difu ;
      *call kaldff(pred, vpred, initial, s2, y, 0, int, coef, var, intd, coefd, n0, at, mt, qt);
  end;
  nr_intd =  nrow(intd) ; nc_intd =  ncol(intd) ;  print nr_intd nc_intd ;
   *  print int ;
  print init_difu ;

    if media= 0 then do;
  		bvec = intd[nz+1:nz+nb , ] ;
 	  	bmat = coefd[nz+1:nz+nb, ] ;
      *CALL KALDFS(sm     ,      vsm,  data, int, coef     , var     , bvec , bmat     , initial   , at , mt , s2 <, un, vun> ) ; 
      call kaldfs(smd_opt, vsmd_opt,   y  , int , coef_opt , var_opt , bvec , bmat     , init_difu , at , mt , s2 );
      *CALL KALDFS(sm , vsm , data, int, coef, var_opt, bvec, bmat, initial, at, mt, s2 <, un, vun> ) ; 
      *print filt;
	end;
	if media = 1 then do;
		bvec = intd_media[nz+1:nz+nb,];
		bmat = coefd_media[nz+1:nz+nb,];
		un  = j(nz, nd+1+1, 0);
		vun = j(nz, nz, 0);
        call kaldfs(smd_opt, vsmd_opt,   y  , int , coef_opt , var_opt , bvec , bmat     , init_difu , at_media , mt , s2, un, vun );
	end;
    PRINT smd_opt;
	*print vsm;
	salida_sm   = smd_opt;
    salida_pred = pred_opt;
    *salida_filt = filt_opt;
   * print salida_sm;
  
	*peer = THETA1*SM[,1] + THETA2*SM[,2] + THETA3*SM[,3] + SM[,12] ;  *   PRINT PEER;
	*peer = theta_opt[1]*SM[,1] + theta_opt[2]*SM[,2] + theta_opt[3]*SM[,3] + SM[,12] ;  *   PRINT PEER;
	peer = theta_opt[1]*SMd_opt[,1] + theta_opt[2]*SMd_opt[,2] + theta_opt[3]*SMd_opt[,3] + SMd_opt[,12]  ;  *   PRINT PEER;
	*peer = theta_opt[1]*SMd_opt[,1] + theta_opt[2]*SMd_opt[,2] + theta_opt[3]*SMd_opt[,3] + SMd_opt[,12] + theta_opt[8] + theta_opt[9] + theta_opt[10] ;  *   PRINT PEER;

	Misalig = Q - PEER ;
	*Misalig = VARTHETA1*SM[,4] + VARTHETA2*SM[,5] + VARTHETA3*SM[,6] + VARTHETA4*SM[,7] ;

	PTOT = SMd_opt[,1] ;
	PPD  = SMd_opt[,2] ;
	PGOV = SMd_opt[,3] ;
   create sal_sm from salida_sm;
		append from salida_sm;
   close sal_sm;
   create SAL_PEER from PEER[colname="PEER"];
		append from PEER;
   close sal_PEER;
   create SAL_PTOT from PTOT[colname="PTOT"];
		append from PTOT;
   close sal_PTOT;
   create SAL_PPD from PPD[colname="PPD"];
		append from PPD;
   close sal_PPD;
   create SAL_PGOV from PGOV[colname="PGOV"];
		append from PGOV;
   close sal_PGOV;
   create SAL_MISAL from Misalig[colname="Misalig"];
		append from Misalig;
   close sal_MISAL;
 quit; * from IML ;


 DATA BEER.SAL_SM;
   MERGE SAL_PTOT SAL_PPD SAL_PGOV SAL_SM SAL_PEER SAL_MISAL BEER.DATA_HARVEY;
   T= _N_ ;
 RUN;

PROC STANDARD DATA=BEER.SAL_SM MEAN=4.555910791  STD=0.15164427 OUT=BEER.SAL_SM;
   VAR PEER ;
RUN;
PROC MEANS DATA=BEER.SAL_SM;
RUN;

 SYMBOL1 INTERPOL=JOIN VALUE='' COLOR=BLUE W=1 L=0.5 ;
 SYMBOL2 LINE=3 I=JOIN ; *INTERPOL=NONE VALUE=*  COLOR=RED W=1.0 ; *L=0.9 ;
 axis1 label=('TRIMESTRE') order=('01MAR2000'd to '01MAR2018'd by year);
 legend1 label=none
        position=(top center inside)
        mode=share;
proc gplot data=stocks;
   plot high*year low*year / overlay legend=legend1
                             vref=1000 to 5000 by 1000
                             lvref=2
                             haxis=axis1 hminor=4
                             vaxis=axis2 vminor=1;
run;
quit;
 PROC GPLOT DATA=BEER.sal_sm ;
   *PLOT PEER*T = 1 ;
   *PLOT PEER*T = 1 Q*T=2 / OVERLAY ; * VREF=0 haxis=axis1   ;
   PLOT PEER*DATE = 1 Q*DATE=2 / OVERLAY haxis=axis1 LEGEND=LEGEND1 ; * VREF=0   ;
 * * PLOT MISALIG*DATE =1 / VREF=0;
 *  PLOT PTOT*DATE = 1 TOT*DATE=2 / OVERLAY haxis=axis1 ; * VREF=0   ;
 *  PLOT PPD*DATE = 1  PD*DATE=2 / OVERLAY haxis=axis1 ; * VREF=0   ;
 *  PLOT PGOV*DATE = 1 GOV*DATE=2 / OVERLAY haxis=axis1 ; * VREF=0   ;

 RUN;
 QUIT;

PROC PRINT DATA=BEER.sal_sm ;
  VAR DATE PEER Q ;
RUN;
  
PROC MEANS DATA=BEER.SAL_SM;
RUN;
