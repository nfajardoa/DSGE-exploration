function [residual, g1, g2, g3] = Ferroni_static(y, x, params)
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

residual = zeros( 10, 1);

%
% Model equations
%

T38 = y(3)^params(1);
T39 = y(4)^(1-params(1));
lhs =y(4)^(1+1/params(4));
rhs =(1-params(1))*y(1)/y(2);
residual(1)= lhs-rhs;
lhs =params(2)*exp((-y(5))-y(6))*(params(1)*y(1)/y(3)*exp(y(5)+y(6))+1-params(3));
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
lhs =1;
rhs =exp(y(5)+y(6));
residual(7)= lhs-rhs;
lhs =1;
rhs =exp(y(6));
residual(8)= lhs-rhs;
lhs =y(9);
rhs =1;
residual(9)= lhs-rhs;
lhs =y(10);
rhs =1;
residual(10)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(10, 10);

  %
  % Jacobian matrix
  %

T103 = (params(1)*y(1)/y(3)*exp(y(5)+y(6))+1-params(3))*params(2)*(-exp((-y(5))-y(6)))+params(2)*exp((-y(5))-y(6))*params(1)*y(1)/y(3)*exp(y(5)+y(6));
  g1(1,1)=(-((1-params(1))*1/y(2)));
  g1(1,2)=(-((1-params(1))*(-y(1))/(y(2)*y(2))));
  g1(1,4)=getPowerDeriv(y(4),1+1/params(4),1);
  g1(2,1)=params(2)*exp((-y(5))-y(6))*exp(y(5)+y(6))*params(1)*1/y(3);
  g1(2,3)=params(2)*exp((-y(5))-y(6))*exp(y(5)+y(6))*params(1)*(-y(1))/(y(3)*y(3));
  g1(2,5)=T103;
  g1(2,6)=T103;
  g1(3,1)=1;
  g1(3,3)=(-(exp((y(5)+y(6))*(-params(1)))*T39*getPowerDeriv(y(3),params(1),1)));
  g1(3,4)=(-(exp((y(5)+y(6))*(-params(1)))*T38*getPowerDeriv(y(4),1-params(1),1)));
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
  g1(8,6)=(-exp(y(6)));
  g1(9,9)=1;
  g1(10,10)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,100);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,1000);
end
end
end
end
