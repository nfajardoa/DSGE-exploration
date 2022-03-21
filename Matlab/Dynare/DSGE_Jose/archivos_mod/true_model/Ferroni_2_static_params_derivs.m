function [rp, gp, rpp, gpp, hp] = Ferroni_2_static_params_derivs(y, x, params)
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

T11 = 1+1/params(4);
T12 = y(4)^T11;
T25 = exp((-y(5))-y(6));
T32 = params(1)*y(1)/y(3)*exp(y(5)+y(6));
T38 = y(3)^params(1);
T39 = y(4)^(1-params(1));
T43 = exp((y(5)+y(6))*(-params(1)));
T83 = getPowerDeriv(y(3),params(1),1);
T91 = getPowerDeriv(y(4),1-params(1),1);
T140 = getPowerDeriv(y(3),params(1),2);
T147 = getPowerDeriv(y(4),1-params(1),2);
T160 = y(1)/y(3)*exp(y(5)+y(6));
T161 = params(2)*T25*T160;
T169 = T39*T38*log(y(3))+T38*T39*(-log(y(4)));
T171 = T43*(-(y(5)+y(6)));
T183 = T38*log(y(3))*T39*(-log(y(4)))+T39*log(y(3))*T38*log(y(3))+T38*log(y(3))*T39*(-log(y(4)))+T38*(-log(y(4)))*T39*(-log(y(4)));
T184 = T169*T171;
T194 = exp(y(5)+y(6))*1/y(3);
T196 = exp(y(5)+y(6))*(-y(1))/(y(3)*y(3));
T199 = T161+params(2)*(-T25)*T160;
T201 = y(3)^(params(1)-1);
T207 = T83*T39*(-log(y(4)))+T39*(T201+params(1)*log(y(3))*T201);
T213 = y(4)^(1-params(1)-1);
T220 = T91*T38*log(y(3))+T38*((1-params(1))*(-log(y(4)))*T213-T213);
T231 = (-((-params(1))*T43*T169+T38*T39*((-T43)+(-params(1))*T171)));
T277 = (-(T169*((-T43)+(-params(1))*T171)+(-params(1))*T43*T183+T169*((-T43)+(-params(1))*T171)+T38*T39*((-T171)+(-T171)+(-params(1))*(-(y(5)+y(6)))*T171)));
T290 = y(3)^(params(1)-2);
T312 = y(4)^(1-params(1)-2);
T341 = (-((-params(1))*(-params(1))*T43*T169+T38*T39*((-((-params(1))*T43))+(-params(1))*((-T43)+(-params(1))*T171))));
T348 = (T32+1-params(3))*(-T25)+T25*T32;
T356 = T25*exp(y(5)+y(6))*params(1)*1/y(3)+exp(y(5)+y(6))*params(1)*1/y(3)*(-T25);
T358 = T25*exp(y(5)+y(6))*params(1)*(-y(1))/(y(3)*y(3))+exp(y(5)+y(6))*params(1)*(-y(1))/(y(3)*y(3))*(-T25);
T370 = (-1)/(params(4)*params(4));
T371 = log(y(4))*T370;
T372 = T12*T371;
T382 = y(4)^(T11-1);
T397 = y(4)^(T11-2);
rp = zeros(8, 6);
rp(1, 1) = y(1)/y(2);
rp(1, 4) = T372;
rp(2, 1) = T161;
rp(2, 2) = T25*(T32+1-params(3));
rp(2, 3) = (-(params(2)*T25));
rp(3, 1) = (-(T43*T169+T38*T39*T171));
rp(4, 3) = T25*(-y(3));
rp(5, 5) = (-y(5));
rp(6, 6) = (-y(6));
gp = zeros(8, 8, 6);
gp(1, 1, 1) = 1/y(2);
gp(1, 2, 1) = (-y(1))/(y(2)*y(2));
gp(1, 4, 4) = T11*T371*T382+T370*T382;
gp(2, 1, 1) = params(2)*T25*T194;
gp(2, 1, 2) = T25*exp(y(5)+y(6))*params(1)*1/y(3);
gp(2, 3, 1) = params(2)*T25*T196;
gp(2, 3, 2) = T25*exp(y(5)+y(6))*params(1)*(-y(1))/(y(3)*y(3));
gp(2, 5, 1) = T199;
gp(2, 5, 2) = T348;
gp(2, 5, 3) = (-(params(2)*(-T25)));
gp(2, 6, 1) = T199;
gp(2, 6, 2) = T348;
gp(2, 6, 3) = (-(params(2)*(-T25)));
gp(3, 3, 1) = (-(T39*T83*T171+T43*T207));
gp(3, 4, 1) = (-(T38*T91*T171+T43*T220));
gp(3, 5, 1) = T231;
gp(3, 6, 1) = T231;
gp(4, 3, 3) = (-T25);
gp(4, 5, 3) = (-T25)*(-y(3));
gp(4, 6, 3) = (-T25)*(-y(3));
gp(5, 5, 5) = (-1);
gp(6, 6, 6) = (-1);
if nargout >= 3
rpp = zeros(4,4);
rpp(1,1)=1;
rpp(1,2)=4;
rpp(1,3)=4;
rpp(1,4)=T371*T372+T12*log(y(4))*(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4));
rpp(2,1)=2;
rpp(2,2)=1;
rpp(2,3)=2;
rpp(2,4)=T25*T160;
rpp(3,1)=2;
rpp(3,2)=2;
rpp(3,3)=3;
rpp(3,4)=(-T25);
rpp(4,1)=3;
rpp(4,2)=1;
rpp(4,3)=1;
rpp(4,4)=(-(T184+T43*T183+T184+T38*T39*(-(y(5)+y(6)))*T171));
gpp = zeros(11,5);
gpp(1,1)=1;
gpp(1,2)=4;
gpp(1,3)=4;
gpp(1,4)=4;
gpp(1,5)=T370*T371*T382+T11*(log(y(4))*(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4))*T382+T371*T371*T382)+T370*T371*T382+(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4))*T382;
gpp(2,1)=2;
gpp(2,2)=1;
gpp(2,3)=1;
gpp(2,4)=2;
gpp(2,5)=T25*T194;
gpp(3,1)=2;
gpp(3,2)=3;
gpp(3,3)=1;
gpp(3,4)=2;
gpp(3,5)=T25*T196;
gpp(4,1)=2;
gpp(4,2)=5;
gpp(4,3)=1;
gpp(4,4)=2;
gpp(4,5)=T25*T160+(-T25)*T160;
gpp(5,1)=2;
gpp(5,2)=5;
gpp(5,3)=2;
gpp(5,4)=3;
gpp(5,5)=T25;
gpp(6,1)=2;
gpp(6,2)=6;
gpp(6,3)=1;
gpp(6,4)=2;
gpp(6,5)=T25*T160+(-T25)*T160;
gpp(7,1)=2;
gpp(7,2)=6;
gpp(7,3)=2;
gpp(7,4)=3;
gpp(7,5)=T25;
gpp(8,1)=3;
gpp(8,2)=3;
gpp(8,3)=1;
gpp(8,4)=1;
gpp(8,5)=(-(T171*T207+T39*T83*(-(y(5)+y(6)))*T171+T171*T207+T43*(T39*(-log(y(4)))*(T201+params(1)*log(y(3))*T201)+T83*(-log(y(4)))*T39*(-log(y(4)))+T39*(-log(y(4)))*(T201+params(1)*log(y(3))*T201)+T39*(log(y(3))*T201+log(y(3))*T201+params(1)*log(y(3))*log(y(3))*T201))));
gpp(9,1)=3;
gpp(9,2)=4;
gpp(9,3)=1;
gpp(9,4)=1;
gpp(9,5)=(-(T171*T220+T38*T91*(-(y(5)+y(6)))*T171+T171*T220+T43*(T38*log(y(3))*((1-params(1))*(-log(y(4)))*T213-T213)+T91*log(y(3))*T38*log(y(3))+T38*log(y(3))*((1-params(1))*(-log(y(4)))*T213-T213)+T38*((-((-log(y(4)))*T213))+(1-params(1))*(-log(y(4)))*(-log(y(4)))*T213-(-log(y(4)))*T213))));
gpp(10,1)=3;
gpp(10,2)=5;
gpp(10,3)=1;
gpp(10,4)=1;
gpp(10,5)=T277;
gpp(11,1)=3;
gpp(11,2)=6;
gpp(11,3)=1;
gpp(11,4)=1;
gpp(11,5)=T277;
end
if nargout >= 5
hp = zeros(39,5);
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
hp(3,5)=(T11-1)*T11*T371*T397+T397*T370*(T11+T11-1);
hp(4,1)=2;
hp(4,2)=3;
hp(4,3)=1;
hp(4,4)=1;
hp(4,5)=params(2)*T25*exp(y(5)+y(6))*(-1)/(y(3)*y(3));
hp(5,1)=2;
hp(5,2)=3;
hp(5,3)=1;
hp(5,4)=2;
hp(5,5)=T25*exp(y(5)+y(6))*params(1)*(-1)/(y(3)*y(3));
hp(6,1)=2;
hp(6,2)=3;
hp(6,3)=3;
hp(6,4)=1;
hp(6,5)=params(2)*T25*exp(y(5)+y(6))*(-((-y(1))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3));
hp(7,1)=2;
hp(7,2)=3;
hp(7,3)=3;
hp(7,4)=2;
hp(7,5)=T25*exp(y(5)+y(6))*params(1)*(-((-y(1))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3));
hp(8,1)=2;
hp(8,2)=5;
hp(8,3)=1;
hp(8,4)=1;
hp(8,5)=params(2)*T25*T194+params(2)*(-T25)*T194;
hp(9,1)=2;
hp(9,2)=5;
hp(9,3)=1;
hp(9,4)=2;
hp(9,5)=T356;
hp(10,1)=2;
hp(10,2)=5;
hp(10,3)=3;
hp(10,4)=1;
hp(10,5)=params(2)*T25*T196+params(2)*(-T25)*T196;
hp(11,1)=2;
hp(11,2)=5;
hp(11,3)=3;
hp(11,4)=2;
hp(11,5)=T358;
hp(12,1)=2;
hp(12,2)=5;
hp(12,3)=5;
hp(12,4)=1;
hp(12,5)=T199+T199;
hp(13,1)=2;
hp(13,2)=5;
hp(13,3)=5;
hp(13,4)=2;
hp(13,5)=T25*(T32+1-params(3))+T32*(-T25)+T25*T32+T32*(-T25);
hp(14,1)=2;
hp(14,2)=5;
hp(14,3)=5;
hp(14,4)=3;
hp(14,5)=(-(params(2)*T25));
hp(15,1)=2;
hp(15,2)=6;
hp(15,3)=1;
hp(15,4)=1;
hp(15,5)=params(2)*T25*T194+params(2)*(-T25)*T194;
hp(16,1)=2;
hp(16,2)=6;
hp(16,3)=1;
hp(16,4)=2;
hp(16,5)=T356;
hp(17,1)=2;
hp(17,2)=6;
hp(17,3)=3;
hp(17,4)=1;
hp(17,5)=params(2)*T25*T196+params(2)*(-T25)*T196;
hp(18,1)=2;
hp(18,2)=6;
hp(18,3)=3;
hp(18,4)=2;
hp(18,5)=T358;
hp(19,1)=2;
hp(19,2)=6;
hp(19,3)=5;
hp(19,4)=1;
hp(19,5)=T199+T199;
hp(20,1)=2;
hp(20,2)=6;
hp(20,3)=5;
hp(20,4)=2;
hp(20,5)=T25*(T32+1-params(3))+T32*(-T25)+T25*T32+T32*(-T25);
hp(21,1)=2;
hp(21,2)=6;
hp(21,3)=5;
hp(21,4)=3;
hp(21,5)=(-(params(2)*T25));
hp(22,1)=2;
hp(22,2)=6;
hp(22,3)=6;
hp(22,4)=1;
hp(22,5)=T199+T199;
hp(23,1)=2;
hp(23,2)=6;
hp(23,3)=6;
hp(23,4)=2;
hp(23,5)=T25*(T32+1-params(3))+T32*(-T25)+T25*T32+T32*(-T25);
hp(24,1)=2;
hp(24,2)=6;
hp(24,3)=6;
hp(24,4)=3;
hp(24,5)=(-(params(2)*T25));
hp(25,1)=3;
hp(25,2)=3;
hp(25,3)=3;
hp(25,4)=1;
hp(25,5)=(-(T39*T140*T171+T43*(T140*T39*(-log(y(4)))+T39*((params(1)-1)*params(1)*log(y(3))*T290+T290*(params(1)+params(1)-1)))));
hp(26,1)=3;
hp(26,2)=4;
hp(26,3)=3;
hp(26,4)=1;
hp(26,5)=(-(T83*T91*T171+T43*(T91*(T201+params(1)*log(y(3))*T201)+T83*((1-params(1))*(-log(y(4)))*T213-T213))));
hp(27,1)=3;
hp(27,2)=4;
hp(27,3)=4;
hp(27,4)=1;
hp(27,5)=(-(T38*T147*T171+T43*(T147*T38*log(y(3))+T38*((1-params(1)-1)*(1-params(1))*(-log(y(4)))*T312+T312*(-(1-params(1)+1-params(1)-1))))));
hp(28,1)=3;
hp(28,2)=5;
hp(28,3)=3;
hp(28,4)=1;
hp(28,5)=(-((-params(1))*T43*T207+T39*T83*((-T43)+(-params(1))*T171)));
hp(29,1)=3;
hp(29,2)=5;
hp(29,3)=4;
hp(29,4)=1;
hp(29,5)=(-((-params(1))*T43*T220+T38*T91*((-T43)+(-params(1))*T171)));
hp(30,1)=3;
hp(30,2)=5;
hp(30,3)=5;
hp(30,4)=1;
hp(30,5)=T341;
hp(31,1)=3;
hp(31,2)=6;
hp(31,3)=3;
hp(31,4)=1;
hp(31,5)=(-((-params(1))*T43*T207+T39*T83*((-T43)+(-params(1))*T171)));
hp(32,1)=3;
hp(32,2)=6;
hp(32,3)=4;
hp(32,4)=1;
hp(32,5)=(-((-params(1))*T43*T220+T38*T91*((-T43)+(-params(1))*T171)));
hp(33,1)=3;
hp(33,2)=6;
hp(33,3)=5;
hp(33,4)=1;
hp(33,5)=T341;
hp(34,1)=3;
hp(34,2)=6;
hp(34,3)=6;
hp(34,4)=1;
hp(34,5)=T341;
hp(35,1)=4;
hp(35,2)=5;
hp(35,3)=3;
hp(35,4)=3;
hp(35,5)=T25;
hp(36,1)=4;
hp(36,2)=5;
hp(36,3)=5;
hp(36,4)=3;
hp(36,5)=T25*(-y(3));
hp(37,1)=4;
hp(37,2)=6;
hp(37,3)=3;
hp(37,4)=3;
hp(37,5)=T25;
hp(38,1)=4;
hp(38,2)=6;
hp(38,3)=5;
hp(38,4)=3;
hp(38,5)=T25*(-y(3));
hp(39,1)=4;
hp(39,2)=6;
hp(39,3)=6;
hp(39,4)=3;
hp(39,5)=T25*(-y(3));
end
end
