function [residual, g1, g2, g3] = Ferroni_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(10, 1);
T29 = params(2)*y(9)/y(19)*exp((-y(20))-y(21));
T39 = params(1)*y(18)/y(10)*exp(y(20)+y(21))+1-params(3);
T43 = y(2)^params(1);
T44 = y(11)^(1-params(1));
lhs =y(11)^(1+1/params(4));
rhs =(1-params(1))*y(8)/y(9);
residual(1)= lhs-rhs;
lhs =T29*T39;
rhs =1;
residual(2)= lhs-rhs;
lhs =y(8);
rhs =T43*T44*exp((-params(1))*(y(12)+y(13)));
residual(3)= lhs-rhs;
lhs =y(8);
rhs =y(9)+y(10)-(1-params(3))*y(2)*exp((-y(12))-y(13));
residual(4)= lhs-rhs;
lhs =y(12);
rhs =params(5)*y(4)+x(it_, 1);
residual(5)= lhs-rhs;
lhs =y(13);
rhs =params(6)*y(5)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(14)/y(6);
rhs =y(8)/y(1)*exp(y(12)+y(13));
residual(7)= lhs-rhs;
lhs =y(15)/y(7);
rhs =y(11)/y(3)*exp(y(13));
residual(8)= lhs-rhs;
lhs =y(16);
rhs =y(14)/y(6);
residual(9)= lhs-rhs;
lhs =y(17);
rhs =y(15)/y(7);
residual(10)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(10, 23);

  %
  % Jacobian matrix
  %

T160 = T39*params(2)*y(9)/y(19)*(-exp((-y(20))-y(21)))+T29*params(1)*y(18)/y(10)*exp(y(20)+y(21));
  g1(1,8)=(-((1-params(1))*1/y(9)));
  g1(1,9)=(-((1-params(1))*(-y(8))/(y(9)*y(9))));
  g1(1,11)=getPowerDeriv(y(11),1+1/params(4),1);
  g1(2,18)=T29*exp(y(20)+y(21))*params(1)*1/y(10);
  g1(2,9)=T39*exp((-y(20))-y(21))*params(2)*1/y(19);
  g1(2,19)=T39*exp((-y(20))-y(21))*params(2)*(-y(9))/(y(19)*y(19));
  g1(2,10)=T29*exp(y(20)+y(21))*params(1)*(-y(18))/(y(10)*y(10));
  g1(2,20)=T160;
  g1(2,21)=T160;
  g1(3,8)=1;
  g1(3,2)=(-(exp((-params(1))*(y(12)+y(13)))*T44*getPowerDeriv(y(2),params(1),1)));
  g1(3,11)=(-(exp((-params(1))*(y(12)+y(13)))*T43*getPowerDeriv(y(11),1-params(1),1)));
  g1(3,12)=(-(T43*T44*(-params(1))*exp((-params(1))*(y(12)+y(13)))));
  g1(3,13)=(-(T43*T44*(-params(1))*exp((-params(1))*(y(12)+y(13)))));
  g1(4,8)=1;
  g1(4,9)=(-1);
  g1(4,2)=(1-params(3))*exp((-y(12))-y(13));
  g1(4,10)=(-1);
  g1(4,12)=(1-params(3))*y(2)*(-exp((-y(12))-y(13)));
  g1(4,13)=(1-params(3))*y(2)*(-exp((-y(12))-y(13)));
  g1(5,4)=(-params(5));
  g1(5,12)=1;
  g1(5,22)=(-1);
  g1(6,5)=(-params(6));
  g1(6,13)=1;
  g1(6,23)=(-1);
  g1(7,1)=(-(exp(y(12)+y(13))*(-y(8))/(y(1)*y(1))));
  g1(7,8)=(-(exp(y(12)+y(13))*1/y(1)));
  g1(7,12)=(-(y(8)/y(1)*exp(y(12)+y(13))));
  g1(7,13)=(-(y(8)/y(1)*exp(y(12)+y(13))));
  g1(7,6)=(-y(14))/(y(6)*y(6));
  g1(7,14)=1/y(6);
  g1(8,3)=(-(exp(y(13))*(-y(11))/(y(3)*y(3))));
  g1(8,11)=(-(exp(y(13))*1/y(3)));
  g1(8,13)=(-(y(11)/y(3)*exp(y(13))));
  g1(8,7)=(-y(15))/(y(7)*y(7));
  g1(8,15)=1/y(7);
  g1(9,6)=(-((-y(14))/(y(6)*y(6))));
  g1(9,14)=(-(1/y(6)));
  g1(9,16)=1;
  g1(10,7)=(-((-y(15))/(y(7)*y(7))));
  g1(10,15)=(-(1/y(7)));
  g1(10,17)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,529);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,12167);
end
end
end
end
