function [residual, g1, g2, g3] = Ferroni_2_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 8, 1);

%
% Model equations
%

T32 = params(1)*y(1)/y(3)*exp(y(5)+y(6));
T36 = params(2)*exp((-y(5))-y(6))*(T32+1-params(3));
T38 = y(3)^params(1);
T39 = y(4)^(1-params(1));
lhs =y(4)^(1+1/params(4));
rhs =(1-params(1))*y(1)/y(2);
residual(1)= lhs-rhs;
lhs =T36;
rhs =1;
residual(2)= lhs-rhs;
lhs =y(1);
rhs =T38*T39*exp((y(5)+y(6))*(-params(1)));
residual(3)= lhs-rhs;
lhs =y(1);
rhs =y(2)+y(3)-exp((-y(5))-y(6))*y(3)*(1-params(3));
residual(4)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(5)+x(1);
residual(5)= lhs-rhs;
lhs =y(6);
rhs =y(6)*params(6)+x(2);
residual(6)= lhs-rhs;
lhs =y(7);
rhs =exp(y(5)+y(6));
residual(7)= lhs-rhs;
lhs =y(8);
rhs =exp(y(6));
residual(8)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(8, 8);

  %
  % Jacobian matrix
  %

T72 = params(2)*exp((-y(5))-y(6))*exp(y(5)+y(6))*params(1)*1/y(3);
T82 = params(2)*exp((-y(5))-y(6))*exp(y(5)+y(6))*params(1)*(-y(1))/(y(3)*y(3));
T83 = getPowerDeriv(y(3),params(1),1);
T91 = getPowerDeriv(y(4),1-params(1),1);
T99 = (T32+1-params(3))*params(2)*(-exp((-y(5))-y(6)))+params(2)*exp((-y(5))-y(6))*T32;
  g1(1,1)=(-((1-params(1))*1/y(2)));
  g1(1,2)=(-((1-params(1))*(-y(1))/(y(2)*y(2))));
  g1(1,4)=getPowerDeriv(y(4),1+1/params(4),1);
  g1(2,1)=T72;
  g1(2,3)=T82;
  g1(2,5)=T99;
  g1(2,6)=T99;
  g1(3,1)=1;
  g1(3,3)=(-(exp((y(5)+y(6))*(-params(1)))*T39*T83));
  g1(3,4)=(-(exp((y(5)+y(6))*(-params(1)))*T38*T91));
  g1(3,5)=(-(T38*T39*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  g1(3,6)=(-(T38*T39*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  g1(4,1)=1;
  g1(4,2)=(-1);
  g1(4,3)=(-(1-exp((-y(5))-y(6))*(1-params(3))));
  g1(4,5)=y(3)*(1-params(3))*(-exp((-y(5))-y(6)));
  g1(4,6)=y(3)*(1-params(3))*(-exp((-y(5))-y(6)));
  g1(5,5)=1-params(5);
  g1(6,6)=1-params(6);
  g1(7,5)=(-exp(y(5)+y(6)));
  g1(7,6)=(-exp(y(5)+y(6)));
  g1(7,7)=1;
  g1(8,6)=(-exp(y(6)));
  g1(8,8)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(48,3);
T133 = T72+exp(y(5)+y(6))*params(1)*1/y(3)*params(2)*(-exp((-y(5))-y(6)));
T135 = T82+exp(y(5)+y(6))*params(1)*(-y(1))/(y(3)*y(3))*params(2)*(-exp((-y(5))-y(6)));
T139 = T36+T32*params(2)*(-exp((-y(5))-y(6)))+params(2)*exp((-y(5))-y(6))*T32+T32*params(2)*(-exp((-y(5))-y(6)));
  v2(1,1)=1;
  v2(1,2)=9;
  v2(1,3)=(-((1-params(1))*(-1)/(y(2)*y(2))));
  v2(2,1)=1;
  v2(2,2)=2;
  v2(2,3)=  v2(1,3);
  v2(3,1)=1;
  v2(3,2)=10;
  v2(3,3)=(-((1-params(1))*(-((-y(1))*(y(2)+y(2))))/(y(2)*y(2)*y(2)*y(2))));
  v2(4,1)=1;
  v2(4,2)=28;
  v2(4,3)=getPowerDeriv(y(4),1+1/params(4),2);
  v2(5,1)=2;
  v2(5,2)=17;
  v2(5,3)=params(2)*exp((-y(5))-y(6))*exp(y(5)+y(6))*params(1)*(-1)/(y(3)*y(3));
  v2(6,1)=2;
  v2(6,2)=3;
  v2(6,3)=  v2(5,3);
  v2(7,1)=2;
  v2(7,2)=19;
  v2(7,3)=params(2)*exp((-y(5))-y(6))*exp(y(5)+y(6))*params(1)*(-((-y(1))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3));
  v2(8,1)=2;
  v2(8,2)=33;
  v2(8,3)=T133;
  v2(9,1)=2;
  v2(9,2)=5;
  v2(9,3)=  v2(8,3);
  v2(10,1)=2;
  v2(10,2)=35;
  v2(10,3)=T135;
  v2(11,1)=2;
  v2(11,2)=21;
  v2(11,3)=  v2(10,3);
  v2(12,1)=2;
  v2(12,2)=37;
  v2(12,3)=T139;
  v2(13,1)=2;
  v2(13,2)=41;
  v2(13,3)=T133;
  v2(14,1)=2;
  v2(14,2)=6;
  v2(14,3)=  v2(13,3);
  v2(15,1)=2;
  v2(15,2)=43;
  v2(15,3)=T135;
  v2(16,1)=2;
  v2(16,2)=22;
  v2(16,3)=  v2(15,3);
  v2(17,1)=2;
  v2(17,2)=45;
  v2(17,3)=T139;
  v2(18,1)=2;
  v2(18,2)=38;
  v2(18,3)=  v2(17,3);
  v2(19,1)=2;
  v2(19,2)=46;
  v2(19,3)=T139;
  v2(20,1)=3;
  v2(20,2)=19;
  v2(20,3)=(-(exp((y(5)+y(6))*(-params(1)))*T39*getPowerDeriv(y(3),params(1),2)));
  v2(21,1)=3;
  v2(21,2)=27;
  v2(21,3)=(-(exp((y(5)+y(6))*(-params(1)))*T83*T91));
  v2(22,1)=3;
  v2(22,2)=20;
  v2(22,3)=  v2(21,3);
  v2(23,1)=3;
  v2(23,2)=28;
  v2(23,3)=(-(exp((y(5)+y(6))*(-params(1)))*T38*getPowerDeriv(y(4),1-params(1),2)));
  v2(24,1)=3;
  v2(24,2)=35;
  v2(24,3)=(-(T39*T83*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(25,1)=3;
  v2(25,2)=21;
  v2(25,3)=  v2(24,3);
  v2(26,1)=3;
  v2(26,2)=36;
  v2(26,3)=(-(T38*T91*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(27,1)=3;
  v2(27,2)=29;
  v2(27,3)=  v2(26,3);
  v2(28,1)=3;
  v2(28,2)=37;
  v2(28,3)=(-(T38*T39*(-params(1))*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(29,1)=3;
  v2(29,2)=43;
  v2(29,3)=(-(T39*T83*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(30,1)=3;
  v2(30,2)=22;
  v2(30,3)=  v2(29,3);
  v2(31,1)=3;
  v2(31,2)=44;
  v2(31,3)=(-(T38*T91*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(32,1)=3;
  v2(32,2)=30;
  v2(32,3)=  v2(31,3);
  v2(33,1)=3;
  v2(33,2)=45;
  v2(33,3)=(-(T38*T39*(-params(1))*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(34,1)=3;
  v2(34,2)=38;
  v2(34,3)=  v2(33,3);
  v2(35,1)=3;
  v2(35,2)=46;
  v2(35,3)=(-(T38*T39*(-params(1))*(-params(1))*exp((y(5)+y(6))*(-params(1)))));
  v2(36,1)=4;
  v2(36,2)=35;
  v2(36,3)=(1-params(3))*(-exp((-y(5))-y(6)));
  v2(37,1)=4;
  v2(37,2)=21;
  v2(37,3)=  v2(36,3);
  v2(38,1)=4;
  v2(38,2)=37;
  v2(38,3)=exp((-y(5))-y(6))*y(3)*(1-params(3));
  v2(39,1)=4;
  v2(39,2)=43;
  v2(39,3)=(1-params(3))*(-exp((-y(5))-y(6)));
  v2(40,1)=4;
  v2(40,2)=22;
  v2(40,3)=  v2(39,3);
  v2(41,1)=4;
  v2(41,2)=45;
  v2(41,3)=exp((-y(5))-y(6))*y(3)*(1-params(3));
  v2(42,1)=4;
  v2(42,2)=38;
  v2(42,3)=  v2(41,3);
  v2(43,1)=4;
  v2(43,2)=46;
  v2(43,3)=exp((-y(5))-y(6))*y(3)*(1-params(3));
  v2(44,1)=7;
  v2(44,2)=37;
  v2(44,3)=(-exp(y(5)+y(6)));
  v2(45,1)=7;
  v2(45,2)=45;
  v2(45,3)=(-exp(y(5)+y(6)));
  v2(46,1)=7;
  v2(46,2)=38;
  v2(46,3)=  v2(45,3);
  v2(47,1)=7;
  v2(47,2)=46;
  v2(47,3)=(-exp(y(5)+y(6)));
  v2(48,1)=8;
  v2(48,2)=46;
  v2(48,3)=(-exp(y(6)));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),8,64);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,512);
end
end
end
end
