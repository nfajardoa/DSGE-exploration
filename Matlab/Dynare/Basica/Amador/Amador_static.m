function [residual, g1, g2, g3] = Amador_static(y, x, params)
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

residual = zeros( 38, 1);

%
% Model equations
%

lhs =y(2);
rhs =y(2)+x(1);
residual(1)= lhs-rhs;
lhs =y(6);
rhs =y(8)+params(3)*(y(6)-y(8))+x(3);
residual(2)= lhs-rhs;
lhs =y(5);
rhs =y(4)-y(3);
residual(3)= lhs-rhs;
lhs =y(10);
rhs =y(10)+x(5);
residual(4)= lhs-rhs;
lhs =y(9);
rhs =y(9)*params(4)+y(9)*(1-params(4));
residual(5)= lhs-rhs;
lhs =y(13);
rhs =y(1)-y(2);
residual(6)= lhs-rhs;
lhs =y(13);
rhs =y(13)*params(5)-y(13)*params(6)-y(5)*params(7)+y(9)*params(8)+y(14);
residual(7)= lhs-rhs;
lhs =y(12);
rhs =y(5)-y(7);
residual(8)= lhs-rhs;
lhs =y(11);
rhs =y(9)-y(10);
residual(9)= lhs-rhs;
lhs =y(14);
rhs =y(14)*params(9)+x(6);
residual(10)= lhs-rhs;
lhs =y(15);
rhs =params(9)*y(15)+x(9);
residual(11)= lhs-rhs;
lhs =y(3);
rhs =y(15)+y(1)*params(11)+y(3)*(1-params(10))+y(3)*params(10);
residual(12)= lhs-rhs;
lhs =y(4);
rhs =x(7)+y(4)*params(13)+(1-params(13))*(y(13)*params(15)+y(7)+y(3)+params(14)*(y(3)-y(16)));
residual(13)= lhs-rhs;
lhs =0;
rhs =y(5)-y(6)-(y(7)-y(8))+x(8);
residual(14)= lhs-rhs;
lhs =y(7);
rhs =params(1)*params(17)+y(7)*(1-params(1))+x(2);
residual(15)= lhs-rhs;
lhs =y(8);
rhs =(1-params(2))*params(18)+y(8)*params(2)+x(4);
residual(16)= lhs-rhs;
lhs =y(17);
rhs =y(3);
residual(17)= lhs-rhs;
lhs =y(18);
rhs =y(3);
residual(18)= lhs-rhs;
lhs =y(19);
rhs =y(3);
residual(19)= lhs-rhs;
lhs =y(20);
rhs =y(3);
residual(20)= lhs-rhs;
lhs =y(21);
rhs =y(3);
residual(21)= lhs-rhs;
lhs =y(22);
rhs =y(3);
residual(22)= lhs-rhs;
lhs =y(23);
rhs =y(3);
residual(23)= lhs-rhs;
lhs =y(24);
rhs =y(3);
residual(24)= lhs-rhs;
lhs =y(25);
rhs =y(3);
residual(25)= lhs-rhs;
lhs =y(26);
rhs =y(3);
residual(26)= lhs-rhs;
lhs =y(27);
rhs =y(3);
residual(27)= lhs-rhs;
lhs =y(28);
rhs =y(9);
residual(28)= lhs-rhs;
lhs =y(29);
rhs =y(9);
residual(29)= lhs-rhs;
lhs =y(30);
rhs =y(9);
residual(30)= lhs-rhs;
lhs =y(31);
rhs =y(9);
residual(31)= lhs-rhs;
lhs =y(32);
rhs =y(9);
residual(32)= lhs-rhs;
lhs =y(33);
rhs =y(9);
residual(33)= lhs-rhs;
lhs =y(34);
rhs =y(9);
residual(34)= lhs-rhs;
lhs =y(35);
rhs =y(9);
residual(35)= lhs-rhs;
lhs =y(36);
rhs =y(9);
residual(36)= lhs-rhs;
lhs =y(37);
rhs =y(9);
residual(37)= lhs-rhs;
lhs =y(38);
rhs =y(9);
residual(38)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(38, 38);

  %
  % Jacobian matrix
  %

  g1(2,6)=1-params(3);
  g1(2,8)=(-(1-params(3)));
  g1(3,3)=1;
  g1(3,4)=(-1);
  g1(3,5)=1;
  g1(5,9)=1-(params(4)+1-params(4));
  g1(6,1)=(-1);
  g1(6,2)=1;
  g1(6,13)=1;
  g1(7,5)=params(7);
  g1(7,9)=(-params(8));
  g1(7,13)=1-(params(5)-params(6));
  g1(7,14)=(-1);
  g1(8,5)=(-1);
  g1(8,7)=1;
  g1(8,12)=1;
  g1(9,9)=(-1);
  g1(9,10)=1;
  g1(9,11)=1;
  g1(10,14)=1-params(9);
  g1(11,15)=1-params(9);
  g1(12,1)=(-params(11));
  g1(12,3)=1-(params(10)+1-params(10));
  g1(12,15)=(-1);
  g1(13,3)=(-((1-params(13))*(1+params(14))));
  g1(13,4)=1-params(13);
  g1(13,7)=(-(1-params(13)));
  g1(13,13)=(-((1-params(13))*params(15)));
  g1(13,16)=(-((1-params(13))*(-params(14))));
  g1(14,5)=(-1);
  g1(14,6)=1;
  g1(14,7)=1;
  g1(14,8)=(-1);
  g1(15,7)=1-(1-params(1));
  g1(16,8)=1-params(2);
  g1(17,3)=(-1);
  g1(17,17)=1;
  g1(18,3)=(-1);
  g1(18,18)=1;
  g1(19,3)=(-1);
  g1(19,19)=1;
  g1(20,3)=(-1);
  g1(20,20)=1;
  g1(21,3)=(-1);
  g1(21,21)=1;
  g1(22,3)=(-1);
  g1(22,22)=1;
  g1(23,3)=(-1);
  g1(23,23)=1;
  g1(24,3)=(-1);
  g1(24,24)=1;
  g1(25,3)=(-1);
  g1(25,25)=1;
  g1(26,3)=(-1);
  g1(26,26)=1;
  g1(27,3)=(-1);
  g1(27,27)=1;
  g1(28,9)=(-1);
  g1(28,28)=1;
  g1(29,9)=(-1);
  g1(29,29)=1;
  g1(30,9)=(-1);
  g1(30,30)=1;
  g1(31,9)=(-1);
  g1(31,31)=1;
  g1(32,9)=(-1);
  g1(32,32)=1;
  g1(33,9)=(-1);
  g1(33,33)=1;
  g1(34,9)=(-1);
  g1(34,34)=1;
  g1(35,9)=(-1);
  g1(35,35)=1;
  g1(36,9)=(-1);
  g1(36,36)=1;
  g1(37,9)=(-1);
  g1(37,37)=1;
  g1(38,9)=(-1);
  g1(38,38)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],38,1444);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],38,54872);
end
end
end
end
