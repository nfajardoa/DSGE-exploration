function [residual, g1, g2, g3] = Ferroni_3_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(7, 1);
T30 = params(2)*y(6)/y(13)*exp((-y(14)));
T36 = params(1)*y(12)/y(7)*exp(y(14));
T39 = T36+1-params(3);
T43 = y(2)^params(1);
T44 = y(8)^(1-params(1));
lhs =(y(8)/exp(y(10)))^(1+1/params(4));
rhs =(1-params(1))*y(5)/y(6);
residual(1)= lhs-rhs;
lhs =T30*T39;
rhs =1;
residual(2)= lhs-rhs;
lhs =y(5);
rhs =T43*T44*exp((-params(1))*y(9));
residual(3)= lhs-rhs;
lhs =y(5);
rhs =y(6)+y(7)-(1-params(3))*y(2)*exp((-y(9)));
residual(4)= lhs-rhs;
lhs =y(9);
rhs =params(5)*y(3)+x(it_, 1);
residual(5)= lhs-rhs;
lhs =y(10);
rhs =params(6)*y(4)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(11);
rhs =y(5)/y(1)*exp(y(9));
residual(7)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(7, 16);

  %
  % Jacobian matrix
  %

T90 = exp(y(14))*params(1)*1/y(7);
T98 = exp((-y(14)))*params(2)*1/y(13);
T104 = exp((-y(14)))*params(2)*(-y(6))/(y(13)*y(13));
T106 = getPowerDeriv(y(2),params(1),1);
T116 = exp(y(14))*params(1)*(-y(12))/(y(7)*y(7));
T119 = getPowerDeriv(y(8)/exp(y(10)),1+1/params(4),1);
T121 = getPowerDeriv(y(8),1-params(1),1);
T134 = params(2)*y(6)/y(13)*(-exp((-y(14))));
T142 = (-(y(8)*exp(y(10))))/(exp(y(10))*exp(y(10)));
  g1(1,5)=(-((1-params(1))*1/y(6)));
  g1(1,6)=(-((1-params(1))*(-y(5))/(y(6)*y(6))));
  g1(1,8)=1/exp(y(10))*T119;
  g1(1,10)=T119*T142;
  g1(2,12)=T30*T90;
  g1(2,6)=T39*T98;
  g1(2,13)=T39*T104;
  g1(2,7)=T30*T116;
  g1(2,14)=T39*T134+T30*T36;
  g1(3,5)=1;
  g1(3,2)=(-(exp((-params(1))*y(9))*T44*T106));
  g1(3,8)=(-(exp((-params(1))*y(9))*T43*T121));
  g1(3,9)=(-(T43*T44*(-params(1))*exp((-params(1))*y(9))));
  g1(4,5)=1;
  g1(4,6)=(-1);
  g1(4,2)=(1-params(3))*exp((-y(9)));
  g1(4,7)=(-1);
  g1(4,9)=(1-params(3))*y(2)*(-exp((-y(9))));
  g1(5,3)=(-params(5));
  g1(5,9)=1;
  g1(5,15)=(-1);
  g1(6,4)=(-params(6));
  g1(6,10)=1;
  g1(6,16)=(-1);
  g1(7,1)=(-(exp(y(9))*(-y(5))/(y(1)*y(1))));
  g1(7,5)=(-(exp(y(9))*1/y(1)));
  g1(7,9)=(-(y(5)/y(1)*exp(y(9))));
  g1(7,11)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(50,3);
