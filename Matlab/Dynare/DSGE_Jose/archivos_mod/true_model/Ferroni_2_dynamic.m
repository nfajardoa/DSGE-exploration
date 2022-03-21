function [residual, g1, g2, g3] = Ferroni_2_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(8, 1);
T29 = params(2)*y(7)/y(15)*exp((-y(16))-y(17));
T36 = params(1)*y(14)/y(8)*exp(y(16)+y(17));
T39 = T36+1-params(3);
T43 = y(2)^params(1);
T44 = y(9)^(1-params(1));
lhs =y(9)^(1+1/params(4));
rhs =(1-params(1))*y(6)/y(7);
residual(1)= lhs-rhs;
lhs =T29*T39;
rhs =1;
residual(2)= lhs-rhs;
lhs =y(6);
rhs =T43*T44*exp((-params(1))*(y(10)+y(11)));
residual(3)= lhs-rhs;
lhs =y(6);
rhs =y(7)+y(8)-(1-params(3))*y(2)*exp((-y(10))-y(11));
residual(4)= lhs-rhs;
lhs =y(10);
rhs =params(5)*y(4)+x(it_, 1);
residual(5)= lhs-rhs;
lhs =y(11);
rhs =params(6)*y(5)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(12);
rhs =y(6)/y(1)*exp(y(10)+y(11));
residual(7)= lhs-rhs;
lhs =y(13);
rhs =y(9)/y(3)*exp(y(11));
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 19);

  %
  % Jacobian matrix
  %

