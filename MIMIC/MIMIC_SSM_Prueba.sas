
* ENSAYANDO PROC SSM para estimar modelo estructural como en:
* Chen_MacDonald_2015_Measuring the Dollar Euro Permanent Equilibrium Exchange Rate using the Unobserved Component Model.pdf;
* O J O : se debe ejecutar en "SAS (Inglés)" y  NOOO en "SAS (Español(Castellano))" u otro idioma;

DM "LOG;CLEAR;OUT;clear;ODSRESULTS;CLEAR;PGM";
* MEMSIZE=16147483648; * 2147483648;  *16106127360;

* options macrogen MPRINT MTRACE mautosource symbolgen  LINESIZE=180 NOTES;
options MPRINT NOMTRACE NOmautosource NOsymbolgen  LINESIZE=180 NOTES;

LIBNAME MIMIC "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC";
*LIBNAME MIMIC "W:\Nicolas Fajardo\MIMIC";


PROC IMPORT OUT= MIMIC.DATA 
            DATAFILE= "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC\DdaDinero_BaseDatos_16Octubre2018_ANUAL.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Data$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

*MODELO 1 (DEMANDA DE EFECTIVO);

PROC SSM ;

DATA = MIMIC.DATA;
PLOTS = RESIDUAL;
*ID AÑO INTERVAL = YEAR;

  T 	=  NROW(Y);
  Ny    =  NCOL(Y);
  Nz    =  NCOL(Z0);

**Medida;

Theta1 = 0.0198;

Theta2 = 0.9054;
Theta3 = -0.6385;
Theta4 = -0.0059;
Theta5 = -0.2948;
Theta6 = 2.7041;
Theta7 = -0.5969;
Theta8 = 0.8178;

**Transicion;

Theta9 	= 0.2436;

Theta10 = 1.2385;
Theta11 = 2.4723;
Theta12 = 2.7904;
Theta13 = 3.1974;
Theta14 = 1.5874;
Theta15 = 2.2775;
Theta16 = -3.6644;
Theta17 = 1.0935;
Theta18 = 1.4223;

**Errores;

Theta19 = 0.0011;
Theta20 = 2.6458;

*parms lambda / lower=(1.e-6) upper=(3.14);
*parms cycleVar / lower=(1.e-6);

COMPONENT C = (1 DTM lATM lIAC VIT DIPC lVAEAM) * STATE_0 ;
STATE STATE_0(9) T(D)=(lVAEAM_1 TS IC AN LSMR CL lLP U_1 LVCO) COV1(RANK=1);
TREND randomWalk(rw);
IRREGULAR whiteNoise;

MODEL lEFR = CONST DTM lATM lIAC VIT DIPC lVAEAM randomWalk whiteNoise;