T154 = getPowerDeriv(y(8)/exp(y(10)),1+1/params(4),2);
T155 = 1/exp(y(10))*T154;
  v2(1,1)=1;
  v2(1,2)=85;
  v2(1,3)=(-((1-params(1))*(-1)/(y(6)*y(6))));
  v2(2,1)=1;
  v2(2,2)=70;
  v2(2,3)=  v2(1,3);
  v2(3,1)=1;
  v2(3,2)=86;
  v2(3,3)=(-((1-params(1))*(-((-y(5))*(y(6)+y(6))))/(y(6)*y(6)*y(6)*y(6))));
  v2(4,1)=1;
  v2(4,2)=120;
  v2(4,3)=1/exp(y(10))*T155;
  v2(5,1)=1;
  v2(5,2)=152;
  v2(5,3)=T142*T155+T119*(-exp(y(10)))/(exp(y(10))*exp(y(10)));
  v2(6,1)=1;
  v2(6,2)=122;
  v2(6,3)=  v2(5,3);
  v2(7,1)=1;
  v2(7,2)=154;
  v2(7,3)=T142*T142*T154+T119*((-(y(8)*exp(y(10))))*exp(y(10))*exp(y(10))-(-(y(8)*exp(y(10))))*(exp(y(10))*exp(y(10))+exp(y(10))*exp(y(10))))/(exp(y(10))*exp(y(10))*exp(y(10))*exp(y(10)));
  v2(8,1)=2;
  v2(8,2)=92;
  v2(8,3)=T90*T98;
  v2(9,1)=2;
  v2(9,2)=182;
  v2(9,3)=  v2(8,3);
  v2(10,1)=2;
  v2(10,2)=204;
  v2(10,3)=T90*T104;
  v2(11,1)=2;
  v2(11,2)=189;
  v2(11,3)=  v2(10,3);
  v2(12,1)=2;
  v2(12,2)=198;
  v2(12,3)=T39*exp((-y(14)))*params(2)*(-1)/(y(13)*y(13));
  v2(13,1)=2;
  v2(13,2)=93;
  v2(13,3)=  v2(12,3);
  v2(14,1)=2;
  v2(14,2)=205;
  v2(14,3)=T39*exp((-y(14)))*params(2)*(-((-y(6))*(y(13)+y(13))))/(y(13)*y(13)*y(13)*y(13));
  v2(15,1)=2;
  v2(15,2)=108;
  v2(15,3)=T30*exp(y(14))*params(1)*(-1)/(y(7)*y(7));
  v2(16,1)=2;
  v2(16,2)=183;
  v2(16,3)=  v2(15,3);
  v2(17,1)=2;
  v2(17,2)=102;
  v2(17,3)=T98*T116;
  v2(18,1)=2;
  v2(18,2)=87;
  v2(18,3)=  v2(17,3);
  v2(19,1)=2;
  v2(19,2)=109;
  v2(19,3)=T104*T116;
  v2(20,1)=2;
  v2(20,2)=199;
  v2(20,3)=  v2(19,3);
  v2(21,1)=2;
  v2(21,2)=103;
  v2(21,3)=T30*exp(y(14))*params(1)*(-((-y(12))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7));
  v2(22,1)=2;
  v2(22,2)=220;
  v2(22,3)=T30*T90+T90*T134;
  v2(23,1)=2;
  v2(23,2)=190;
  v2(23,3)=  v2(22,3);
  v2(24,1)=2;
  v2(24,2)=214;
  v2(24,3)=T39*params(2)*1/y(13)*(-exp((-y(14))))+T36*T98;
  v2(25,1)=2;
  v2(25,2)=94;
  v2(25,3)=  v2(24,3);
  v2(26,1)=2;
  v2(26,2)=221;
  v2(26,3)=T39*params(2)*(-y(6))/(y(13)*y(13))*(-exp((-y(14))))+T36*T104;
  v2(27,1)=2;
  v2(27,2)=206;
  v2(27,3)=  v2(26,3);
  v2(28,1)=2;
  v2(28,2)=215;
  v2(28,3)=T30*T116+T116*T134;
  v2(29,1)=2;
  v2(29,2)=110;
  v2(29,3)=  v2(28,3);
  v2(30,1)=2;
  v2(30,2)=222;
  v2(30,3)=T30*T39+T36*T134+T30*T36+T36*T134;
  v2(31,1)=3;
  v2(31,2)=18;
  v2(31,3)=(-(exp((-params(1))*y(9))*T44*getPowerDeriv(y(2),params(1),2)));
  v2(32,1)=3;
  v2(32,2)=114;
  v2(32,3)=(-(exp((-params(1))*y(9))*T106*T121));
  v2(33,1)=3;
  v2(33,2)=24;
  v2(33,3)=  v2(32,3);
  v2(34,1)=3;
  v2(34,2)=120;
  v2(34,3)=(-(exp((-params(1))*y(9))*T43*getPowerDeriv(y(8),1-params(1),2)));
  v2(35,1)=3;
  v2(35,2)=130;
  v2(35,3)=(-(T44*T106*(-params(1))*exp((-params(1))*y(9))));
  v2(36,1)=3;
  v2(36,2)=25;
  v2(36,3)=  v2(35,3);
  v2(37,1)=3;
  v2(37,2)=136;
  v2(37,3)=(-(T43*T121*(-params(1))*exp((-params(1))*y(9))));
  v2(38,1)=3;
  v2(38,2)=121;
  v2(38,3)=  v2(37,3);
  v2(39,1)=3;
  v2(39,2)=137;
  v2(39,3)=(-(T43*T44*(-params(1))*(-params(1))*exp((-params(1))*y(9))));
  v2(40,1)=4;
  v2(40,2)=130;
  v2(40,3)=(1-params(3))*(-exp((-y(9))));
  v2(41,1)=4;
  v2(41,2)=25;
  v2(41,3)=  v2(40,3);
  v2(42,1)=4;
  v2(42,2)=137;
  v2(42,3)=(1-params(3))*y(2)*exp((-y(9)));
  v2(43,1)=7;
  v2(43,2)=1;
  v2(43,3)=(-(exp(y(9))*(-((-y(5))*(y(1)+y(1))))/(y(1)*y(1)*y(1)*y(1))));
  v2(44,1)=7;
  v2(44,2)=65;
  v2(44,3)=(-(exp(y(9))*(-1)/(y(1)*y(1))));
  v2(45,1)=7;
  v2(45,2)=5;
  v2(45,3)=  v2(44,3);
  v2(46,1)=7;
  v2(46,2)=129;
  v2(46,3)=(-(exp(y(9))*(-y(5))/(y(1)*y(1))));
  v2(47,1)=7;
  v2(47,2)=9;
  v2(47,3)=  v2(46,3);
  v2(48,1)=7;
  v2(48,2)=133;
  v2(48,3)=(-(exp(y(9))*1/y(1)));
  v2(49,1)=7;
  v2(49,2)=73;
  v2(49,3)=  v2(48,3);
  v2(50,1)=7;
  v2(50,2)=137;
  v2(50,3)=(-(y(5)/y(1)*exp(y(9))));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),7,256);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],7,4096);
end
end
end
end
