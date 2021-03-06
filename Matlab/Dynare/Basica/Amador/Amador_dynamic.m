function [residual, g1, g2, g3] = Amador_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(38, 1);
lhs =y(26);
rhs =y(2)+x(it_, 1);
residual(1)= lhs-rhs;
lhs =y(30);
rhs =params(3)*(y(6)-y(8))+x(it_, 3)+y(32);
residual(2)= lhs-rhs;
lhs =y(29);
rhs =y(28)-y(76);
residual(3)= lhs-rhs;
lhs =y(34);
rhs =y(10)+x(it_, 5);
residual(4)= lhs-rhs;
lhs =y(64);
rhs =y(64)*params(4)+(1-params(4))*y(9);
residual(5)= lhs-rhs;
lhs =y(37);
rhs =y(25)-y(26);
residual(6)= lhs-rhs;
lhs =y(37);
rhs =params(5)*y(11)-params(6)*y(65)-params(7)*y(5)+y(9)*params(8)+y(38);
residual(7)= lhs-rhs;
lhs =y(36);
rhs =y(29)-y(31);
residual(8)= lhs-rhs;
lhs =y(35);
rhs =y(33)-y(34);
residual(9)= lhs-rhs;
lhs =y(38);
rhs =params(9)*y(12)+x(it_, 6);
residual(10)= lhs-rhs;
lhs =y(39);
rhs =params(9)*y(13)+x(it_, 9);
residual(11)= lhs-rhs;
lhs =y(27);
rhs =y(39)+params(11)*y(1)+(1-params(10))*y(3)+params(10)*y(76)+params(12)*(y(33)-y(24));
residual(12)= lhs-rhs;
lhs =y(28);
rhs =x(it_, 7)+params(13)*y(4)+(1-params(13))*(y(37)*params(15)+y(31)+y(76)+params(14)*(y(76)-y(40)));
residual(13)= lhs-rhs;
lhs =12*(y(64)-y(9));
rhs =y(29)-y(30)-(y(31)-y(32))+x(it_, 8);
residual(14)= lhs-rhs;
lhs =y(31);
rhs =params(1)*params(17)+(1-params(1))*y(7)+x(it_, 2);
residual(15)= lhs-rhs;
lhs =y(32);
rhs =(1-params(2))*params(18)+y(8)*params(2)+x(it_, 4);
residual(16)= lhs-rhs;
lhs =y(41);
rhs =y(63);
residual(17)= lhs-rhs;
lhs =y(42);
rhs =y(66);
residual(18)= lhs-rhs;
lhs =y(43);
rhs =y(67);
residual(19)= lhs-rhs;
lhs =y(44);
rhs =y(68);
residual(20)= lhs-rhs;
lhs =y(45);
rhs =y(69);
residual(21)= lhs-rhs;
lhs =y(46);
rhs =y(70);
residual(22)= lhs-rhs;
lhs =y(47);
rhs =y(71);
residual(23)= lhs-rhs;
lhs =y(48);
rhs =y(72);
residual(24)= lhs-rhs;
lhs =y(49);
rhs =y(73);
residual(25)= lhs-rhs;
lhs =y(50);
rhs =y(74);
residual(26)= lhs-rhs;
lhs =y(51);
rhs =y(75);
residual(27)= lhs-rhs;
lhs =y(52);
rhs =y(9);
residual(28)= lhs-rhs;
lhs =y(53);
rhs =y(14);
residual(29)= lhs-rhs;
lhs =y(54);
rhs =y(15);
residual(30)= lhs-rhs;
lhs =y(55);
rhs =y(16);
residual(31)= lhs-rhs;
lhs =y(56);
rhs =y(17);
residual(32)= lhs-rhs;
lhs =y(57);
rhs =y(18);
residual(33)= lhs-rhs;
lhs =y(58);
rhs =y(19);
residual(34)= lhs-rhs;
lhs =y(59);
rhs =y(20);
residual(35)= lhs-rhs;
lhs =y(60);
rhs =y(21);
residual(36)= lhs-rhs;
lhs =y(61);
rhs =y(22);
residual(37)= lhs-rhs;
lhs =y(62);
rhs =y(23);
residual(38)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(38, 85);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-1);
  g1(1,26)=1;
  g1(1,77)=(-1);
  g1(2,6)=(-params(3));
  g1(2,30)=1;
  g1(2,8)=params(3);
  g1(2,32)=(-1);
  g1(2,79)=(-1);
  g1(3,28)=(-1);
  g1(3,29)=1;
  g1(3,76)=1;
  g1(4,10)=(-1);
  g1(4,34)=1;
  g1(4,81)=(-1);
  g1(5,9)=(-(1-params(4)));
  g1(5,64)=1-params(4);
  g1(6,25)=(-1);
  g1(6,26)=1;
  g1(6,37)=1;
  g1(7,5)=params(7);
  g1(7,9)=(-params(8));
  g1(7,11)=(-params(5));
  g1(7,37)=1;
  g1(7,65)=params(6);
  g1(7,38)=(-1);
  g1(8,29)=(-1);
  g1(8,31)=1;
  g1(8,36)=1;
  g1(9,33)=(-1);
  g1(9,34)=1;
  g1(9,35)=1;
  g1(10,12)=(-params(9));
  g1(10,38)=1;
  g1(10,82)=(-1);
  g1(11,13)=(-params(9));
  g1(11,39)=1;
  g1(11,85)=(-1);
  g1(12,1)=(-params(11));
  g1(12,3)=(-(1-params(10)));
  g1(12,27)=1;
  g1(12,33)=(-params(12));
  g1(12,39)=(-1);
  g1(12,76)=(-params(10));
  g1(12,24)=params(12);
  g1(13,4)=(-params(13));
  g1(13,28)=1;
  g1(13,31)=(-(1-params(13)));
  g1(13,37)=(-((1-params(13))*params(15)));
  g1(13,40)=(-((1-params(13))*(-params(14))));
  g1(13,83)=(-1);
  g1(13,76)=(-((1-params(13))*(1+params(14))));
  g1(14,29)=(-1);
  g1(14,30)=1;
  g1(14,31)=1;
  g1(14,32)=(-1);
  g1(14,9)=(-12);
  g1(14,64)=12;
  g1(14,84)=(-1);
  g1(15,7)=(-(1-params(1)));
  g1(15,31)=1;
  g1(15,78)=(-1);
  g1(16,8)=(-params(2));
  g1(16,32)=1;
  g1(16,80)=(-1);
  g1(17,63)=(-1);
  g1(17,41)=1;
  g1(18,66)=(-1);
  g1(18,42)=1;
  g1(19,67)=(-1);
  g1(19,43)=1;
  g1(20,68)=(-1);
  g1(20,44)=1;
  g1(21,69)=(-1);
  g1(21,45)=1;
  g1(22,70)=(-1);
  g1(22,46)=1;
  g1(23,71)=(-1);
  g1(23,47)=1;
  g1(24,72)=(-1);
  g1(24,48)=1;
  g1(25,73)=(-1);
  g1(25,49)=1;
  g1(26,74)=(-1);
  g1(26,50)=1;
  g1(27,75)=(-1);
  g1(27,51)=1;
  g1(28,9)=(-1);
  g1(28,52)=1;
  g1(29,14)=(-1);
  g1(29,53)=1;
  g1(30,15)=(-1);
  g1(30,54)=1;
  g1(31,16)=(-1);
  g1(31,55)=1;
  g1(32,17)=(-1);
  g1(32,56)=1;
  g1(33,18)=(-1);
  g1(33,57)=1;
  g1(34,19)=(-1);
  g1(34,58)=1;
  g1(35,20)=(-1);
  g1(35,59)=1;
  g1(36,21)=(-1);
  g1(36,60)=1;
  g1(37,22)=(-1);
  g1(37,61)=1;
  g1(38,23)=(-1);
  g1(38,62)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],38,7225);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],38,614125);
end
end
end
end
