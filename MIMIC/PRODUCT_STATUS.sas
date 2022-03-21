
ods html file="D:\users\NRO\DEPE\ESPE\DemandadeDinero\MIMIC\Drilldown.htm" 
 (title="An ODS HTML Using a the product_status Procedure");
options nodate;
PROC PRODUCT_STATUS CORRER ; run;
PROC PRODUCT_STATUS MAKE_MACROS ; run;
ods html close;
ods html;


data one;                                                                                                                                                          
                                                                                                                                                                   
/* If SAS/GRAPH software is currently licensed, then SYSPROD
returns a value of 1.                                                                                
If SAS/GRAPH software is not currently licensed, then SYSPROD
returns a value of 0. */                                                                         
   a=sysprod('graph');                                                                                                                                               
                                                                                                                                                                   
/* SYSPROD returns a value of –1 because ABC is not a valid 
product name. */                                                                                      
   b=sysprod('ets'); 
   put a=;
   put b=;
run; 

proc Registry  listuser;
run;

%put I am using maintenance release: &sysvlong4;
** output:  I am using maintenance release: 9.04.01M0P06192013
;

libname mimic "D:\users\NRO\DEPE\ESPE\DemandadeDinero\MIMIC\";
filename pr "D:\users\NRO\DEPE\ESPE\DemandadeDinero\MIMIC\pregistry.txt";
proc registry export = pr  startat='core\explorer\icons'; run;

proc registry export = pr  startat='ets'; run;

proc registry export = pr  startat='core\explorer\icons'; run;

