function [rp, gp, rpp, gpp, hp] = Ferroni_4_static_params_derivs(y, x, params)
%
% Status : Computes derivatives of the static model with respect to the parameters
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   rp        [M_.eq_nbr by #params] double    Jacobian matrix of static model equations with respect to parameters 
%                                              Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   gp        [M_.endo_nbr by M_.endo_nbr by #params] double    Derivative of the Jacobian matrix of the static model equations with respect to the parameters
%                                                           rows: variables in declaration order
%                                                           rows: equations in order of declaration
%   rpp       [#second_order_residual_terms by 4] double   Hessian matrix of second derivatives of residuals with respect to parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: number of the first parameter in derivative
%                                                              3rd column: number of the second parameter in derivative
%                                                              4th column: value of the Hessian term
%   gpp      [#second_order_Jacobian_terms by 5] double   Hessian matrix of second derivatives of the Jacobian with respect to the parameters;
%                                                              rows: respective derivative term
%                                                              1st column: equation number of the term appearing
%                                                              2nd column: column number of variable in Jacobian of the static model
%                                                              3rd column: number of the first parameter in derivative
%                                                              4th column: number of the second parameter in derivative
%                                                              5th column: value of the Hessian term
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

kratio__ = params(1)/(1/params(2)+params(3)-1);
cratio__ = 1-params(3)*kratio__;
T13 = 1/params(2)+params(3)-1;
T79 = 1/T13;
T84 = 1/kratio__+params(1)*(-T79)/(kratio__*kratio__);
T108 = (-T79)/(kratio__*kratio__)+(-T79)/(kratio__*kratio__)+params(1)*(-((-T79)*(kratio__*T79+kratio__*T79)))/(kratio__*kratio__*kratio__*kratio__);
T127 = (-(params(1)*(-1)/(params(2)*params(2))));
T128 = T13*T13;
T129 = T127/T128;
T132 = params(1)*(-T129)/(kratio__*kratio__);
T147 = (-((-1)/(params(2)*params(2))))/T128;
T156 = (-T129)/(kratio__*kratio__)+params(1)*(kratio__*kratio__*(-T147)-(-T79)*(kratio__*T129+kratio__*T129))/(kratio__*kratio__*kratio__*kratio__);
T173 = (T128*(-(params(1)*(params(2)+params(2))/(params(2)*params(2)*params(2)*params(2))))-T127*(T13*(-1)/(params(2)*params(2))+T13*(-1)/(params(2)*params(2))))/(T128*T128);
T179 = params(1)*(kratio__*kratio__*(-T173)-(-T129)*(kratio__*T129+kratio__*T129))/(kratio__*kratio__*kratio__*kratio__);
T232 = (-params(1))/T128;
T235 = params(1)*(-T232)/(kratio__*kratio__);
T251 = (-1)/T128;
T260 = (-T232)/(kratio__*kratio__)+params(1)*(kratio__*kratio__*(-T251)-(-T79)*(kratio__*T232+kratio__*T232))/(kratio__*kratio__*kratio__*kratio__);
T267 = (-(T127*(T13+T13)))/(T128*T128);
T273 = params(1)*(kratio__*kratio__*(-T267)-(-T129)*(kratio__*T232+kratio__*T232))/(kratio__*kratio__*kratio__*kratio__);
T280 = (-((-params(1))*(T13+T13)))/(T128*T128);
T286 = params(1)*(kratio__*kratio__*(-T280)-(-T232)*(kratio__*T232+kratio__*T232))/(kratio__*kratio__*kratio__*kratio__);
T361 = (params(4)+params(4))/(params(4)*params(4)*params(4)*params(4));
rp = zeros(8, 6);
rp(1, 4) = (y(4)-y(6))*(-1)/(params(4)*params(4));
rp(2, 1) = (-(params(2)*(y(1)-y(3))*T84));
rp(2, 2) = (-(params(1)*1/kratio__*(y(1)-y(3))+params(2)*(y(1)-y(3))*T132));
rp(2, 3) = (-(params(2)*(y(1)-y(3))*T235));
rp(3, 1) = (-(y(3)-(y(4)+y(5))));
rp(4, 1) = (-(y(2)*(-(params(3)*T79))+y(3)*T79-y(3)*(1-params(3))*T79));
rp(4, 2) = (-(y(2)*(-(params(3)*T129))+y(3)*T129-y(3)*(1-params(3))*T129));
rp(4, 3) = (-(y(2)*(-(kratio__+params(3)*T232))+y(3)*T232-y(3)*((1-params(3))*T232-kratio__)));
rp(5, 5) = (-y(5));
rp(6, 6) = (-y(6));
gp = zeros(8, 8, 6);
gp(1, 4, 4) = (-1)/(params(4)*params(4));
gp(1, 6, 4) = (-((-1)/(params(4)*params(4))));
gp(2, 1, 1) = (-(params(2)*T84));
gp(2, 1, 2) = (-(params(1)*1/kratio__+params(2)*T132));
gp(2, 1, 3) = (-(params(2)*T235));
gp(2, 3, 1) = (-(params(2)*(-T84)));
gp(2, 3, 2) = (-((-(params(1)*1/kratio__))+params(2)*(-T132)));
gp(2, 3, 3) = (-(params(2)*(-T235)));
gp(3, 3, 1) = (-1);
gp(3, 4, 1) = 1;
gp(3, 5, 1) = 1;
gp(4, 2, 1) = params(3)*T79;
gp(4, 2, 2) = params(3)*T129;
gp(4, 2, 3) = kratio__+params(3)*T232;
gp(4, 3, 1) = (-(T79-(1-params(3))*T79));
gp(4, 3, 2) = (-(T129-(1-params(3))*T129));
gp(4, 3, 3) = (-(T232-((1-params(3))*T232-kratio__)));
gp(5, 5, 5) = (-1);
gp(6, 6, 6) = (-1);
if nargout >= 3
rpp = zeros(12,4);
rpp(1,1)=1;
rpp(1,2)=4;
rpp(1,3)=4;
rpp(1,4)=(y(4)-y(6))*T361;
rpp(2,1)=2;
rpp(2,2)=1;
rpp(2,3)=1;
rpp(2,4)=(-(params(2)*(y(1)-y(3))*T108));
rpp(3,1)=2;
rpp(3,2)=1;
rpp(3,3)=2;
rpp(3,4)=(-((y(1)-y(3))*T84+params(2)*(y(1)-y(3))*T156));
rpp(4,1)=2;
rpp(4,2)=1;
rpp(4,3)=3;
rpp(4,4)=(-(params(2)*(y(1)-y(3))*T260));
rpp(5,1)=2;
rpp(5,2)=2;
rpp(5,3)=2;
rpp(5,4)=(-((y(1)-y(3))*T132+(y(1)-y(3))*T132+params(2)*(y(1)-y(3))*T179));
rpp(6,1)=2;
rpp(6,2)=2;
rpp(6,3)=3;
rpp(6,4)=(-((y(1)-y(3))*T235+params(2)*(y(1)-y(3))*T273));
rpp(7,1)=2;
rpp(7,2)=3;
rpp(7,3)=3;
rpp(7,4)=(-(params(2)*(y(1)-y(3))*T286));
rpp(8,1)=4;
rpp(8,2)=1;
rpp(8,3)=2;
rpp(8,4)=(-(y(2)*(-(params(3)*T147))+y(3)*T147-y(3)*(1-params(3))*T147));
rpp(9,1)=4;
rpp(9,2)=1;
rpp(9,3)=3;
rpp(9,4)=(-(y(2)*(-(T79+params(3)*T251))+y(3)*T251-y(3)*((-T79)+(1-params(3))*T251)));
rpp(10,1)=4;
rpp(10,2)=2;
rpp(10,3)=2;
rpp(10,4)=(-(y(2)*(-(params(3)*T173))+y(3)*T173-y(3)*(1-params(3))*T173));
rpp(11,1)=4;
rpp(11,2)=2;
rpp(11,3)=3;
rpp(11,4)=(-(y(2)*(-(T129+params(3)*T267))+y(3)*T267-y(3)*((-T129)+(1-params(3))*T267)));
rpp(12,1)=4;
rpp(12,2)=3;
rpp(12,3)=3;
rpp(12,4)=(-(y(2)*(-(T232+T232+params(3)*T280))+y(3)*T280-y(3)*((-T232)+(1-params(3))*T280-T232)));
gpp = zeros(24,5);
gpp(1,1)=1;
gpp(1,2)=4;
gpp(1,3)=4;
gpp(1,4)=4;
gpp(1,5)=T361;
gpp(2,1)=1;
gpp(2,2)=6;
gpp(2,3)=4;
gpp(2,4)=4;
gpp(2,5)=(-T361);
gpp(3,1)=2;
gpp(3,2)=1;
gpp(3,3)=1;
gpp(3,4)=1;
gpp(3,5)=(-(params(2)*T108));
gpp(4,1)=2;
gpp(4,2)=1;
gpp(4,3)=1;
gpp(4,4)=2;
gpp(4,5)=(-(T84+params(2)*T156));
gpp(5,1)=2;
gpp(5,2)=1;
gpp(5,3)=1;
gpp(5,4)=3;
gpp(5,5)=(-(params(2)*T260));
gpp(6,1)=2;
gpp(6,2)=1;
gpp(6,3)=2;
gpp(6,4)=2;
gpp(6,5)=(-(T132+T132+params(2)*T179));
gpp(7,1)=2;
gpp(7,2)=1;
gpp(7,3)=2;
gpp(7,4)=3;
gpp(7,5)=(-(T235+params(2)*T273));
gpp(8,1)=2;
gpp(8,2)=1;
gpp(8,3)=3;
gpp(8,4)=3;
gpp(8,5)=(-(params(2)*T286));
gpp(9,1)=2;
gpp(9,2)=3;
gpp(9,3)=1;
gpp(9,4)=1;
gpp(9,5)=(-(params(2)*(-T108)));
gpp(10,1)=2;
gpp(10,2)=3;
gpp(10,3)=1;
gpp(10,4)=2;
gpp(10,5)=(-((-T84)+params(2)*(-T156)));
gpp(11,1)=2;
gpp(11,2)=3;
gpp(11,3)=1;
gpp(11,4)=3;
gpp(11,5)=(-(params(2)*(-T260)));
gpp(12,1)=2;
gpp(12,2)=3;
gpp(12,3)=2;
gpp(12,4)=2;
gpp(12,5)=(-((-T132)+(-T132)+params(2)*(-T179)));
gpp(13,1)=2;
gpp(13,2)=3;
gpp(13,3)=2;
gpp(13,4)=3;
gpp(13,5)=(-((-T235)+params(2)*(-T273)));
gpp(14,1)=2;
gpp(14,2)=3;
gpp(14,3)=3;
gpp(14,4)=3;
gpp(14,5)=(-(params(2)*(-T286)));
gpp(15,1)=4;
gpp(15,2)=2;
gpp(15,3)=1;
gpp(15,4)=2;
gpp(15,5)=params(3)*T147;
gpp(16,1)=4;
gpp(16,2)=2;
gpp(16,3)=1;
gpp(16,4)=3;
gpp(16,5)=T79+params(3)*T251;
gpp(17,1)=4;
gpp(17,2)=2;
gpp(17,3)=2;
gpp(17,4)=2;
gpp(17,5)=params(3)*T173;
gpp(18,1)=4;
gpp(18,2)=2;
gpp(18,3)=2;
gpp(18,4)=3;
gpp(18,5)=T129+params(3)*T267;
gpp(19,1)=4;
gpp(19,2)=2;
gpp(19,3)=3;
gpp(19,4)=3;
gpp(19,5)=T232+T232+params(3)*T280;
gpp(20,1)=4;
gpp(20,2)=3;
gpp(20,3)=1;
gpp(20,4)=2;
gpp(20,5)=(-(T147-(1-params(3))*T147));
gpp(21,1)=4;
gpp(21,2)=3;
gpp(21,3)=1;
gpp(21,4)=3;
gpp(21,5)=(-(T251-((-T79)+(1-params(3))*T251)));
gpp(22,1)=4;
gpp(22,2)=3;
gpp(22,3)=2;
gpp(22,4)=2;
gpp(22,5)=(-(T173-(1-params(3))*T173));
gpp(23,1)=4;
gpp(23,2)=3;
gpp(23,3)=2;
gpp(23,4)=3;
gpp(23,5)=(-(T267-((-T129)+(1-params(3))*T267)));
gpp(24,1)=4;
gpp(24,2)=3;
gpp(24,3)=3;
gpp(24,4)=3;
gpp(24,5)=(-(T280-((-T232)+(1-params(3))*T280-T232)));
end
if nargout >= 5
hp = zeros(0,5);
end
end
