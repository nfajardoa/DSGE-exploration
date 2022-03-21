PROC IMPORT OUT= MIMIC.Nico 
            DATAFILE= "C:\Users\USR_PracticanteGT42\Documents\DSGE_Ferro
ni\Nicolas Fajardo\MIMIC\Datos.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Hoja1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
