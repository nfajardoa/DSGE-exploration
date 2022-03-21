
* ENSAYANDO PROC SSM para estimar modelo estructural como en:
* Chen_MacDonald_2015_Measuring the Dollar Euro Permanent Equilibrium Exchange Rate using the Unobserved Component Model.pdf;
* O J O : se debe ejecutar en "SAS (Inglés)" y  NOOO en "SAS (Español(Castellano))" u otro idioma;

DM "LOG;CLEAR;OUT;clear;ODSRESULTS;CLEAR;PGM";
* MEMSIZE=16147483648; * 2147483648;  *16106127360;

* options macrogen MPRINT MTRACE mautosource symbolgen  LINESIZE=180 NOTES;
options MPRINT NOMTRACE NOmautosource NOsymbolgen  LINESIZE=180 NOTES;

LIBNAME MIMIC "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC";
*LIBNAME MIMIC "W:\Nicolas Fajardo\MIMIC";

/*
PROC IMPORT OUT= MIMIC.DATA 
            DATAFILE= "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC\MIMIC_Datos_ANUAL.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Data$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
*/
DATA MIMIC.DATA;
  SET MIMIC.DATA;
  DROP YEAR;
   YEAR = INTNX( 'year', '1jan76'd, _N_-1 );
    format year year.;
    *LVAEAM_1 = LAG(LVAEAM) ;
RUN;

PROC PRINT DATA =MIMIC.DATA;
RUN;
PROC SORT DATA=MIMIC.DATA;
  BY YEAR;
RUN;
PROC MEANS DATA=MIMIC.DATA;
  VAR YEAR;
RUN;
*/

* vars:  LEFR CP BM TEConsumo TETrabajo TECapital DTF LATM LIAC_ VIT DIPC LVAEAM TS IC AN LSMR CL LLP Lprela Ut_1 LVCO LVAEAM_1 ; 
*MODELO 1 (DEMANDA DE EFECTIVO);
PROC SSM DATA = MIMIC.DATA PLOTS = RESIDUAL;
   ID YEAR INTERVAL = YEAR;
   parms Theta1 ;
   parms Theta9 / lower=(1.e-6) ;
   parms Theta19  / lower=(1.e-7) ;
  array tMat{10,10};
  tMat[1,1] = Theta9  ;
  tMat[1,2] = LVAEAM_1  ;
  tMat[1,3] = TS ;
  tMat[1,4] = IC ;
  tMat[1,5] = AN ;
  tMat[1,6] = LSMR ;
  tMat[1,7] = CL ;
  tMat[1,8] = LLP ;
  tMat[1,9] = U_1 ;
  tMat[1,10] = LVCO ;
  tMat[2,2] = 1 ;   tMat[3,3] = 1 ;  tMat[4,4] = 1 ;  tMat[5,5] = 1 ;  tMat[6,6] = 1 ;  tMat[7,7] = 1 ;  tMat[8,8] = 1 ;  tMat[9,9] = 1 ;  tMat[10,10] = 1 ;
  array QMat{10,10};
  do i=1 to 10;
    do J=1 to 10;
      QMat[I,J] = 0;
    end;
  end;
  QMat[1,1]= Theta19 ;  
  STATE STATE_0(10) T(G)=( tMat ) COV(G)=(QMat) PRINT=(T COV) A1(9);
  IRREGULAR whiteNoise;
  COMPONENT SS = (Theta1)*STATE_0[1] ;
   intercept   = 1 ;
   MODEL lEFR = SS intercept DTM lATM lIAC VIT DIPC lVAEAM whiteNoise;
  *MODEL LEFR = intercept  STATE_0[1] DTF LATM LIAC VIT DIPC LVAEAM randomWalk whiteNoise;
  *MODEL LEFR = CONST DTM lATM lIAC VIT DIPC lVAEAM randomWalk whiteNoise;
   COMPONENT SS2 = STATE_0[2] ;
   COMPONENT SS3 = STATE_0[3] ;
   COMPONENT SS4 = STATE_0[4] ;
   COMPONENT SS5 = STATE_0[5] ;
   COMPONENT SS6 = STATE_0[6] ;
   COMPONENT SS7 = STATE_0[7] ;
   COMPONENT SS8 = STATE_0[8] ;
   COMPONENT SS9 = STATE_0[9] ;
   COMPONENT SS10 = STATE_0[10] ;
    output out=MIMIC.for1 PDV ; * press pdv;
RUN;
QUIT;
 title;
* vars:  LEFR CP BM TEConsumo TETrabajo TECapital DTF LATM LIAC VIT DIPC LVAEAM TS IC AN LSMR CL LLP Lprela Ut_1 LVCO LVAEAM_1 ; 

proc means data=mimic.for1;
 var Smoothed_SS2 Smoothed_SS3 Smoothed_SS4 Smoothed_SS5 Smoothed_SS6 Smoothed_SS7 Smoothed_SS8 Smoothed_SS9 Smoothed_SS10;
 run;


PROC SGPLOT DATA=MIMIC.FOR1;
    title "Economia Subterranea Ajustada con banda al 95% de confianza"; 
    title2 "Modelo 1 variable (Efectivo)";
    band x=YEAR lower=smoothed_lower_SS
       upper=smoothed_upper_SS ;
    series x=YEAR y=smoothed_SS ;
    refline '1jan1976'd / axis=x lineattrs=(pattern=shortdash) ; *    LEGENDLABEL= "Start of Multi-Step Forecasts"
       name="Forecast Reference Line";
  *    scatter x=year y= ;
 run;
QUIT;
run;

 TITLE ;
 TITLE2 ;
  
SYMBOL1 INTERPOL=JOIN VALUE='' COLOR=BLUE W=1 L=0.5 ;
SYMBOL2 INTERPOL=JOIN VALUE=* COLOR=RED W=2.0 L=0.9 ;
axis1 label=('AÑO') order=('01DEC1976'd to '01juL2017'd by year);
legend1 label=none
        position=(top center inside)
        mode=share;
PROC GPLOT DATA= MIMIC.FOR1;
   PLOT LEFR*YEAR=2   Smoothed_LEFR*YEAR=1 /  VREF=0 haxis=axis1  OVERLAY LEGEND=LEGEND1 ;
   PLOT LEFR*YEAR=2   FORECAST_LEFR*YEAR=1 /  VREF=0 haxis=axis1  OVERLAY LEGEND=LEGEND1 ;
RUN;
QUIT;


