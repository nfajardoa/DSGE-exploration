
* ENSAYANDO PROC SSM para estimar modelo estructural como en:
* Chen_MacDonald_2015_Measuring the Dollar Euro Permanent Equilibrium Exchange Rate using the Unobserved Component Model.pdf;
* O J O : se debe ejecutar en "SAS (Inglés)" y  NOOO en "SAS (Español(Castellano))" u otro idioma;

DM "LOG;CLEAR;OUT;clear;ODSRESULTS;CLEAR;PGM";
* MEMSIZE=16147483648; * 2147483648;  *16106127360;
* options macrogen MPRINT MTRACE mautosource symbolgen  LINESIZE=180 NOTES;
options MPRINT NOMTRACE NOmautosource NOsymbolgen  LINESIZE=180 NOTES;
LIBNAME  MIMIC "D:\users\NRO\DEPE\ESPE\DemandadeDinero\MIMIC";
*LIBNAME MIMIC "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC";
*LIBNAME MIMIC "W:\Nicolas Fajardo\MIMIC";

/*
*FILENAME DATA_MIMIC "D:\users\NRO\DEPE\ESPE\DemandadeDinero\MIMIC\MIMIC_Datos_ANUAL.xlsx" ;
*            DATAFILE= "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC\MIMIC_Datos_ANUAL.xlsx" ;
PROC IMPORT OUT= MIMIC.DATA 
            DATAFILE= "D:\users\NRO\DEPE\ESPE\DemandadeDinero\MIMIC\DdaDinero_BaseDatos_17Octubre2018_ANUAL.xlsx" 
     DBMS=EXCEL REPLACE;
     RANGE="DataBase$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
DATA MIMIC.DATA;
  SET MIMIC.DATA;
  DROP A_o;
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

* vars:  LEFR CP BM TEConsumo TETrabajo TECapital DTF LATM LIAC VIT DIPC LVAEAM TS IC AN LSMR CL LLP Lprela Ut_1 LVCO LVAEAM_1 ; 
*MODELO 1 (DEMANDA DE EFECTIVO);
PROC SSM DATA = MIMIC.DATA PLOTS = RESIDUAL;
   ID YEAR INTERVAL = YEAR;
   parms Theta1-Theta2 ;
   parms Theta10 / lower=(1.e-6) ;
   parms Theta20 / lower=(1.e-7) ;
   array tMat{7,7};
     tMat[1,1] = Theta10  ; 
     tMat[1,2] = LVAEAM_1  ;
     tMat[1,3] = IC ;
     tMat[1,4] = AN ;
     tMat[1,5] = LSMR ;
     tMat[1,6] = Ut_1 ;
     tMat[1,7] = LVCO ; **** O J O EN PAPER ES "HC" !!!   ;
     tMat[2,2] = 1 ;      tMat[3,3] = 1 ;     tMat[4,4] = 1 ;     tMat[5,5] = 1 ;     tMat[6,6] = 1 ;     tMat[7,7] = 1 ;
   array QMat{7,7};
     do i=1 to 7;
       do J=1 to 7;
         QMat[I,J] = 0;
       end;
     end;
     QMat[1,1]= Theta20;  
   STATE STATE_0(7) T(G)=( tMat ) COV(G)=(QMat) PRINT=(T COV) A1(6) ;
   IRREGULAR  WN1 ;
   IRREGULAR  WN2 ;
   COMPONENT SS_E  = (Theta1)*STATE_0[1] ;
   COMPONENT SS_CP = (Theta2)*STATE_0[1] ;
   intercept   = 1 ;
   MODEL LEFR = SS_E   DTF DIPC LVAEAM  WN1 ;
   MODEL CP   = SS_CP  CL  Ut_1         WN2 ;
   COMPONENT SS2 = STATE_0[2] ;
   COMPONENT SS3 = STATE_0[3] ;
   COMPONENT SS4 = STATE_0[4] ;
   COMPONENT SS5 = STATE_0[5] ;
   COMPONENT SS6 = STATE_0[6] ;
   COMPONENT SS7 = STATE_0[7] ;
   output out=MIMIC.for1 PDV ; * press pdv;
RUN;
QUIT;
 title;
* vars:  LEFR CP BM TEConsumo TETrabajo TECapital DTF LATM LIAC_ VIT DIPC LVAEAM TS IC AN LSMR CL LLP Lprela Ut_1 LVCO LVAEAM_1 ; 
proc means data=mimic.for1;
 var Smoothed_SS2 Smoothed_SS3 Smoothed_SS4 Smoothed_SS5 Smoothed_SS6 Smoothed_SS7 ; *Smoothed_SS8 Smoothed_SS9 Smoothed_SS10;
 run;



PROC SGPLOT DATA=MIMIC.FOR1;
    title "Economia Subterranea Ajustada con banda al 95% de confianza"; 
    title2 "Modelo 2 variables (Efectivo y Cta Propia)";
    band x=year lower=smoothed_lower_SS
       upper=smoothed_upper_SS ;
    series x=year y=smoothed_SS ;
    refline '1jan1976'd / axis=x lineattrs=(pattern=shortdash) ; *    LEGENDLABEL= "Start of Multi-Step Forecasts"
       name="Forecast Reference Line";
  *    scatter x=year y= ;
 run;
QUIT;
run;  TITLE ;  TITLE2 ;


  
SYMBOL1 INTERPOL=JOIN VALUE='' COLOR=BLUE W=1 L=0.5 ;
SYMBOL2 INTERPOL=JOIN VALUE=* COLOR=RED W=2.0 L=0.9 ;
axis1 label=('AÑO') order=('01DEC1976'd to '01juL2017'd by year);
legend1 label=none
        position=(top center inside)
        mode=share;
PROC GPLOT DATA= MIMIC.FOR1;
   PLOT LEFR*YEAR=2   FORECAST_LEFR*YEAR=1 /  VREF=0 haxis=axis1  OVERLAY LEGEND=LEGEND1 ;
   PLOT CP  *YEAR=2   FORECAST_CP  *YEAR=1 /  VREF=0 haxis=axis1  OVERLAY LEGEND=LEGEND1 ;
   PLOT LEFR*YEAR=2 Smoothed_LEFR*YEAR=1 /  VREF=0 haxis=axis1  OVERLAY LEGEND=LEGEND1 ;
   PLOT CP*YEAR=2 Smoothed_CP*YEAR=1 /  VREF=0 haxis=axis1  OVERLAY LEGEND=LEGEND1 ;
   *WHERE DATE >= '01JAN1984'D;
RUN;
QUIT;
