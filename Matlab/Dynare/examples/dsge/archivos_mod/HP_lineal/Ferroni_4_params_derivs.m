function [rp, gp, rpp, gpp, hp] = Ferroni_4_params_derivs(y, x, params, steady_state, it_, ss_param_deriv, ss_param_2nd_deriv)
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

kratio__ = params(1)/(1/params(2)+params(3)-1);
cratio__ = 1-params(3)*kratio__;
T13 = 1/params(2)+params(3)-1;
T30 = params(1)*1/kratio__;
T95 = 1/T13;
T100 = 1/kratio__+params(1)*(-T95)/(kratio__*kratio__);
T124 = (-T95)/(kratio__*kratio__)+(-T95)/(kratio__*kratio__)+params(1)*(-((-T95)*(kratio__*T95+kratio__*T95)))/(kratio__*kratio__*kratio__*kratio__);
T141 = (-(params(1)*(-1)/(params(2)*params(2))));
T142 = T13*T13;
T143 = T141/T142;
T146 = params(1)*(-T143)/(kratio__*kratio__);
T161 = (-((-1)/(params(2)*params(2))))/T142;
T170 = (-T143)/(kratio__*kratio__)+params(1)*(kratio__*kratio__*(-T161)-(-T95)*(kratio__*T143+kratio__*T143))/(kratio__*kratio__*kratio__*kratio__);
T187 = (T142*(-(params(1)*(params(2)+params(2))/(params(2)*params(2)*params(2)*params(2))))-T141*(T13*(-1)/(params(2)*params(2))+T13*(-1)/(params(2)*params(2))))/(T142*T142);
T193 = params(1)*(kratio__*kratio__*(-T187)-(-T143)*(kratio__*T143+kratio__*T143))/(kratio__*kratio__*kratio__*kratio__);
T244 = (-params(1))/T142;
T247 = params(1)*(-T244)/(kratio__*kratio__);
T264 = (-1)/T142;
T273 = (-T244)/(kratio__*kratio__)+params(1)*(kratio__*kratio__*(-T264)-(-T95)*(kratio__*T244+kratio__*T244))/(kratio__*kratio__*kratio__*kratio__);
T280 = (-(T141*(T13+T13)))/(T142*T142);
T286 = params(1)*(kratio__*kratio__*(-T280)-(-T143)*(kratio__*T244+kratio__*T244))/(kratio__*kratio__*kratio__*kratio__);
T293 = (-((-params(1))*(T13+T13)))/(T142*T142);
T299 = params(1)*(kratio__*kratio__*(-T293)-(-T244)*(kratio__*T244+kratio__*T244))/(kratio__*kratio__*kratio__*kratio__);
T376 = (params(4)+params(4))/(params(4)*params(4)*params(4)*params(4));
rp = zeros(8, 6);
rp(1, 4) = (y(7)-y(9))*(-1)/(params(4)*params(4));
rp(2, 1) = (-(params(2)*(y(5)-y(13)+y(12)-y(6))*T100));
rp(2, 2) = (-(T30*(y(5)-y(13)+y(12)-y(6))+(y(5)-y(13))*(1-params(3))+params(2)*(y(5)-y(13)+y(12)-y(6))*T146));
rp(2, 3) = (-(params(2)*((y(5)-y(13)+y(12)-y(6))*T247-(y(5)-y(13)))));
rp(3, 1) = (-(y(1)-(y(7)+y(8))));
rp(4, 1) = (-(y(5)*(-(params(3)*T95))+y(6)*T95-y(1)*(1-params(3))*T95));
rp(4, 2) = (-(y(5)*(-(params(3)*T143))+y(6)*T143-y(1)*(1-params(3))*T143));
rp(4, 3) = (-(y(5)*(-(kratio__+params(3)*T244))+y(6)*T244-y(1)*((1-params(3))*T244-kratio__)));
rp(5, 5) = (-y(2));
rp(6, 6) = (-y(3));
gp = zeros(8, 15, 6);
gp(1, 7, 4) = (-1)/(params(4)*params(4));
gp(1, 9, 4) = (-((-1)/(params(4)*params(4))));
gp(2, 12, 1) = (-(params(2)*T100));
gp(2, 12, 2) = (-(T30+params(2)*T146));
gp(2, 12, 3) = (-(params(2)*T247));
gp(2, 5, 1) = (-(params(2)*T100));
gp(2, 5, 2) = (-(T30+1-params(3)+params(2)*T146));
gp(2, 5, 3) = (-(params(2)*(T247-1)));
gp(2, 13, 1) = (-(params(2)*(-T100)));
gp(2, 13, 2) = (-((-T30)-(1-params(3))+params(2)*(-T146)));
gp(2, 13, 3) = (-(params(2)*((-T247)-(-1))));
gp(2, 6, 1) = (-(params(2)*(-T100)));
gp(2, 6, 2) = (-((-T30)+params(2)*(-T146)));
gp(2, 6, 3) = (-(params(2)*(-T247)));
gp(3, 1, 1) = (-1);
gp(3, 7, 1) = 1;
gp(3, 8, 1) = 1;
gp(4, 5, 1) = params(3)*T95;
gp(4, 5, 2) = params(3)*T143;
gp(4, 5, 3) = kratio__+params(3)*T244;
gp(4, 1, 1) = (1-params(3))*T95;
gp(4, 1, 2) = (1-params(3))*T143;
gp(4, 1, 3) = (1-params(3))*T244-kratio__;
gp(4, 6, 1) = (-T95);
gp(4, 6, 2) = (-T143);
gp(4, 6, 3) = (-T244);
gp(5, 2, 5) = (-1);
gp(6, 3, 6) = (-1);
if nargout >= 3
rpp = zeros(12,4);
rpp(1,1)=1;
rpp(1,2)=4;
rpp(1,3)=4;
rpp(1,4)=(y(7)-y(9))*T376;
rpp(2,1)=2;
rpp(2,2)=1;
rpp(2,3)=1;
rpp(2,4)=(-(params(2)*(y(5)-y(13)+y(12)-y(6))*T124));
rpp(3,1)=2;
rpp(3,2)=1;
rpp(3,3)=2;
rpp(3,4)=(-((y(5)-y(13)+y(12)-y(6))*T100+params(2)*(y(5)-y(13)+y(12)-y(6))*T170));
rpp(4,1)=2;
rpp(4,2)=1;
rpp(4,3)=3;
rpp(4,4)=(-(params(2)*(y(5)-y(13)+y(12)-y(6))*T273));
rpp(5,1)=2;
rpp(5,2)=2;
rpp(5,3)=2;
rpp(5,4)=(-((y(5)-y(13)+y(12)-y(6))*T146+(y(5)-y(13)+y(12)-y(6))*T146+params(2)*(y(5)-y(13)+y(12)-y(6))*T193));
rpp(6,1)=2;
rpp(6,2)=2;
rpp(6,3)=3;
rpp(6,4)=(-((y(5)-y(13)+y(12)-y(6))*T247-(y(5)-y(13))+params(2)*(y(5)-y(13)+y(12)-y(6))*T286));
rpp(7,1)=2;
rpp(7,2)=3;
rpp(7,3)=3;
rpp(7,4)=(-(params(2)*(y(5)-y(13)+y(12)-y(6))*T299));
rpp(8,1)=4;
rpp(8,2)=1;
rpp(8,3)=2;
rpp(8,4)=(-(y(5)*(-(params(3)*T161))+y(6)*T161-y(1)*(1-params(3))*T161));
rpp(9,1)=4;
rpp(9,2)=1;
rpp(9,3)=3;
rpp(9,4)=(-(y(5)*(-(T95+params(3)*T264))+y(6)*T264-y(1)*((-T95)+(1-params(3))*T264)));
rpp(10,1)=4;
rpp(10,2)=2;
rpp(10,3)=2;
rpp(10,4)=(-(y(5)*(-(params(3)*T187))+y(6)*T187-y(1)*(1-params(3))*T187));
rpp(11,1)=4;
rpp(11,2)=2;
rpp(11,3)=3;
rpp(11,4)=(-(y(5)*(-(T143+params(3)*T280))+y(6)*T280-y(1)*((-T143)+(1-params(3))*T280)));
rpp(12,1)=4;
rpp(12,2)=3;
rpp(12,3)=3;
rpp(12,4)=(-(y(5)*(-(T244+T244+params(3)*T293))+y(6)*T293-y(1)*((-T244)+(1-params(3))*T293-T244)));
gpp = zeros(41,5);
gpp(1,1)=1;
gpp(1,2)=7;
gpp(1,3)=4;
gpp(1,4)=4;
gpp(1,5)=T376;
gpp(2,1)=1;
gpp(2,2)=9;
gpp(2,3)=4;
gpp(2,4)=4;
gpp(2,5)=(-T376);
gpp(3,1)=2;
gpp(3,2)=12;
gpp(3,3)=1;
gpp(3,4)=1;
gpp(3,5)=(-(params(2)*T124));
gpp(4,1)=2;
gpp(4,2)=12;
gpp(4,3)=1;
gpp(4,4)=2;
gpp(4,5)=(-(T100+params(2)*T170));
gpp(5,1)=2;
gpp(5,2)=12;
gpp(5,3)=1;
gpp(5,4)=3;
gpp(5,5)=(-(params(2)*T273));
gpp(6,1)=2;
gpp(6,2)=12;
gpp(6,3)=2;
gpp(6,4)=2;
gpp(6,5)=(-(T146+T146+params(2)*T193));
gpp(7,1)=2;
gpp(7,2)=12;
gpp(7,3)=2;
gpp(7,4)=3;
gpp(7,5)=(-(T247+params(2)*T286));
gpp(8,1)=2;
gpp(8,2)=12;
gpp(8,3)=3;
gpp(8,4)=3;
gpp(8,5)=(-(params(2)*T299));
gpp(9,1)=2;
gpp(9,2)=5;
gpp(9,3)=1;
gpp(9,4)=1;
gpp(9,5)=(-(params(2)*T124));
gpp(10,1)=2;
gpp(10,2)=5;
gpp(10,3)=1;
gpp(10,4)=2;
gpp(10,5)=(-(T100+params(2)*T170));
gpp(11,1)=2;
gpp(11,2)=5;
gpp(11,3)=1;
gpp(11,4)=3;
gpp(11,5)=(-(params(2)*T273));
gpp(12,1)=2;
gpp(12,2)=5;
gpp(12,3)=2;
gpp(12,4)=2;
gpp(12,5)=(-(T146+T146+params(2)*T193));
gpp(13,1)=2;
gpp(13,2)=5;
gpp(13,3)=2;
gpp(13,4)=3;
gpp(13,5)=(-(T247-1+params(2)*T286));
gpp(14,1)=2;
gpp(14,2)=5;
gpp(14,3)=3;
gpp(14,4)=3;
gpp(14,5)=(-(params(2)*T299));
gpp(15,1)=2;
gpp(15,2)=13;
gpp(15,3)=1;
gpp(15,4)=1;
gpp(15,5)=(-(params(2)*(-T124)));
gpp(16,1)=2;
gpp(16,2)=13;
gpp(16,3)=1;
gpp(16,4)=2;
gpp(16,5)=(-((-T100)+params(2)*(-T170)));
gpp(17,1)=2;
gpp(17,2)=13;
gpp(17,3)=1;
gpp(17,4)=3;
gpp(17,5)=(-(params(2)*(-T273)));
gpp(18,1)=2;
gpp(18,2)=13;
gpp(18,3)=2;
gpp(18,4)=2;
gpp(18,5)=(-((-T146)+(-T146)+params(2)*(-T193)));
gpp(19,1)=2;
gpp(19,2)=13;
gpp(19,3)=2;
gpp(19,4)=3;
gpp(19,5)=(-((-T247)-(-1)+params(2)*(-T286)));
gpp(20,1)=2;
gpp(20,2)=13;
gpp(20,3)=3;
gpp(20,4)=3;
gpp(20,5)=(-(params(2)*(-T299)));
gpp(21,1)=2;
gpp(21,2)=6;
gpp(21,3)=1;
gpp(21,4)=1;
gpp(21,5)=(-(params(2)*(-T124)));
gpp(22,1)=2;
gpp(22,2)=6;
gpp(22,3)=1;
gpp(22,4)=2;
gpp(22,5)=(-((-T100)+params(2)*(-T170)));
gpp(23,1)=2;
gpp(23,2)=6;
gpp(23,3)=1;
gpp(23,4)=3;
gpp(23,5)=(-(params(2)*(-T273)));
gpp(24,1)=2;
gpp(24,2)=6;
gpp(24,3)=2;
gpp(24,4)=2;
gpp(24,5)=(-((-T146)+(-T146)+params(2)*(-T193)));
gpp(25,1)=2;
gpp(25,2)=6;
gpp(25,3)=2;
gpp(25,4)=3;
gpp(25,5)=(-((-T247)+params(2)*(-T286)));
gpp(26,1)=2;
gpp(26,2)=6;
gpp(26,3)=3;
gpp(26,4)=3;
gpp(26,5)=(-(params(2)*(-T299)));
gpp(27,1)=4;
gpp(27,2)=5;
gpp(27,3)=1;
gpp(27,4)=2;
gpp(27,5)=params(3)*T161;
gpp(28,1)=4;
gpp(28,2)=5;
gpp(28,3)=1;
gpp(28,4)=3;
gpp(28,5)=T95+params(3)*T264;
gpp(29,1)=4;
gpp(29,2)=5;
gpp(29,3)=2;
gpp(29,4)=2;
gpp(29,5)=params(3)*T187;
gpp(30,1)=4;
gpp(30,2)=5;
gpp(30,3)=2;
gpp(30,4)=3;
gpp(30,5)=T143+params(3)*T280;
gpp(31,1)=4;
gpp(31,2)=5;
gpp(31,3)=3;
gpp(31,4)=3;
gpp(31,5)=T244+T244+params(3)*T293;
gpp(32,1)=4;
gpp(32,2)=1;
gpp(32,3)=1;
gpp(32,4)=2;
gpp(32,5)=(1-params(3))*T161;
gpp(33,1)=4;
gpp(33,2)=1;
gpp(33,3)=1;
gpp(33,4)=3;
gpp(33,5)=(-T95)+(1-params(3))*T264;
gpp(34,1)=4;
gpp(34,2)=1;
gpp(34,3)=2;
gpp(34,4)=2;
gpp(34,5)=(1-params(3))*T187;
gpp(35,1)=4;
gpp(35,2)=1;
gpp(35,3)=2;
gpp(35,4)=3;
gpp(35,5)=(-T143)+(1-params(3))*T280;
gpp(36,1)=4;
gpp(36,2)=1;
gpp(36,3)=3;
gpp(36,4)=3;
gpp(36,5)=(-T244)+(1-params(3))*T293-T244;
gpp(37,1)=4;
gpp(37,2)=6;
gpp(37,3)=1;
gpp(37,4)=2;
gpp(37,5)=(-T161);
gpp(38,1)=4;
gpp(38,2)=6;
gpp(38,3)=1;
gpp(38,4)=3;
gpp(38,5)=(-T264);
gpp(39,1)=4;
gpp(39,2)=6;
gpp(39,3)=2;
gpp(39,4)=2;
gpp(39,5)=(-T187);
gpp(40,1)=4;
gpp(40,2)=6;
gpp(40,3)=2;
gpp(40,4)=3;
gpp(40,5)=(-T280);
gpp(41,1)=4;
gpp(41,2)=6;
gpp(41,3)=3;
gpp(41,4)=3;
gpp(41,5)=(-T293);
end
if nargout >= 5
hp = zeros(0,5);
end
end