T90 = (-(exp(y(10)+y(11))*(-y(6))/(y(1)*y(1))));
T96 = (-(exp(y(10)+y(11))*1/y(1)));
T99 = exp(y(16)+y(17))*params(1)*1/y(8);
T107 = exp((-y(16))-y(17))*params(2)*1/y(15);
T113 = exp((-y(16))-y(17))*params(2)*(-y(7))/(y(15)*y(15));
T115 = getPowerDeriv(y(2),params(1),1);
T125 = exp(y(16)+y(17))*params(1)*(-y(14))/(y(8)*y(8));
T133 = getPowerDeriv(y(9),1-params(1),1);
T147 = (-(y(6)/y(1)*exp(y(10)+y(11))));
T149 = params(2)*y(7)/y(15)*(-exp((-y(16))-y(17)));
T152 = T39*T149+T29*T36;
  g1(1,6)=(-((1-params(1))*1/y(7)));
  g1(1,7)=(-((1-params(1))*(-y(6))/(y(7)*y(7))));
  g1(1,9)=getPowerDeriv(y(9),1+1/params(4),1);
  g1(2,14)=T29*T99;
  g1(2,7)=T39*T107;
  g1(2,15)=T39*T113;
  g1(2,8)=T29*T125;
  g1(2,16)=T152;
  g1(2,17)=T152;
  g1(3,6)=1;
  g1(3,2)=(-(exp((-params(1))*(y(10)+y(11)))*T44*T115));
  g1(3,9)=(-(exp((-params(1))*(y(10)+y(11)))*T43*T133));
  g1(3,10)=(-(T43*T44*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  g1(3,11)=(-(T43*T44*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  g1(4,6)=1;
  g1(4,7)=(-1);
  g1(4,2)=(1-params(3))*exp((-y(10))-y(11));
  g1(4,8)=(-1);
  g1(4,10)=(1-params(3))*y(2)*(-exp((-y(10))-y(11)));
  g1(4,11)=(1-params(3))*y(2)*(-exp((-y(10))-y(11)));
  g1(5,4)=(-params(5));
  g1(5,10)=1;
  g1(5,18)=(-1);
  g1(6,5)=(-params(6));
  g1(6,11)=1;
  g1(6,19)=(-1);
  g1(7,1)=T90;
  g1(7,6)=T96;
  g1(7,10)=T147;
  g1(7,11)=T147;
  g1(7,12)=1;
  g1(8,3)=(-(exp(y(11))*(-y(9))/(y(3)*y(3))));
  g1(8,9)=(-(exp(y(11))*1/y(3)));
  g1(8,11)=(-(y(9)/y(3)*exp(y(11))));
  g1(8,13)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(85,3);
T199 = T39*params(2)*1/y(15)*(-exp((-y(16))-y(17)))+T36*T107;
T203 = T39*params(2)*(-y(7))/(y(15)*y(15))*(-exp((-y(16))-y(17)))+T36*T113;
  v2(1,1)=1;
  v2(1,2)=120;
  v2(1,3)=(-((1-params(1))*(-1)/(y(7)*y(7))));
  v2(2,1)=1;
  v2(2,2)=102;
  v2(2,3)=  v2(1,3);
  v2(3,1)=1;
  v2(3,2)=121;
  v2(3,3)=(-((1-params(1))*(-((-y(6))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7))));
  v2(4,1)=1;
  v2(4,2)=161;
  v2(4,3)=getPowerDeriv(y(9),1+1/params(4),2);
  v2(5,1)=2;
  v2(5,2)=128;
  v2(5,3)=T99*T107;
  v2(6,1)=2;
  v2(6,2)=254;
  v2(6,3)=  v2(5,3);
  v2(7,1)=2;
  v2(7,2)=280;
  v2(7,3)=T99*T113;
  v2(8,1)=2;
  v2(8,2)=262;
  v2(8,3)=  v2(7,3);
  v2(9,1)=2;
  v2(9,2)=273;
  v2(9,3)=T39*exp((-y(16))-y(17))*params(2)*(-1)/(y(15)*y(15));
  v2(10,1)=2;
  v2(10,2)=129;
  v2(10,3)=  v2(9,3);
  v2(11,1)=2;
  v2(11,2)=281;
  v2(11,3)=T39*exp((-y(16))-y(17))*params(2)*(-((-y(7))*(y(15)+y(15))))/(y(15)*y(15)*y(15)*y(15));
  v2(12,1)=2;
  v2(12,2)=147;
  v2(12,3)=T29*exp(y(16)+y(17))*params(1)*(-1)/(y(8)*y(8));
  v2(13,1)=2;
  v2(13,2)=255;
  v2(13,3)=  v2(12,3);
  v2(14,1)=2;
  v2(14,2)=140;
  v2(14,3)=T107*T125;
  v2(15,1)=2;
  v2(15,2)=122;
  v2(15,3)=  v2(14,3);
  v2(16,1)=2;
  v2(16,2)=148;
  v2(16,3)=T113*T125;
  v2(17,1)=2;
  v2(17,2)=274;
  v2(17,3)=  v2(16,3);
  v2(18,1)=2;
  v2(18,2)=141;
  v2(18,3)=T29*exp(y(16)+y(17))*params(1)*(-((-y(14))*(y(8)+y(8))))/(y(8)*y(8)*y(8)*y(8));
  v2(19,1)=2;
  v2(19,2)=299;
  v2(19,3)=T29*T99+T99*T149;
  v2(20,1)=2;
  v2(20,2)=263;
  v2(20,3)=  v2(19,3);
  v2(21,1)=2;
  v2(21,2)=292;
  v2(21,3)=T199;
  v2(22,1)=2;
  v2(22,2)=130;
  v2(22,3)=  v2(21,3);
  v2(23,1)=2;
  v2(23,2)=300;
  v2(23,3)=T203;
  v2(24,1)=2;
  v2(24,2)=282;
  v2(24,3)=  v2(23,3);
  v2(25,1)=2;
  v2(25,2)=293;
  v2(25,3)=T29*T125+T125*T149;
  v2(26,1)=2;
  v2(26,2)=149;
  v2(26,3)=  v2(25,3);
  v2(27,1)=2;
  v2(27,2)=301;
  v2(27,3)=T29*T39+T36*T149+T29*T36+T36*T149;
  v2(28,1)=2;
  v2(28,2)=318;
  v2(28,3)=T29*T99+T99*T149;
  v2(29,1)=2;
  v2(29,2)=264;
  v2(29,3)=  v2(28,3);
  v2(30,1)=2;
  v2(30,2)=311;
  v2(30,3)=T199;
  v2(31,1)=2;
  v2(31,2)=131;
  v2(31,3)=  v2(30,3);
  v2(32,1)=2;
  v2(32,2)=319;
  v2(32,3)=T203;
  v2(33,1)=2;
  v2(33,2)=283;
  v2(33,3)=  v2(32,3);
  v2(34,1)=2;
  v2(34,2)=312;
  v2(34,3)=T29*T125+T125*T149;
  v2(35,1)=2;
  v2(35,2)=150;
  v2(35,3)=  v2(34,3);
  v2(36,1)=2;
  v2(36,2)=320;
  v2(36,3)=T29*T39+T36*T149+T29*T36+T36*T149;
  v2(37,1)=2;
  v2(37,2)=302;
  v2(37,3)=  v2(36,3);
  v2(38,1)=2;
  v2(38,2)=321;
  v2(38,3)=T29*T39+T36*T149+T29*T36+T36*T149;
  v2(39,1)=3;
  v2(39,2)=21;
  v2(39,3)=(-(exp((-params(1))*(y(10)+y(11)))*T44*getPowerDeriv(y(2),params(1),2)));
  v2(40,1)=3;
  v2(40,2)=154;
  v2(40,3)=(-(exp((-params(1))*(y(10)+y(11)))*T115*T133));
  v2(41,1)=3;
  v2(41,2)=28;
  v2(41,3)=  v2(40,3);
  v2(42,1)=3;
  v2(42,2)=161;
  v2(42,3)=(-(exp((-params(1))*(y(10)+y(11)))*T43*getPowerDeriv(y(9),1-params(1),2)));
  v2(43,1)=3;
  v2(43,2)=173;
  v2(43,3)=(-(T44*T115*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(44,1)=3;
  v2(44,2)=29;
  v2(44,3)=  v2(43,3);
  v2(45,1)=3;
  v2(45,2)=180;
  v2(45,3)=(-(T43*T133*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(46,1)=3;
  v2(46,2)=162;
  v2(46,3)=  v2(45,3);
  v2(47,1)=3;
  v2(47,2)=181;
  v2(47,3)=(-(T43*T44*(-params(1))*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(48,1)=3;
  v2(48,2)=192;
  v2(48,3)=(-(T44*T115*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(49,1)=3;
  v2(49,2)=30;
  v2(49,3)=  v2(48,3);
  v2(50,1)=3;
  v2(50,2)=199;
  v2(50,3)=(-(T43*T133*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(51,1)=3;
  v2(51,2)=163;
  v2(51,3)=  v2(50,3);
  v2(52,1)=3;
  v2(52,2)=200;
  v2(52,3)=(-(T43*T44*(-params(1))*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(53,1)=3;
  v2(53,2)=182;
  v2(53,3)=  v2(52,3);
  v2(54,1)=3;
  v2(54,2)=201;
  v2(54,3)=(-(T43*T44*(-params(1))*(-params(1))*exp((-params(1))*(y(10)+y(11)))));
  v2(55,1)=4;
  v2(55,2)=173;
  v2(55,3)=(1-params(3))*(-exp((-y(10))-y(11)));
  v2(56,1)=4;
  v2(56,2)=29;
  v2(56,3)=  v2(55,3);
  v2(57,1)=4;
  v2(57,2)=181;
  v2(57,3)=(1-params(3))*y(2)*exp((-y(10))-y(11));
  v2(58,1)=4;
  v2(58,2)=192;
  v2(58,3)=(1-params(3))*(-exp((-y(10))-y(11)));
  v2(59,1)=4;
  v2(59,2)=30;
  v2(59,3)=  v2(58,3);
  v2(60,1)=4;
  v2(60,2)=200;
  v2(60,3)=(1-params(3))*y(2)*exp((-y(10))-y(11));
  v2(61,1)=4;
  v2(61,2)=182;
  v2(61,3)=  v2(60,3);
  v2(62,1)=4;
  v2(62,2)=201;
  v2(62,3)=(1-params(3))*y(2)*exp((-y(10))-y(11));
  v2(63,1)=7;
  v2(63,2)=1;
  v2(63,3)=(-(exp(y(10)+y(11))*(-((-y(6))*(y(1)+y(1))))/(y(1)*y(1)*y(1)*y(1))));
  v2(64,1)=7;
  v2(64,2)=96;
  v2(64,3)=(-(exp(y(10)+y(11))*(-1)/(y(1)*y(1))));
  v2(65,1)=7;
  v2(65,2)=6;
  v2(65,3)=  v2(64,3);
  v2(66,1)=7;
  v2(66,2)=172;
  v2(66,3)=T90;
  v2(67,1)=7;
  v2(67,2)=10;
  v2(67,3)=  v2(66,3);
  v2(68,1)=7;
  v2(68,2)=177;
  v2(68,3)=T96;
  v2(69,1)=7;
  v2(69,2)=105;
  v2(69,3)=  v2(68,3);
  v2(70,1)=7;
  v2(70,2)=181;
  v2(70,3)=T147;
  v2(71,1)=7;
  v2(71,2)=191;
  v2(71,3)=T90;
  v2(72,1)=7;
  v2(72,2)=11;
  v2(72,3)=  v2(71,3);
  v2(73,1)=7;
  v2(73,2)=196;
  v2(73,3)=T96;
  v2(74,1)=7;
  v2(74,2)=106;
  v2(74,3)=  v2(73,3);
  v2(75,1)=7;
  v2(75,2)=200;
  v2(75,3)=T147;
  v2(76,1)=7;
  v2(76,2)=182;
  v2(76,3)=  v2(75,3);
  v2(77,1)=7;
  v2(77,2)=201;
  v2(77,3)=T147;
  v2(78,1)=8;
  v2(78,2)=41;
  v2(78,3)=(-(exp(y(11))*(-((-y(9))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3))));
  v2(79,1)=8;
  v2(79,2)=155;
  v2(79,3)=(-(exp(y(11))*(-1)/(y(3)*y(3))));
  v2(80,1)=8;
  v2(80,2)=47;
  v2(80,3)=  v2(79,3);
  v2(81,1)=8;
  v2(81,2)=193;
  v2(81,3)=(-(exp(y(11))*(-y(9))/(y(3)*y(3))));
  v2(82,1)=8;
  v2(82,2)=49;
  v2(82,3)=  v2(81,3);
  v2(83,1)=8;
  v2(83,2)=199;
  v2(83,3)=(-(exp(y(11))*1/y(3)));
  v2(84,1)=8;
  v2(84,2)=163;
  v2(84,3)=  v2(83,3);
  v2(85,1)=8;
  v2(85,2)=201;
  v2(85,3)=(-(y(9)/y(3)*exp(y(11))));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),8,361);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,6859);
end
end
end
end
