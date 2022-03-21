function [rp, gp, rpp, gpp, hp] = Ferroni_3_params_derivs(y, x, params, steady_state, it_, ss_param_deriv, ss_param_2nd_deriv)
%
% Compute the derivatives of the dynamic model with respect to the parameters
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%   ss_param_deriv     [M_.eq_nbr by #params]     Jacobian matrix of the steady states values with respect to the parameters
%   ss_param_2nd_deriv [M_.eq_nbr by #params by #params] Hessian matrix of the steady states values with respect to the parameters
%
% Outputs:
%   rp        [M_.eq_nbr by #params] double    Jacobian matrix of dynamic model equations with respect to parameters 
%                                              Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   gp        [M_.endo_nbr by #dynamic variables by #params] double    Derivative of the Jacobian matrix of the dynamic model equations with respect to the parameters
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence
%   rpp       [#second_order_residual_terms by 4] double   Hessian matrix of second derivatives of residuals with respect to parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: number of the first parameter in derivative
%                                                              3rd column: number of the second parameter in derivative
%                                                              4th column: value of the Hessian term
%   gpp      [#second_order_Jacobian_terms by 5] double   Hessian matrix of second derivatives of the Jacobian with respect to the parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: column number of variable in Jacobian of the dynamic model
%                                                              3rd column: number of the first parameter in derivative
%                                                              4th column: number of the second parameter in derivative
%                                                              5th column: value of the Hessian term
%   hp      [#first_order_Hessian_terms by 5] double   Jacobian matrix of derivatives of the dynamic Hessian with respect to the parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: column number of first variable in Hessian of the dynamic model
%                                                              3rd column: column number of second variable in Hessian of the dynamic model
%                                                              4th column: number of the parameter in derivative
%                                                              5th column: value of the Hessian term
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

T11 = y(8)/exp(y(10));
T14 = 1+1/params(4);
T15 = T11^T14;
T30 = params(2)*y(6)/y(13)*exp((-y(14)));
T36 = params(1)*y(12)/y(7)*exp(y(14));
T39 = T36+1-params(3);
T43 = y(2)^params(1);
T44 = y(8)^(1-params(1));
T49 = exp((-params(1))*y(9));
T90 = exp(y(14))*params(1)*1/y(7);
T98 = exp((-y(14)))*params(2)*1/y(13);
T104 = exp((-y(14)))*params(2)*(-y(6))/(y(13)*y(13));
T106 = getPowerDeriv(y(2),params(1),1);
T116 = exp(y(14))*params(1)*(-y(12))/(y(7)*y(7));
T118 = 1/exp(y(10));
T121 = getPowerDeriv(y(8),1-params(1),1);
T134 = params(2)*y(6)/y(13)*(-exp((-y(14))));
T142 = (-(y(8)*exp(y(10))))/(exp(y(10))*exp(y(10)));
T184 = exp((-y(14)))*params(2)*(-((-y(6))*(y(13)+y(13))))/(y(13)*y(13)*y(13)*y(13));
T216 = getPowerDeriv(y(2),params(1),2);
T223 = getPowerDeriv(y(8),1-params(1),2);
T246 = y(12)/y(7)*exp(y(14));
T255 = T44*T43*log(y(2))+T43*T44*(-log(y(8)));
T256 = T49*(-y(9));
T268 = T43*log(y(2))*T44*(-log(y(8)))+T44*log(y(2))*T43*log(y(2))+T43*log(y(2))*T44*(-log(y(8)))+T43*(-log(y(8)))*T44*(-log(y(8)));
T279 = exp(y(14))*1/y(7);
T283 = exp(y(14))*(-y(12))/(y(7)*y(7));
T288 = y(2)^(params(1)-1);
T294 = T106*T44*(-log(y(8)))+T44*(T288+params(1)*log(y(2))*T288);
T300 = y(8)^(1-params(1)-1);
T307 = T121*T43*log(y(2))+T43*((1-params(1))*(-log(y(8)))*T300-T300);
T319 = T256*T294;
T387 = y(2)^(params(1)-2);
T409 = y(8)^(1-params(1)-2);
T439 = y(6)/y(13)*exp((-y(14)));
T443 = exp((-y(14)))*1/y(13);
T445 = exp((-y(14)))*(-y(6))/(y(13)*y(13));
T448 = y(6)/y(13)*(-exp((-y(14))));
T501 = (-1)/(params(4)*params(4));
T503 = T501*log(T11);
T504 = T15*T503;
T509 = log(T11)*(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4));
T514 = T11^(T14-1);
T518 = T14*T503*T514+T501*T514;
T529 = T501*T503*T514+T14*(T509*T514+T503*T503*T514)+T501*T503*T514+(params(4)+params(4))/(params(4)*params(4)*params(4)*params(4))*T514;
T533 = T11^(T14-2);
rp = zeros(7, 6);
rp(1, 1) = y(5)/y(6);
rp(1, 4) = T504;
rp(2, 1) = T30*T246;
rp(2, 2) = T39*T439;
rp(2, 3) = (-T30);
rp(3, 1) = (-(T49*T255+T43*T44*T256));
rp(4, 3) = exp((-y(9)))*(-y(2));
rp(5, 5) = (-y(3));
rp(6, 6) = (-y(4));
gp = zeros(7, 16, 6);
gp(1, 5, 1) = 1/y(6);
gp(1, 6, 1) = (-y(5))/(y(6)*y(6));
gp(1, 8, 4) = T118*T518;
gp(1, 10, 4) = T142*T518;
gp(2, 12, 1) = T30*T279;
gp(2, 12, 2) = T90*T439;
gp(2, 6, 1) = T98*T246;
gp(2, 6, 2) = T39*T443;
gp(2, 6, 3) = (-T98);
gp(2, 13, 1) = T104*T246;
gp(2, 13, 2) = T39*T445;
gp(2, 13, 3) = (-T104);
gp(2, 7, 1) = T30*T283;
gp(2, 7, 2) = T116*T439;
gp(2, 14, 1) = T30*T246+T134*T246;
gp(2, 14, 2) = T39*T448+T36*T439;
gp(2, 14, 3) = (-T134);
gp(3, 2, 1) = (-(T44*T106*T256+T49*T294));
gp(3, 8, 1) = (-(T43*T121*T256+T49*T307));
gp(3, 9, 1) = (-((-params(1))*T49*T255+T43*T44*((-T49)+(-params(1))*T256)));
gp(4, 2, 3) = (-exp((-y(9))));
gp(4, 9, 3) = (-exp((-y(9))))*(-y(2));
gp(5, 3, 5) = (-1);
gp(6, 4, 6) = (-1);
if nargout >= 3
rpp = zeros(4,4);
rpp(1,1)=1;
rpp(1,2)=4;
rpp(1,3)=4;
rpp(1,4)=T503*T504+T15*T509;
rpp(2,1)=2;
rpp(2,2)=1;
rpp(2,3)=2;
rpp(2,4)=T246*T439;
rpp(3,1)=2;
rpp(3,2)=2;
rpp(3,3)=3;
rpp(3,4)=(-T439);
rpp(4,1)=3;
rpp(4,2)=1;
rpp(4,3)=1;
rpp(4,4)=(-(T255*T256+T49*T268+T255*T256+T43*T44*(-y(9))*T256));
gpp = zeros(13,5);
gpp(1,1)=1;
gpp(1,2)=8;
gpp(1,3)=4;
gpp(1,4)=4;
gpp(1,5)=T118*T529;
gpp(2,1)=1;
gpp(2,2)=10;
gpp(2,3)=4;
gpp(2,4)=4;
gpp(2,5)=T142*T529;
gpp(3,1)=2;
gpp(3,2)=12;
gpp(3,3)=1;
gpp(3,4)=2;
gpp(3,5)=T279*T439;
gpp(4,1)=2;
gpp(4,2)=6;
gpp(4,3)=1;
gpp(4,4)=2;
gpp(4,5)=T246*T443;
gpp(5,1)=2;
gpp(5,2)=6;
gpp(5,3)=2;
gpp(5,4)=3;
gpp(5,5)=(-T443);
gpp(6,1)=2;
gpp(6,2)=13;
gpp(6,3)=1;
gpp(6,4)=2;
gpp(6,5)=T246*T445;
gpp(7,1)=2;
gpp(7,2)=13;
gpp(7,3)=2;
gpp(7,4)=3;
gpp(7,5)=(-T445);
gpp(8,1)=2;
gpp(8,2)=7;
gpp(8,3)=1;
gpp(8,4)=2;
gpp(8,5)=T283*T439;
gpp(9,1)=2;
gpp(9,2)=14;
gpp(9,3)=1;
gpp(9,4)=2;
gpp(9,5)=T246*T439+T246*T448;
gpp(10,1)=2;
gpp(10,2)=14;
gpp(10,3)=2;
gpp(10,4)=3;
gpp(10,5)=(-T448);
gpp(11,1)=3;
gpp(11,2)=2;
gpp(11,3)=1;
gpp(11,4)=1;
gpp(11,5)=(-(T319+T44*T106*(-y(9))*T256+T319+T49*(T44*(-log(y(8)))*(T288+params(1)*log(y(2))*T288)+T106*(-log(y(8)))*T44*(-log(y(8)))+T44*(-log(y(8)))*(T288+params(1)*log(y(2))*T288)+T44*(log(y(2))*T288+log(y(2))*T288+params(1)*log(y(2))*log(y(2))*T288))));
gpp(12,1)=3;
gpp(12,2)=8;
gpp(12,3)=1;
gpp(12,4)=1;
gpp(12,5)=(-(T256*T307+T43*T121*(-y(9))*T256+T256*T307+T49*(T43*log(y(2))*((1-params(1))*(-log(y(8)))*T300-T300)+T121*log(y(2))*T43*log(y(2))+T43*log(y(2))*((1-params(1))*(-log(y(8)))*T300-T300)+T43*((-((-log(y(8)))*T300))+(1-params(1))*(-log(y(8)))*(-log(y(8)))*T300-(-log(y(8)))*T300))));
gpp(13,1)=3;
gpp(13,2)=9;
gpp(13,3)=1;
gpp(13,4)=1;
gpp(13,5)=(-(T255*((-T49)+(-params(1))*T256)+(-params(1))*T49*T268+T255*((-T49)+(-params(1))*T256)+T43*T44*((-T256)+(-T256)+(-params(1))*(-y(9))*T256)));
end
if nargout >= 5
hp = zeros(44,5);
hp(1,1)=1;
hp(1,2)=6;
hp(1,3)=5;
hp(1,4)=1;
hp(1,5)=(-1)/(y(6)*y(6));
hp(2,1)=1;
hp(2,2)=6;
hp(2,3)=6;
hp(2,4)=1;
hp(2,5)=(-((-y(5))*(y(6)+y(6))))/(y(6)*y(6)*y(6)*y(6));
hp(3,1)=1;
hp(3,2)=8;
hp(3,3)=8;
hp(3,4)=4;
hp(3,5)=T118*T118*((T14-1)*T14*T503*T533+T533*T501*(T14+T14-1));
hp(4,1)=1;
hp(4,2)=10;
hp(4,3)=8;
hp(4,4)=4;
hp(4,5)=T142*T118*((T14-1)*T14*T503*T533+T533*T501*(T14+T14-1))+(-exp(y(10)))/(exp(y(10))*exp(y(10)))*T518;
hp(5,1)=1;
hp(5,2)=10;
hp(5,3)=10;
hp(5,4)=4;
hp(5,5)=T142*T142*((T14-1)*T14*T503*T533+T533*T501*(T14+T14-1))+((-(y(8)*exp(y(10))))*exp(y(10))*exp(y(10))-(-(y(8)*exp(y(10))))*(exp(y(10))*exp(y(10))+exp(y(10))*exp(y(10))))/(exp(y(10))*exp(y(10))*exp(y(10))*exp(y(10)))*T518;
hp(6,1)=2;
hp(6,2)=6;
hp(6,3)=12;
hp(6,4)=1;
hp(6,5)=T98*T279;
hp(7,1)=2;
hp(7,2)=6;
hp(7,3)=12;
hp(7,4)=2;
hp(7,5)=T90*T443;
hp(8,1)=2;
hp(8,2)=13;
hp(8,3)=12;
hp(8,4)=1;
hp(8,5)=T104*T279;
hp(9,1)=2;
hp(9,2)=13;
hp(9,3)=12;
hp(9,4)=2;
hp(9,5)=T90*T445;
hp(10,1)=2;
hp(10,2)=13;
hp(10,3)=6;
hp(10,4)=1;
hp(10,5)=exp((-y(14)))*params(2)*(-1)/(y(13)*y(13))*T246;
hp(11,1)=2;
hp(11,2)=13;
hp(11,3)=6;
hp(11,4)=2;
hp(11,5)=T39*exp((-y(14)))*(-1)/(y(13)*y(13));
hp(12,1)=2;
hp(12,2)=13;
hp(12,3)=6;
hp(12,4)=3;
hp(12,5)=(-(exp((-y(14)))*params(2)*(-1)/(y(13)*y(13))));
hp(13,1)=2;
hp(13,2)=13;
hp(13,3)=13;
hp(13,4)=1;
hp(13,5)=T184*T246;
hp(14,1)=2;
hp(14,2)=13;
hp(14,3)=13;
hp(14,4)=2;
hp(14,5)=T39*exp((-y(14)))*(-((-y(6))*(y(13)+y(13))))/(y(13)*y(13)*y(13)*y(13));
hp(15,1)=2;
hp(15,2)=13;
hp(15,3)=13;
hp(15,4)=3;
hp(15,5)=(-T184);
hp(16,1)=2;
hp(16,2)=7;
hp(16,3)=12;
hp(16,4)=1;
hp(16,5)=T30*exp(y(14))*(-1)/(y(7)*y(7));
hp(17,1)=2;
hp(17,2)=7;
hp(17,3)=12;
hp(17,4)=2;
hp(17,5)=exp(y(14))*params(1)*(-1)/(y(7)*y(7))*T439;
hp(18,1)=2;
hp(18,2)=7;
hp(18,3)=6;
hp(18,4)=1;
hp(18,5)=T98*T283;
hp(19,1)=2;
hp(19,2)=7;
hp(19,3)=6;
hp(19,4)=2;
hp(19,5)=T116*T443;
hp(20,1)=2;
hp(20,2)=7;
hp(20,3)=13;
hp(20,4)=1;
hp(20,5)=T104*T283;
hp(21,1)=2;
hp(21,2)=7;
hp(21,3)=13;
hp(21,4)=2;
hp(21,5)=T116*T445;
hp(22,1)=2;
hp(22,2)=7;
hp(22,3)=7;
hp(22,4)=1;
hp(22,5)=T30*exp(y(14))*(-((-y(12))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7));
hp(23,1)=2;
hp(23,2)=7;
hp(23,3)=7;
hp(23,4)=2;
hp(23,5)=exp(y(14))*params(1)*(-((-y(12))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7))*T439;
hp(24,1)=2;
hp(24,2)=14;
hp(24,3)=12;
hp(24,4)=1;
hp(24,5)=T30*T279+T134*T279;
hp(25,1)=2;
hp(25,2)=14;
hp(25,3)=12;
hp(25,4)=2;
hp(25,5)=T90*T439+T90*T448;
hp(26,1)=2;
hp(26,2)=14;
hp(26,3)=6;
hp(26,4)=1;
hp(26,5)=T98*T246+params(2)*1/y(13)*(-exp((-y(14))))*T246;
hp(27,1)=2;
hp(27,2)=14;
hp(27,3)=6;
hp(27,4)=2;
hp(27,5)=T39*1/y(13)*(-exp((-y(14))))+T36*T443;
hp(28,1)=2;
hp(28,2)=14;
hp(28,3)=6;
hp(28,4)=3;
hp(28,5)=(-(params(2)*1/y(13)*(-exp((-y(14))))));
hp(29,1)=2;
hp(29,2)=14;
hp(29,3)=13;
hp(29,4)=1;
hp(29,5)=T104*T246+params(2)*(-y(6))/(y(13)*y(13))*(-exp((-y(14))))*T246;
hp(30,1)=2;
hp(30,2)=14;
hp(30,3)=13;
hp(30,4)=2;
hp(30,5)=T39*(-y(6))/(y(13)*y(13))*(-exp((-y(14))))+T36*T445;
hp(31,1)=2;
hp(31,2)=14;
hp(31,3)=13;
hp(31,4)=3;
hp(31,5)=(-(params(2)*(-y(6))/(y(13)*y(13))*(-exp((-y(14))))));
hp(32,1)=2;
hp(32,2)=14;
hp(32,3)=7;
hp(32,4)=1;
hp(32,5)=T30*T283+T134*T283;
hp(33,1)=2;
hp(33,2)=14;
hp(33,3)=7;
hp(33,4)=2;
hp(33,5)=T116*T439+T116*T448;
hp(34,1)=2;
hp(34,2)=14;
hp(34,3)=14;
hp(34,4)=1;
hp(34,5)=T30*T246+T134*T246+T30*T246+T134*T246;
hp(35,1)=2;
hp(35,2)=14;
hp(35,3)=14;
hp(35,4)=2;
hp(35,5)=T39*T439+T36*T448+T36*T439+T36*T448;
hp(36,1)=2;
hp(36,2)=14;
hp(36,3)=14;
hp(36,4)=3;
hp(36,5)=(-T30);
hp(37,1)=3;
hp(37,2)=2;
hp(37,3)=2;
hp(37,4)=1;
hp(37,5)=(-(T44*T216*T256+T49*(T216*T44*(-log(y(8)))+T44*((params(1)-1)*params(1)*log(y(2))*T387+T387*(params(1)+params(1)-1)))));
hp(38,1)=3;
hp(38,2)=8;
hp(38,3)=2;
hp(38,4)=1;
hp(38,5)=(-(T106*T121*T256+T49*(T121*(T288+params(1)*log(y(2))*T288)+T106*((1-params(1))*(-log(y(8)))*T300-T300))));
hp(39,1)=3;
hp(39,2)=8;
hp(39,3)=8;
hp(39,4)=1;
hp(39,5)=(-(T43*T223*T256+T49*(T223*T43*log(y(2))+T43*((1-params(1)-1)*(1-params(1))*(-log(y(8)))*T409+T409*(-(1-params(1)+1-params(1)-1))))));
hp(40,1)=3;
hp(40,2)=9;
hp(40,3)=2;
hp(40,4)=1;
hp(40,5)=(-((-params(1))*T49*T294+T44*T106*((-T49)+(-params(1))*T256)));
hp(41,1)=3;
hp(41,2)=9;
hp(41,3)=8;
hp(41,4)=1;
hp(41,5)=(-((-params(1))*T49*T307+T43*T121*((-T49)+(-params(1))*T256)));
hp(42,1)=3;
hp(42,2)=9;
hp(42,3)=9;
hp(42,4)=1;
hp(42,5)=(-((-params(1))*(-params(1))*T49*T255+T43*T44*((-((-params(1))*T49))+(-params(1))*((-T49)+(-params(1))*T256))));
hp(43,1)=4;
hp(43,2)=9;
hp(43,3)=2;
hp(43,4)=3;
hp(43,5)=exp((-y(9)));
hp(44,1)=4;
hp(44,2)=9;
hp(44,3)=9;
hp(44,4)=3;
hp(44,5)=exp((-y(9)))*(-y(2));
end
end
