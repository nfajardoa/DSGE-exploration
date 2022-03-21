function [rp, gp, rpp, gpp, hp] = Ferroni_2_params_derivs(y, x, params, steady_state, it_, ss_param_deriv, ss_param_2nd_deriv)
%
% Compute the derivatives of the dynamic model with respect to the parameters
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%   ss_param_deriv     [M_.eq_nbr by #params]     Jacobian matrix of the steady states values with respect to the parameters
%   ss_param_2nd_deriv [M_.eq_nbr by #params by #params] Hessian matrix of the steady states values with respect to the parameters
%
% Outputs:
%   rp        [M_.eq_nbr by #params] double    Jacobian matrix of dynamic model equations with respect to parameters 
%                                              Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   gp        [M_.endo_nbr by #dynamic variables by #params] double    Derivative of the Jacobian matrix of the dynamic model equations with respect to the parameters
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence
%   rpp       [#second_order_residual_terms by 4] double   Hessian matrix of second derivatives of residuals with respect to parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: number of the first parameter in derivative
%                                                              3rd column: number of the second parameter in derivative
%                                                              4th column: value of the Hessian term
%   gpp      [#second_order_Jacobian_terms by 5] double   Hessian matrix of second derivatives of the Jacobian with respect to the parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: column number of variable in Jacobian of the dynamic model
%                                                              3rd column: number of the first parameter in derivative
%                                                              4th column: number of the second parameter in derivative
%                                                              5th column: value of the Hessian term
%   hp      [#first_order_Hessian_terms by 5] double   Jacobian matrix of derivatives of the dynamic Hessian with respect to the parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: column number of first variable in Hessian of the dynamic model
%                                                              3rd column: column number of second variable in Hessian of the dynamic model
%                                                              4th column: number of the parameter in derivative
%                                                              5th column: value of the Hessian term
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

T11 = 1+1/params(4);
T12 = y(9)^T11;
T29 = params(2)*y(7)/y(15)*exp((-y(16))-y(17));
T36 = params(1)*y(14)/y(8)*exp(y(16)+y(17));
T39 = T36+1-params(3);
T43 = y(2)^params(1);
T44 = y(9)^(1-params(1));
T51 = exp((-params(1))*(y(10)+y(11)));
T99 = exp(y(16)+y(17))*params(1)*1/y(8);
T107 = exp((-y(16))-y(17))*params(2)*1/y(15);
T113 = exp((-y(16))-y(17))*params(2)*(-y(7))/(y(15)*y(15));
T115 = getPowerDeriv(y(2),params(1),1);
T125 = exp(y(16)+y(17))*params(1)*(-y(14))/(y(8)*y(8));
T133 = getPowerDeriv(y(9),1-params(1),1);
T149 = params(2)*y(7)/y(15)*(-exp((-y(16))-y(17)));
T178 = exp((-y(16))-y(17))*params(2)*(-((-y(7))*(y(15)+y(15))))/(y(15)*y(15)*y(15)*y(15));
T210 = getPowerDeriv(y(2),params(1),2);
T217 = getPowerDeriv(y(9),1-params(1),2);
T250 = y(14)/y(8)*exp(y(16)+y(17));
T259 = T44*T43*log(y(2))+T43*T44*(-log(y(9)));
T261 = T51*(-(y(10)+y(11)));
T273 = T43*log(y(2))*T44*(-log(y(9)))+T44*log(y(2))*T43*log(y(2))+T43*log(y(2))*T44*(-log(y(9)))+T43*(-log(y(9)))*T44*(-log(y(9)));
T274 = T259*T261;
T284 = exp(y(16)+y(17))*1/y(8);
T288 = exp(y(16)+y(17))*(-y(14))/(y(8)*y(8));
T291 = T29*T250+T149*T250;
T293 = y(2)^(params(1)-1);
T299 = T115*T44*(-log(y(9)))+T44*(T293+params(1)*log(y(2))*T293);
T305 = y(9)^(1-params(1)-1);
T312 = T133*T43*log(y(2))+T43*((1-params(1))*(-log(y(9)))*T305-T305);
T323 = (-((-params(1))*T51*T259+T43*T44*((-T51)+(-params(1))*T261)));
T369 = (-(T259*((-T51)+(-params(1))*T261)+(-params(1))*T51*T273+T259*((-T51)+(-params(1))*T261)+T43*T44*((-T261)+(-T261)+(-params(1))*(-(y(10)+y(11)))*T261)));
T385 = T107*T250+params(2)*1/y(15)*(-exp((-y(16))-y(17)))*T250;
T387 = T113*T250+params(2)*(-y(7))/(y(15)*y(15))*(-exp((-y(16))-y(17)))*T250;
T392 = y(2)^(params(1)-2);
T414 = y(9)^(1-params(1)-2);
T443 = (-((-params(1))*(-params(1))*T51*T259+T43*T44*((-((-params(1))*T51))+(-params(1))*((-T51)+(-params(1))*T261))));
T444 = y(7)/y(15)*exp((-y(16))-y(17));
T448 = exp((-y(16))-y(17))*1/y(15);
T450 = exp((-y(16))-y(17))*(-y(7))/(y(15)*y(15));
T453 = y(7)/y(15)*(-exp((-y(16))-y(17)));
T456 = T39*T453+T36*T444;
T482 = T39*(-y(7))/(y(15)*y(15))*(-exp((-y(16))-y(17)))+T36*T450;
T506 = (-1)/(params(4)*params(4));
T507 = log(y(9))*T506;
T508 = T12*T507;
T518 = y(9)^(T11-1);
T533 = y(9)^(T11-2);
rp = zeros(8, 6);
rp(1, 1) = y(6)/y(7);
rp(1, 4) = T508;
rp(2, 1) = T29*T250;
rp(2, 2) = T39*T444;
rp(2, 3) = (-T29);
rp(3, 1) = (-(T51*T259+T43*T44*T261));
rp(4, 3) = exp((-y(10))-y(11))*(-y(2));
rp(5, 5) = (-y(4));
rp(6, 6) = (-y(5));
gp = zeros(8, 19, 6);
gp(1, 6, 1) = 1/y(7);
gp(1, 7, 1) = (-y(6))/(y(7)*y(7));
gp(1, 9, 4) = T11*T507*T518+T506*T518;
gp(2, 14, 1) = T29*T284;
gp(2, 14, 2) = T99*T444;
gp(2, 7, 1) = T107*T250;
gp(2, 7, 2) = T39*T448;
gp(2, 7, 3) = (-T107);
gp(2, 15, 1) = T113*T250;
gp(2, 15, 2) = T39*T450;
gp(2, 15, 3) = (-T113);
gp(2, 8, 1) = T29*T288;
gp(2, 8, 2) = T125*T444;
gp(2, 16, 1) = T291;
gp(2, 16, 2) = T456;
gp(2, 16, 3) = (-T149);
gp(2, 17, 1) = T291;
gp(2, 17, 2) = T456;
gp(2, 17, 3) = (-T149);
gp(3, 2, 1) = (-(T44*T115*T261+T51*T299));
gp(3, 9, 1) = (-(T43*T133*T261+T51*T312));
gp(3, 10, 1) = T323;
gp(3, 11, 1) = T323;
gp(4, 2, 3) = (-exp((-y(10))-y(11)));
gp(4, 10, 3) = (-exp((-y(10))-y(11)))*(-y(2));
gp(4, 11, 3) = (-exp((-y(10))-y(11)))*(-y(2));
gp(5, 4, 5) = (-1);
gp(6, 5, 6) = (-1);
if nargout >= 3
rpp = zeros(4,4);
rpp(1,1)=1;
rpp(1,2)=4;
rpp(1,3)=4;
rpp(1,4)=T507*T508+T12*log(y(9))*(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4));
rpp(2,1)=2;
rpp(2,2)=1;
rpp(2,3)=2;
rpp(2,4)=T250*T444;
rpp(3,1)=2;
rpp(3,2)=2;
rpp(3,3)=3;
rpp(3,4)=(-T444);
rpp(4,1)=3;
rpp(4,2)=1;
rpp(4,3)=1;
rpp(4,4)=(-(T274+T51*T273+T274+T43*T44*(-(y(10)+y(11)))*T261));
gpp = zeros(15,5);
gpp(1,1)=1;
gpp(1,2)=9;
gpp(1,3)=4;
gpp(1,4)=4;
gpp(1,5)=T506*T507*T518+T11*(log(y(9))*(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4))*T518+T507*T507*T518)+T506*T507*T518+(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4))*T518;
gpp(2,1)=2;
gpp(2,2)=14;
gpp(2,3)=1;
gpp(2,4)=2;
gpp(2,5)=T284*T444;
gpp(3,1)=2;
gpp(3,2)=7;
gpp(3,3)=1;
gpp(3,4)=2;
gpp(3,5)=T250*T448;
gpp(4,1)=2;
gpp(4,2)=7;
gpp(4,3)=2;
gpp(4,4)=3;
gpp(4,5)=(-T448);
gpp(5,1)=2;
gpp(5,2)=15;
gpp(5,3)=1;
gpp(5,4)=2;
gpp(5,5)=T250*T450;
gpp(6,1)=2;
gpp(6,2)=15;
gpp(6,3)=2;
gpp(6,4)=3;
gpp(6,5)=(-T450);
gpp(7,1)=2;
gpp(7,2)=8;
gpp(7,3)=1;
gpp(7,4)=2;
gpp(7,5)=T288*T444;
gpp(8,1)=2;
gpp(8,2)=16;
gpp(8,3)=1;
gpp(8,4)=2;
gpp(8,5)=T250*T444+T250*T453;
gpp(9,1)=2;
gpp(9,2)=16;
gpp(9,3)=2;
gpp(9,4)=3;
gpp(9,5)=(-T453);
gpp(10,1)=2;
gpp(10,2)=17;
gpp(10,3)=1;
gpp(10,4)=2;
gpp(10,5)=T250*T444+T250*T453;
gpp(11,1)=2;
gpp(11,2)=17;
gpp(11,3)=2;
gpp(11,4)=3;
gpp(11,5)=(-T453);
gpp(12,1)=3;
gpp(12,2)=2;
gpp(12,3)=1;
gpp(12,4)=1;
gpp(12,5)=(-(T261*T299+T44*T115*(-(y(10)+y(11)))*T261+T261*T299+T51*(T44*(-log(y(9)))*(T293+params(1)*log(y(2))*T293)+T115*(-log(y(9)))*T44*(-log(y(9)))+T44*(-log(y(9)))*(T293+params(1)*log(y(2))*T293)+T44*(log(y(2))*T293+log(y(2))*T293+params(1)*log(y(2))*log(y(2))*T293))));
gpp(13,1)=3;
gpp(13,2)=9;
gpp(13,3)=1;
gpp(13,4)=1;
gpp(13,5)=(-(T261*T312+T43*T133*(-(y(10)+y(11)))*T261+T261*T312+T51*(T43*log(y(2))*((1-params(1))*(-log(y(9)))*T305-T305)+T133*log(y(2))*T43*log(y(2))+T43*log(y(2))*((1-params(1))*(-log(y(9)))*T305-T305)+T43*((-((-log(y(9)))*T305))+(1-params(1))*(-log(y(9)))*(-log(y(9)))*T305-(-log(y(9)))*T305))));
gpp(14,1)=3;
gpp(14,2)=10;
gpp(14,3)=1;
gpp(14,4)=1;
gpp(14,5)=T369;
gpp(15,1)=3;
gpp(15,2)=11;
gpp(15,3)=1;
gpp(15,4)=1;
gpp(15,5)=T369;
end
if nargout >= 5
hp = zeros(65,5);
hp(1,1)=1;
hp(1,2)=7;
hp(1,3)=6;
hp(1,4)=1;
hp(1,5)=(-1)/(y(7)*y(7));
hp(2,1)=1;
hp(2,2)=7;
hp(2,3)=7;
hp(2,4)=1;
hp(2,5)=(-((-y(6))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7));
hp(3,1)=1;
hp(3,2)=9;
hp(3,3)=9;
hp(3,4)=4;
hp(3,5)=(T11-1)*T11*T507*T533+T533*T506*(T11+T11-1);
hp(4,1)=2;
hp(4,2)=7;
hp(4,3)=14;
hp(4,4)=1;
hp(4,5)=T107*T284;
hp(5,1)=2;
hp(5,2)=7;
hp(5,3)=14;
hp(5,4)=2;
hp(5,5)=T99*T448;
hp(6,1)=2;
hp(6,2)=15;
hp(6,3)=14;
hp(6,4)=1;
hp(6,5)=T113*T284;
hp(7,1)=2;
hp(7,2)=15;
hp(7,3)=14;
hp(7,4)=2;
hp(7,5)=T99*T450;
hp(8,1)=2;
hp(8,2)=15;
hp(8,3)=7;
hp(8,4)=1;
hp(8,5)=exp((-y(16))-y(17))*params(2)*(-1)/(y(15)*y(15))*T250;
hp(9,1)=2;
hp(9,2)=15;
hp(9,3)=7;
hp(9,4)=2;
hp(9,5)=T39*exp((-y(16))-y(17))*(-1)/(y(15)*y(15));
hp(10,1)=2;
hp(10,2)=15;
hp(10,3)=7;
hp(10,4)=3;
hp(10,5)=(-(exp((-y(16))-y(17))*params(2)*(-1)/(y(15)*y(15))));
hp(11,1)=2;
hp(11,2)=15;
hp(11,3)=15;
hp(11,4)=1;
hp(11,5)=T178*T250;
hp(12,1)=2;
hp(12,2)=15;
hp(12,3)=15;
hp(12,4)=2;
hp(12,5)=T39*exp((-y(16))-y(17))*(-((-y(7))*(y(15)+y(15))))/(y(15)*y(15)*y(15)*y(15));
hp(13,1)=2;
hp(13,2)=15;
hp(13,3)=15;
hp(13,4)=3;
hp(13,5)=(-T178);
hp(14,1)=2;
hp(14,2)=8;
hp(14,3)=14;
hp(14,4)=1;
hp(14,5)=T29*exp(y(16)+y(17))*(-1)/(y(8)*y(8));
hp(15,1)=2;
hp(15,2)=8;
hp(15,3)=14;
hp(15,4)=2;
hp(15,5)=exp(y(16)+y(17))*params(1)*(-1)/(y(8)*y(8))*T444;
hp(16,1)=2;
hp(16,2)=8;
hp(16,3)=7;
hp(16,4)=1;
hp(16,5)=T107*T288;
hp(17,1)=2;
hp(17,2)=8;
hp(17,3)=7;
hp(17,4)=2;
hp(17,5)=T125*T448;
hp(18,1)=2;
hp(18,2)=8;
hp(18,3)=15;
hp(18,4)=1;
hp(18,5)=T113*T288;
hp(19,1)=2;
hp(19,2)=8;
hp(19,3)=15;
hp(19,4)=2;
hp(19,5)=T125*T450;
hp(20,1)=2;
hp(20,2)=8;
hp(20,3)=8;
hp(20,4)=1;
hp(20,5)=T29*exp(y(16)+y(17))*(-((-y(14))*(y(8)+y(8))))/(y(8)*y(8)*y(8)*y(8));
hp(21,1)=2;
hp(21,2)=8;
hp(21,3)=8;
hp(21,4)=2;
hp(21,5)=exp(y(16)+y(17))*params(1)*(-((-y(14))*(y(8)+y(8))))/(y(8)*y(8)*y(8)*y(8))*T444;
hp(22,1)=2;
hp(22,2)=16;
hp(22,3)=14;
hp(22,4)=1;
hp(22,5)=T29*T284+T149*T284;
hp(23,1)=2;
hp(23,2)=16;
hp(23,3)=14;
hp(23,4)=2;
hp(23,5)=T99*T444+T99*T453;
hp(24,1)=2;
hp(24,2)=16;
hp(24,3)=7;
hp(24,4)=1;
hp(24,5)=T385;
hp(25,1)=2;
hp(25,2)=16;
hp(25,3)=7;
hp(25,4)=2;
hp(25,5)=T39*1/y(15)*(-exp((-y(16))-y(17)))+T36*T448;
hp(26,1)=2;
hp(26,2)=16;
hp(26,3)=7;
hp(26,4)=3;
hp(26,5)=(-(params(2)*1/y(15)*(-exp((-y(16))-y(17)))));
hp(27,1)=2;
hp(27,2)=16;
hp(27,3)=15;
hp(27,4)=1;
hp(27,5)=T387;
hp(28,1)=2;
hp(28,2)=16;
hp(28,3)=15;
hp(28,4)=2;
hp(28,5)=T482;
hp(29,1)=2;
hp(29,2)=16;
hp(29,3)=15;
hp(29,4)=3;
hp(29,5)=(-(params(2)*(-y(7))/(y(15)*y(15))*(-exp((-y(16))-y(17)))));
hp(30,1)=2;
hp(30,2)=16;
hp(30,3)=8;
hp(30,4)=1;
hp(30,5)=T29*T288+T149*T288;
hp(31,1)=2;
hp(31,2)=16;
hp(31,3)=8;
hp(31,4)=2;
hp(31,5)=T125*T444+T125*T453;
hp(32,1)=2;
hp(32,2)=16;
hp(32,3)=16;
hp(32,4)=1;
hp(32,5)=T291+T291;
hp(33,1)=2;
hp(33,2)=16;
hp(33,3)=16;
hp(33,4)=2;
hp(33,5)=T39*T444+T36*T453+T36*T444+T36*T453;
hp(34,1)=2;
hp(34,2)=16;
hp(34,3)=16;
hp(34,4)=3;
hp(34,5)=(-T29);
hp(35,1)=2;
hp(35,2)=17;
hp(35,3)=14;
hp(35,4)=1;
hp(35,5)=T29*T284+T149*T284;
hp(36,1)=2;
hp(36,2)=17;
hp(36,3)=14;
hp(36,4)=2;
hp(36,5)=T99*T444+T99*T453;
hp(37,1)=2;
hp(37,2)=17;
hp(37,3)=7;
hp(37,4)=1;
hp(37,5)=T385;
hp(38,1)=2;
hp(38,2)=17;
hp(38,3)=7;
hp(38,4)=2;
hp(38,5)=T39*1/y(15)*(-exp((-y(16))-y(17)))+T36*T448;
hp(39,1)=2;
hp(39,2)=17;
hp(39,3)=7;
hp(39,4)=3;
hp(39,5)=(-(params(2)*1/y(15)*(-exp((-y(16))-y(17)))));
hp(40,1)=2;
hp(40,2)=17;
hp(40,3)=15;
hp(40,4)=1;
hp(40,5)=T387;
hp(41,1)=2;
hp(41,2)=17;
hp(41,3)=15;
hp(41,4)=2;
hp(41,5)=T482;
hp(42,1)=2;
hp(42,2)=17;
hp(42,3)=15;
hp(42,4)=3;
hp(42,5)=(-(params(2)*(-y(7))/(y(15)*y(15))*(-exp((-y(16))-y(17)))));
hp(43,1)=2;
hp(43,2)=17;
hp(43,3)=8;
hp(43,4)=1;
hp(43,5)=T29*T288+T149*T288;
hp(44,1)=2;
hp(44,2)=17;
hp(44,3)=8;
hp(44,4)=2;
hp(44,5)=T125*T444+T125*T453;
hp(45,1)=2;
hp(45,2)=17;
hp(45,3)=16;
hp(45,4)=1;
hp(45,5)=T291+T291;
hp(46,1)=2;
hp(46,2)=17;
hp(46,3)=16;
hp(46,4)=2;
hp(46,5)=T39*T444+T36*T453+T36*T444+T36*T453;
hp(47,1)=2;
hp(47,2)=17;
hp(47,3)=16;
hp(47,4)=3;
hp(47,5)=(-T29);
hp(48,1)=2;
hp(48,2)=17;
hp(48,3)=17;
hp(48,4)=1;
hp(48,5)=T291+T291;
hp(49,1)=2;
hp(49,2)=17;
hp(49,3)=17;
hp(49,4)=2;
hp(49,5)=T39*T444+T36*T453+T36*T444+T36*T453;
hp(50,1)=2;
hp(50,2)=17;
hp(50,3)=17;
hp(50,4)=3;
hp(50,5)=(-T29);
hp(51,1)=3;
hp(51,2)=2;
hp(51,3)=2;
hp(51,4)=1;
hp(51,5)=(-(T44*T210*T261+T51*(T210*T44*(-log(y(9)))+T44*((params(1)-1)*params(1)*log(y(2))*T392+T392*(params(1)+params(1)-1)))));
hp(52,1)=3;
hp(52,2)=9;
hp(52,3)=2;
hp(52,4)=1;
hp(52,5)=(-(T115*T133*T261+T51*(T133*(T293+params(1)*log(y(2))*T293)+T115*((1-params(1))*(-log(y(9)))*T305-T305))));
hp(53,1)=3;
hp(53,2)=9;
hp(53,3)=9;
hp(53,4)=1;
hp(53,5)=(-(T43*T217*T261+T51*(T217*T43*log(y(2))+T43*((1-params(1)-1)*(1-params(1))*(-log(y(9)))*T414+T414*(-(1-params(1)+1-params(1)-1))))));
hp(54,1)=3;
hp(54,2)=10;
hp(54,3)=2;
hp(54,4)=1;
hp(54,5)=(-((-params(1))*T51*T299+T44*T115*((-T51)+(-params(1))*T261)));
hp(55,1)=3;
hp(55,2)=10;
hp(55,3)=9;
hp(55,4)=1;
hp(55,5)=(-((-params(1))*T51*T312+T43*T133*((-T51)+(-params(1))*T261)));
hp(56,1)=3;
hp(56,2)=10;
hp(56,3)=10;
hp(56,4)=1;
hp(56,5)=T443;
hp(57,1)=3;
hp(57,2)=11;
hp(57,3)=2;
hp(57,4)=1;
hp(57,5)=(-((-params(1))*T51*T299+T44*T115*((-T51)+(-params(1))*T261)));
hp(58,1)=3;
hp(58,2)=11;
hp(58,3)=9;
hp(58,4)=1;
hp(58,5)=(-((-params(1))*T51*T312+T43*T133*((-T51)+(-params(1))*T261)));
hp(59,1)=3;
hp(59,2)=11;
hp(59,3)=10;
hp(59,4)=1;
hp(59,5)=T443;
hp(60,1)=3;
hp(60,2)=11;
hp(60,3)=11;
hp(60,4)=1;
hp(60,5)=T443;
hp(61,1)=4;
hp(61,2)=10;
hp(61,3)=2;
hp(61,4)=3;
hp(61,5)=exp((-y(10))-y(11));
hp(62,1)=4;
hp(62,2)=10;
hp(62,3)=10;
hp(62,4)=3;
hp(62,5)=exp((-y(10))-y(11))*(-y(2));
hp(63,1)=4;
hp(63,2)=11;
hp(63,3)=2;
hp(63,4)=3;
hp(63,5)=exp((-y(10))-y(11));
hp(64,1)=4;
hp(64,2)=11;
hp(64,3)=10;
hp(64,4)=3;
hp(64,5)=exp((-y(10))-y(11))*(-y(2));
hp(65,1)=4;
hp(65,2)=11;
hp(65,3)=11;
hp(65,4)=3;
hp(65,5)=exp((-y(10))-y(11))*(-y(2));
end
end
