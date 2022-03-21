function [rp, gp, rpp, gpp, hp] = Ferroni_3_static_params_derivs(y, x, params)
%
% Status : Computes derivatives of the static model with respect to the parameters
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   rp        [M_.eq_nbr by #params] double    Jacobian matrix of static model equations with respect to parameters 
%                                              Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   gp        [M_.endo_nbr by M_.endo_nbr by #params] double    Derivative of the Jacobian matrix of the static model equations with respect to the parameters
%                                                           rows: variables in declaration order
%                                                           rows: equations in order of declaration
%   rpp       [#second_order_residual_terms by 4] double   Hessian matrix of second derivatives of residuals with respect to parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: number of the first parameter in derivative
%                                                              3rd column: number of the second parameter in derivative
%                                                              4th column: value of the Hessian term
%   gpp      [#second_order_Jacobian_terms by 5] double   Hessian matrix of second derivatives of the Jacobian with respect to the parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: column number of variable in Jacobian of the static model
%                                                              3rd column: number of the first parameter in derivative
%                                                              4th column: number of the second parameter in derivative
%                                                              5th column: value of the Hessian term
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

T11 = y(4)/exp(y(6));
T14 = 1+1/params(4);
T15 = T11^T14;
T32 = params(1)*y(1)/y(3)*exp(y(5));
T38 = y(3)^params(1);
T39 = y(4)^(1-params(1));
T43 = exp(y(5)*(-params(1)));
T80 = getPowerDeriv(y(3),params(1),1);
T87 = 1/exp(y(6));
T90 = getPowerDeriv(y(4),1-params(1),1);
T109 = (-(y(4)*exp(y(6))))/(exp(y(6))*exp(y(6)));
T160 = getPowerDeriv(y(3),params(1),2);
T167 = getPowerDeriv(y(4),1-params(1),2);
T180 = y(1)/y(3)*exp(y(5));
T189 = T39*T38*log(y(3))+T38*T39*(-log(y(4)));
T190 = (-y(5))*T43;
T202 = T38*log(y(3))*T39*(-log(y(4)))+T39*log(y(3))*T38*log(y(3))+T38*log(y(3))*T39*(-log(y(4)))+T38*(-log(y(4)))*T39*(-log(y(4)));
T213 = exp(y(5))*1/y(3);
T215 = exp(y(5))*(-y(1))/(y(3)*y(3));
T216 = params(2)*exp((-y(5)))*T215;
T220 = y(3)^(params(1)-1);
T226 = T80*T39*(-log(y(4)))+T39*(T220+params(1)*log(y(3))*T220);
T232 = y(4)^(1-params(1)-1);
T239 = T90*T38*log(y(3))+T38*((1-params(1))*(-log(y(4)))*T232-T232);
T251 = T190*T226;
T309 = y(3)^(params(1)-2);
T331 = y(4)^(1-params(1)-2);
T361 = exp((-y(5)))*(T32+1-params(3));
T364 = exp((-y(5)))*exp(y(5))*params(1)*(-y(1))/(y(3)*y(3));
T389 = (-1)/(params(4)*params(4));
T391 = T389*log(T11);
T392 = T15*T391;
T397 = log(T11)*(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4));
T402 = T11^(T14-1);
T406 = T14*T391*T402+T389*T402;
T417 = T389*T391*T402+T14*(T397*T402+T391*T391*T402)+T389*T391*T402+(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4))*T402;
T421 = T11^(T14-2);
rp = zeros(7, 6);
rp(1, 1) = y(1)/y(2);
rp(1, 4) = T392;
rp(2, 1) = params(2)*exp((-y(5)))*T180;
rp(2, 2) = T361;
rp(2, 3) = (-(params(2)*exp((-y(5)))));
rp(3, 1) = (-(T43*T189+T38*T39*T190));
rp(4, 3) = exp((-y(5)))*(-y(3));
rp(5, 5) = (-y(5));
rp(6, 6) = (-y(6));
gp = zeros(7, 7, 6);
gp(1, 1, 1) = 1/y(2);
gp(1, 2, 1) = (-y(1))/(y(2)*y(2));
gp(1, 4, 4) = T87*T406;
gp(1, 6, 4) = T109*T406;
gp(2, 1, 1) = params(2)*exp((-y(5)))*T213;
gp(2, 1, 2) = exp((-y(5)))*exp(y(5))*params(1)*1/y(3);
gp(2, 3, 1) = T216;
gp(2, 3, 2) = T364;
gp(2, 5, 1) = params(2)*exp((-y(5)))*T180+params(2)*(-exp((-y(5))))*T180;
gp(2, 5, 2) = (T32+1-params(3))*(-exp((-y(5))))+exp((-y(5)))*T32;
gp(2, 5, 3) = (-(params(2)*(-exp((-y(5))))));
gp(3, 3, 1) = (-(T39*T80*T190+T43*T226));
gp(3, 4, 1) = (-(T38*T90*T190+T43*T239));
gp(3, 5, 1) = (-((-params(1))*T43*T189+T38*T39*((-T43)+(-params(1))*T190)));
gp(4, 3, 3) = (-exp((-y(5))));
gp(4, 5, 3) = (-exp((-y(5))))*(-y(3));
gp(5, 5, 5) = (-1);
gp(6, 6, 6) = (-1);
if nargout >= 3
rpp = zeros(4,4);
rpp(1,1)=1;
rpp(1,2)=4;
rpp(1,3)=4;
rpp(1,4)=T391*T392+T15*T397;
rpp(2,1)=2;
rpp(2,2)=1;
rpp(2,3)=2;
rpp(2,4)=exp((-y(5)))*T180;
rpp(3,1)=2;
rpp(3,2)=2;
rpp(3,3)=3;
rpp(3,4)=(-exp((-y(5))));
rpp(4,1)=3;
rpp(4,2)=1;
rpp(4,3)=1;
rpp(4,4)=(-(T189*T190+T43*T202+T189*T190+T38*T39*(-y(5))*T190));
gpp = zeros(9,5);
gpp(1,1)=1;
gpp(1,2)=4;
gpp(1,3)=4;
gpp(1,4)=4;
gpp(1,5)=T87*T417;
gpp(2,1)=1;
gpp(2,2)=6;
gpp(2,3)=4;
gpp(2,4)=4;
gpp(2,5)=T109*T417;
gpp(3,1)=2;
gpp(3,2)=1;
gpp(3,3)=1;
gpp(3,4)=2;
gpp(3,5)=exp((-y(5)))*T213;
gpp(4,1)=2;
gpp(4,2)=3;
gpp(4,3)=1;
gpp(4,4)=2;
gpp(4,5)=exp((-y(5)))*T215;
gpp(5,1)=2;
gpp(5,2)=5;
gpp(5,3)=1;
gpp(5,4)=2;
gpp(5,5)=exp((-y(5)))*T180+(-exp((-y(5))))*T180;
gpp(6,1)=2;
gpp(6,2)=5;
gpp(6,3)=2;
gpp(6,4)=3;
gpp(6,5)=exp((-y(5)));
gpp(7,1)=3;
gpp(7,2)=3;
gpp(7,3)=1;
gpp(7,4)=1;
gpp(7,5)=(-(T251+T39*T80*(-y(5))*T190+T251+T43*(T39*(-log(y(4)))*(T220+params(1)*log(y(3))*T220)+T80*(-log(y(4)))*T39*(-log(y(4)))+T39*(-log(y(4)))*(T220+params(1)*log(y(3))*T220)+T39*(log(y(3))*T220+log(y(3))*T220+params(1)*log(y(3))*log(y(3))*T220))));
gpp(8,1)=3;
gpp(8,2)=4;
gpp(8,3)=1;
gpp(8,4)=1;
gpp(8,5)=(-(T190*T239+T38*T90*(-y(5))*T190+T190*T239+T43*(T38*log(y(3))*((1-params(1))*(-log(y(4)))*T232-T232)+T90*log(y(3))*T38*log(y(3))+T38*log(y(3))*((1-params(1))*(-log(y(4)))*T232-T232)+T38*((-((-log(y(4)))*T232))+(1-params(1))*(-log(y(4)))*(-log(y(4)))*T232-(-log(y(4)))*T232))));
gpp(9,1)=3;
gpp(9,2)=5;
gpp(9,3)=1;
gpp(9,4)=1;
gpp(9,5)=(-(T189*((-T43)+(-params(1))*T190)+(-params(1))*T43*T202+T189*((-T43)+(-params(1))*T190)+T38*T39*((-T190)+(-T190)+(-params(1))*(-y(5))*T190)));
end
if nargout >= 5
hp = zeros(24,5);
hp(1,1)=1;
hp(1,2)=2;
hp(1,3)=1;
hp(1,4)=1;
hp(1,5)=(-1)/(y(2)*y(2));
hp(2,1)=1;
hp(2,2)=2;
hp(2,3)=2;
hp(2,4)=1;
hp(2,5)=(-((-y(1))*(y(2)+y(2))))/(y(2)*y(2)*y(2)*y(2));
hp(3,1)=1;
hp(3,2)=4;
hp(3,3)=4;
hp(3,4)=4;
hp(3,5)=T87*T87*((T14-1)*T14*T391*T421+T421*T389*(T14+T14-1));
hp(4,1)=1;
hp(4,2)=6;
hp(4,3)=4;
hp(4,4)=4;
hp(4,5)=T109*T87*((T14-1)*T14*T391*T421+T421*T389*(T14+T14-1))+(-exp(y(6)))/(exp(y(6))*exp(y(6)))*T406;
hp(5,1)=1;
hp(5,2)=6;
hp(5,3)=6;
hp(5,4)=4;
hp(5,5)=T109*T109*((T14-1)*T14*T391*T421+T421*T389*(T14+T14-1))+((-(y(4)*exp(y(6))))*exp(y(6))*exp(y(6))-(-(y(4)*exp(y(6))))*(exp(y(6))*exp(y(6))+exp(y(6))*exp(y(6))))/(exp(y(6))*exp(y(6))*exp(y(6))*exp(y(6)))*T406;
hp(6,1)=2;
hp(6,2)=3;
hp(6,3)=1;
hp(6,4)=1;
hp(6,5)=params(2)*exp((-y(5)))*exp(y(5))*(-1)/(y(3)*y(3));
hp(7,1)=2;
hp(7,2)=3;
hp(7,3)=1;
hp(7,4)=2;
hp(7,5)=exp((-y(5)))*exp(y(5))*params(1)*(-1)/(y(3)*y(3));
hp(8,1)=2;
hp(8,2)=3;
hp(8,3)=3;
hp(8,4)=1;
hp(8,5)=params(2)*exp((-y(5)))*exp(y(5))*(-((-y(1))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3));
hp(9,1)=2;
hp(9,2)=3;
hp(9,3)=3;
hp(9,4)=2;
hp(9,5)=exp((-y(5)))*exp(y(5))*params(1)*(-((-y(1))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3));
hp(10,1)=2;
hp(10,2)=5;
hp(10,3)=1;
hp(10,4)=1;
hp(10,5)=params(2)*exp((-y(5)))*T213+params(2)*(-exp((-y(5))))*T213;
hp(11,1)=2;
hp(11,2)=5;
hp(11,3)=1;
hp(11,4)=2;
hp(11,5)=exp((-y(5)))*exp(y(5))*params(1)*1/y(3)+exp(y(5))*params(1)*1/y(3)*(-exp((-y(5))));
hp(12,1)=2;
hp(12,2)=5;
hp(12,3)=3;
hp(12,4)=1;
hp(12,5)=T216+params(2)*(-exp((-y(5))))*T215;
hp(13,1)=2;
hp(13,2)=5;
hp(13,3)=3;
hp(13,4)=2;
hp(13,5)=T364+exp(y(5))*params(1)*(-y(1))/(y(3)*y(3))*(-exp((-y(5))));
hp(14,1)=2;
hp(14,2)=5;
hp(14,3)=5;
hp(14,4)=1;
hp(14,5)=params(2)*exp((-y(5)))*T180+params(2)*(-exp((-y(5))))*T180+params(2)*exp((-y(5)))*T180+params(2)*(-exp((-y(5))))*T180;
hp(15,1)=2;
hp(15,2)=5;
hp(15,3)=5;
hp(15,4)=2;
hp(15,5)=T361+T32*(-exp((-y(5))))+exp((-y(5)))*T32+T32*(-exp((-y(5))));
hp(16,1)=2;
hp(16,2)=5;
hp(16,3)=5;
hp(16,4)=3;
hp(16,5)=(-(params(2)*exp((-y(5)))));
hp(17,1)=3;
hp(17,2)=3;
hp(17,3)=3;
hp(17,4)=1;
hp(17,5)=(-(T39*T160*T190+T43*(T160*T39*(-log(y(4)))+T39*((params(1)-1)*params(1)*log(y(3))*T309+T309*(params(1)+params(1)-1)))));
hp(18,1)=3;
hp(18,2)=4;
hp(18,3)=3;
hp(18,4)=1;
hp(18,5)=(-(T80*T90*T190+T43*(T90*(T220+params(1)*log(y(3))*T220)+T80*((1-params(1))*(-log(y(4)))*T232-T232))));
hp(19,1)=3;
hp(19,2)=4;
hp(19,3)=4;
hp(19,4)=1;
hp(19,5)=(-(T38*T167*T190+T43*(T167*T38*log(y(3))+T38*((1-params(1)-1)*(1-params(1))*(-log(y(4)))*T331+T331*(-(1-params(1)+1-params(1)-1))))));
hp(20,1)=3;
hp(20,2)=5;
hp(20,3)=3;
hp(20,4)=1;
hp(20,5)=(-((-params(1))*T43*T226+T39*T80*((-T43)+(-params(1))*T190)));
hp(21,1)=3;
hp(21,2)=5;
hp(21,3)=4;
hp(21,4)=1;
hp(21,5)=(-((-params(1))*T43*T239+T38*T90*((-T43)+(-params(1))*T190)));
hp(22,1)=3;
hp(22,2)=5;
hp(22,3)=5;
hp(22,4)=1;
hp(22,5)=(-((-params(1))*(-params(1))*T43*T189+T38*T39*((-((-params(1))*T43))+(-params(1))*((-T43)+(-params(1))*T190))));
hp(23,1)=4;
hp(23,2)=5;
hp(23,3)=3;
hp(23,4)=3;
hp(23,5)=exp((-y(5)));
hp(24,1)=4;
hp(24,2)=5;
hp(24,3)=5;
hp(24,4)=3;
hp(24,5)=exp((-y(5)))*(-y(3));
end
end
