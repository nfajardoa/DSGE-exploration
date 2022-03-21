function [residual, g1, g2, g3] = Ferroni_4_dynamic(y, x, params, steady_state, it_)
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
kratio__ = params(1)/(1/params(2)+params(3)-1);
cratio__ = 1-params(3)*kratio__;
T30 = params(1)*1/kratio__;
lhs =(y(7)-y(9))*(1+1/params(4));
rhs =y(4)-y(5);
residual(1)= lhs-rhs;
lhs =0;
rhs =params(2)*(T30*(y(5)-y(13)+y(12)-y(6))+(y(5)-y(13))*(1-params(3)));
residual(2)= lhs-rhs;
lhs =y(4);
rhs =params(1)*y(1)+(y(7)+y(8))*(1-params(1));
residual(3)= lhs-rhs;
lhs =y(4);
rhs =y(5)*cratio__+kratio__*y(6)-y(1)*kratio__*(1-params(3));
residual(4)= lhs-rhs;
lhs =y(8);
rhs =params(5)*y(2)+x(it_, 1);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =params(6)*y(3)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(10);
rhs =y(4);
residual(7)= lhs-rhs;
lhs =y(11);
rhs =y(7);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 15);

  %
  % Jacobian matrix
  %

  g1(1,4)=(-1);
  g1(1,5)=1;
  g1(1,7)=1+1/params(4);
  g1(1,9)=(-(1+1/params(4)));
  g1(2,12)=(-(params(2)*T30));
  g1(2,5)=(-(params(2)*(T30+1-params(3))));
  g1(2,13)=(-(params(2)*((-T30)-(1-params(3)))));
  g1(2,6)=(-(params(2)*(-T30)));
  g1(3,4)=1;
  g1(3,1)=(-params(1));
  g1(3,7)=(-(1-params(1)));
  g1(3,8)=(-(1-params(1)));
  g1(4,4)=1;
  g1(4,5)=(-cratio__);
  g1(4,1)=kratio__*(1-params(3));
  g1(4,6)=(-kratio__);
  g1(5,2)=(-params(5));
  g1(5,8)=1;
  g1(5,14)=(-1);
  g1(6,3)=(-params(6));
  g1(6,9)=1;
  g1(6,15)=(-1);
  g1(7,4)=(-1);
  g1(7,10)=1;
  g1(8,7)=(-1);
  g1(8,11)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,225);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,3375);
end
end
end
end
