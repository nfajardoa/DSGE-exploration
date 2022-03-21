
* ENSAYANDO PROC SSM para estimar modelo estructural como en:
* Chen_MacDonald_2015_Measuring the Dollar Euro Permanent Equilibrium Exchange Rate using the Unobserved Component Model.pdf;
* O J O : se debe ejecutar en "SAS (Ingl�s)" y  NOOO en "SAS (Espa�ol(Castellano))" u otro idioma;

DM "LOG;CLEAR;OUT;clear;ODSRESULTS;CLEAR;PGM";
* MEMSIZE=16147483648; * 2147483648;  *16106127360;

* options macrogen MPRINT MTRACE mautosource symbolgen  LINESIZE=180 NOTES;
options MPRINT NOMTRACE NOmautosource NOsymbolgen  LINESIZE=180 NOTES;

LIBNAME MIMIC "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferroni\Nicolas Fajardo\MIMIC";
*LIBNAME MIMIC "W:\Nicolas Fajardo\MIMIC";


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

*MODELO 1 (DEMANDA DE EFECTIVO);

PROC IML ;

 use MIMIC.DATA;

	read all var{lEFR} into y ;
   	read all var{CONST DTM lATM lIAC VIT DIPC lVAEAM} into X0 ;
   	read all var{lVAEAM_1 TS IC AN LSMR CL lLP U_1 LVCO} into Z0 ; *EXTRAPOL� lVAEAM_1;
									
 close MIMIC.DATA ;

*Valores iniciales;

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

*Ecuaci�n de Medida;

HMat = Theta1 ;
DMat = ( Theta2 || Theta3 || Theta4 || Theta5 || Theta6 || Theta7 || Theta8 ) ;

BMat_t0 = 	DMat*t(X0); * BMat_t0 es 7 X T ;
BMat_t 	=	shape(BMat_t0,Ny*T,1);

*Ecuaci�n de transicion;

FMat = Theta9;
GMat = ( Theta10 || Theta11 || Theta12 || Theta13 || Theta14 || Theta15 || Theta16 || Theta17 || Theta18 ) ;

AMat_t0 =   GMat*t(Z0); * BMat_t0 es 9 X T ;
AMat_t 	=	shape(AMat_t0,Nz*T,1);

*Matriz Errores;

HMat_E = Theta19 ;
QMat_E = Theta20 ;
EMat = block(QMat_E,HMAt_E); * Tama�o es Nz+Ny X Nz+Ny

*Filtro de Kalman;

CALL KALCVF (pred, vpred, filt, vfilt, Y, 0, AMat_t, FMat, BMat_t, HMat, EMat) ; *, var <*>, z0 <*>, vz0 ) ;

print filt[] ;
x = do(1, T,1);
title "Tama�o de econom�a subterr�nea (1976-2003)";
call Series(x, filt) ; *other="refline -2 2 / axis=x" grid={X Y};
quit;
run;

DM "LOG;CLEAR;OUT;clear;ODSRESULTS;CLEAR;PGM";

*MODELO 2 (DEMANDA DE EFECTIVO, TRABAJO INFORMAL, CONSUMO DE ENERGIA);

PROC IML ;

 use MIMIC.DATA;

   	read all var{lEFR CP lWGWh} into y ;
   	read all var{DTM DIPC CL U lVAEAM} into X0 ; *RETRAPOL� U; 
   	read all var{lVAEAM_1 IC AN LSMR U_1 lIAC} into Z0 ; *OJO REEMPLAZ� HC CON lIAC;
									
 close MIMIC.DATA ;

*Valores iniciales;

  T 	=  NROW(Y);
  Ny    =  NCOL(Y);
  Nz    =  NCOL(Z0);

**Medida;

Theta1 = 0.0009;
Theta2 = -0.0001;
Theta3 = 0.0092;

Theta4 = -0.8414;
Theta5 = -1.0374;
Theta6 = 0.8036;
Theta7 = 0.459;
Theta8 = 0.5575;
Theta9 	= 0.5497;

**Transicion;

Theta10 = 0.7873;

Theta11 = -1.8225;
Theta12 = 2.0873;
Theta13 = 1.8953;
Theta14 = 1.6618;
Theta15 = 3.0968;
Theta16 = 1.4821;

**Errores;

Theta17 = 0.004;
Theta18 = 0.0002;
Theta19 = 0.0046;

Theta20 = 9.996;

*Ecuaci�n de Medida;

HMat = 	( Theta1  ) //
        ( Theta2  ) //
        ( Theta3  ) ;
DMat = 	( Theta4   || Theta5 || j(1,2,0) || Theta6 	) //
       	( j(1,2,0) || Theta7 || Theta8   || 0 		) // 
		( j(1,4,0) || Theta9 						) ;

BMat_t0 = 	DMat*t(X0); * BMat_t0 es Nx X T ;
BMat_t 	=	shape(BMat_t0,Ny*T,1);

*Ecuaci�n de transicion;

FMat = Theta10;
GMat = ( Theta11 || Theta12 || Theta13 || Theta14 || Theta15 || Theta16 ) ;

AMat_t0 =   GMat*t(Z0); * BMat_t0 es Nz X T ;
AMat_t 	=	shape(AMat_t0,Nz*T,1);

*Matriz Errores;

HMat_E = diag( Theta17 || Theta18 || Theta19 ) ;
QMat_E = Theta20 ;
EMat = block(QMat_E,HMAt_E); * Tama�o es Nz+Ny X Nz+Ny

*Filtro de Kalman;

CALL KALCVF (pred, vpred, filt, vfilt, Y, 0, AMat_t, FMat, BMat_t, HMat, EMat) ; *, var <*>, z0 <*>, vz0 ) ;

print filt[] ;
x = do(1, T,1);
title "Tama�o de econom�a subterr�nea (1976-2003)";
call Series(x, filt) ; *other="refline -2 2 / axis=x" grid={X Y};
quit;
run;
*/
