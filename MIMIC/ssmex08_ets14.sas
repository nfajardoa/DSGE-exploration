
data seatBelt;
input f_KSI r_KSI @@;
label f_KSI = "Front Seat Passengers Injured--log scale";
label r_KSI = "Rear Seat Passengers Injured--log scale";
date = intnx( 'quarter', '1jan1969'd, _n_-1 );
format date YYQS.;
datalines;
    6.72417 5.64654  6.81728 6.06123  6.92382 6.18190
    6.92375 6.07763  6.84975 5.78544  6.81836 6.04644
    7.00942 6.30167  7.09329 6.14476  6.78554 5.78212
    6.86323 6.09520  6.99369 6.29507  6.98344 6.06194
    6.81499 5.81249  6.92997 6.10534  6.96356 6.21298
    7.02296 6.15261  6.76466 5.77967  6.95563 6.18993
    7.02016 6.40524  6.87849 6.06308  6.55966 5.66084
    6.73627 6.02395  6.91553 6.25736  6.83576 6.03535
    6.52075 5.76028  6.59860 5.91208  6.70597 6.08029
    6.75110 5.98833  6.53117 5.67676  6.52718 5.90572
    6.65963 6.01003  6.76869 5.93226  6.44483 5.55616
    6.62063 5.82533  6.72938 6.04531  6.82182 5.98277
    6.64134 5.76540  6.66762 5.91378  6.83524 6.13387
    6.81594 5.97907  6.60761 5.66838  6.62985 5.88151
    6.76963 6.06895  6.79927 6.01991  6.52728 5.69113
    6.60666 5.92841  6.72242 6.03111  6.76228 5.93898
    6.54290 5.72538  6.62469 5.92028  6.73415 6.11880
    6.74094 5.98009  6.46418 5.63517  6.61537 5.96040
    6.76185 6.15613  6.79546 6.04152  6.21529 5.70139
    6.27565 5.92508  6.40771 6.13903  6.37293 5.96883
    6.16445 5.77021  6.31242 6.05267  6.44414 6.15806
    6.53678 6.13404
run;

proc ssm data=seatBelt optimizer(tech=interiorpoint) plots=all;
    ods select
       Ssm.Diagnostics.'Plots for f_KSI'n.ResidualNormalityPlot
       Ssm.Diagnostics.'Plots for f_KSI'n.StdPredErrorPlot
       MaximalShockPlot StateElementBreakSummary;
    id date interval=quarter;
    state error(2) type=WN cov(g);
    component wn1 = error[1];
    component wn2 = error[2];
    state level(2) type=RW cov(rank=1)  checkbreak;
    component rw1 = level[1];
    component rw2 = level[2];
    state season(2) type=season(length=4);
    component s1 = season[1];
    component s2 = season[2];
    model f_KSI = rw1 s1  wn1;
    model r_KSI = rw2 s2 wn2;
 run;

 ods output ElementStateBreakDetails=stateBreak;
 proc ssm data=seatBelt optimizer(tech=interiorpoint) plots=all;
    id date interval=quarter;
    Q1_83_Pulse = (date = '1jan1983'd);
    zero = 0;
    state error(2) type=WN cov(g);
    component wn1 = error[1];
    component wn2 = error[2];
    state level(2) type=RW cov(rank=1) W(g)=(Q1_83_Pulse zero)
        checkbreak print=breakdetail;
    component rw1 = level[1];
    component rw2 = level[2];
    state season(2) type=season(length=4);
    component s1 = season[1];
    component s2 = season[2];
    model f_KSI =  rw1 s1  wn1;
    model r_KSI = rw2 s2 wn2;
 run;

 proc sgpanel data=stateBreak;
     panelby elementIndex;
     scatter x=time y=zValue;
     refline 3 / axis=y lineattrs=(pattern=shortdash) noclip;
     refline -3 / axis=y lineattrs=(pattern=shortdash) noclip;
 run;

* ods output ElementStateBreakDetails=stateBreak;
proc ssm data=seatBelt optimizer(tech=interiorpoint) plots=all;
id date interval=quarter;
Q1_83_Pulse = (date = '1jan1983'd);
zero = 0;
state error(2) type=WN cov(g);
component wn1 = error[1];
component wn2 = error[2];
state level(2) type=RW cov(rank=1) W(g)=(Q1_83_Pulse zero)
checkbreak print=breakdetail;
component rw1 = level[1];
component rw2 = level[2];
state season(2) type=season(length=4);
component s1 = season[1];
component s2 = season[2];
model f_KSI = rw1 s1 wn1;
model r_KSI = rw2 s2 wn2;
run;
* ods close;
