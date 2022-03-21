function [residual, g1, g2, g3] = Model_Mensual_ARMA_7_12_29Enero2018_static(y, x, params)
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

residual = zeros( 94, 1);

%
% Model equations
%

lhs =y(3);
rhs =y(3)-params(11)*y(2)+y(14);
residual(1)= lhs-rhs;
lhs =y(1);
rhs =y(1)*params(17)+(1-params(17))*(params(15)*y(4)+y(3)*params(16))+y(16);
residual(2)= lhs-rhs;
lhs =y(4);
rhs =y(3)*params(23)+(1-params(21))*y(5)+params(21)*y(5)+y(15);
residual(3)= lhs-rhs;
lhs =y(6);
rhs =params(9)*x(4)+params(8)*x(4)+params(7)*x(4)+x(4)+y(6)*params(2)+y(6)*params(3)+y(6)*params(4)+y(6)*params(5)+x(4)*params(6);
residual(4)= lhs-rhs;
lhs =y(14);
rhs =y(14)*params(24)+x(1);
residual(5)= lhs-rhs;
lhs =y(15);
rhs =y(15)*params(25)+x(2);
residual(6)= lhs-rhs;
lhs =y(16);
rhs =y(16)*params(26)+x(3);
residual(7)= lhs-rhs;
lhs =y(1);
rhs =y(2)+y(4);
residual(8)= lhs-rhs;
lhs =y(5);
rhs =y(4)*(1-params(1))+y(6)*params(1);
residual(9)= lhs-rhs;
lhs =y(7);
rhs =(y(4)+y(4)+y(4)+y(4)+y(4)+y(4)+y(4)+y(4)+y(4)+y(4)+y(4)+y(4))/12;
residual(10)= lhs-rhs;
lhs =y(8);
rhs =(y(5)+y(5)+y(5)+y(5)+y(5)+y(5)+y(5)+y(5)+y(5)+y(5)+y(5)+y(5))/12;
residual(11)= lhs-rhs;
lhs =y(9);
rhs =(y(6)+y(6)+y(6)+y(6)+y(6)+y(6)+y(6)+y(6)+y(6)+y(6)+y(6)+y(6))/12;
residual(12)= lhs-rhs;
lhs =y(10);
rhs =y(7);
residual(13)= lhs-rhs;
lhs =y(11);
rhs =y(8);
residual(14)= lhs-rhs;
lhs =y(13);
rhs =y(4)-y(15);
residual(15)= lhs-rhs;
lhs =y(12);
rhs =(y(13)+y(13)+y(13)+y(13)+y(13)+y(13)+y(13)+y(13)+y(13)+y(13)+y(13)+y(13))/12;
residual(16)= lhs-rhs;
lhs =y(19);
rhs =y(5);
residual(17)= lhs-rhs;
lhs =y(17);
rhs =params(28);
residual(18)= lhs-rhs;
lhs =y(18);
rhs =y(1);
residual(19)= lhs-rhs;
lhs =y(20);
rhs =y(6)+y(17);
residual(20)= lhs-rhs;
lhs =y(21);
rhs =y(7);
residual(21)= lhs-rhs;
lhs =y(22);
rhs =y(7);
residual(22)= lhs-rhs;
lhs =y(23);
rhs =y(7);
residual(23)= lhs-rhs;
lhs =y(24);
rhs =y(7);
residual(24)= lhs-rhs;
lhs =y(25);
rhs =y(7);
residual(25)= lhs-rhs;
lhs =y(26);
rhs =y(7);
residual(26)= lhs-rhs;
lhs =y(27);
rhs =y(7);
residual(27)= lhs-rhs;
lhs =y(28);
rhs =y(7);
residual(28)= lhs-rhs;
lhs =y(29);
rhs =y(7);
residual(29)= lhs-rhs;
lhs =y(30);
rhs =y(7);
residual(30)= lhs-rhs;
lhs =y(31);
rhs =y(7);
residual(31)= lhs-rhs;
lhs =y(32);
rhs =y(8);
residual(32)= lhs-rhs;
lhs =y(33);
rhs =y(8);
residual(33)= lhs-rhs;
lhs =y(34);
rhs =y(8);
residual(34)= lhs-rhs;
lhs =y(35);
rhs =y(8);
residual(35)= lhs-rhs;
lhs =y(36);
rhs =y(8);
residual(36)= lhs-rhs;
lhs =y(37);
rhs =y(8);
residual(37)= lhs-rhs;
lhs =y(38);
rhs =y(8);
residual(38)= lhs-rhs;
lhs =y(39);
rhs =y(8);
residual(39)= lhs-rhs;
lhs =y(40);
rhs =y(8);
residual(40)= lhs-rhs;
lhs =y(41);
rhs =y(8);
residual(41)= lhs-rhs;
lhs =y(42);
rhs =y(8);
residual(42)= lhs-rhs;
lhs =y(43);
rhs =y(6);
residual(43)= lhs-rhs;
lhs =y(44);
rhs =y(6);
residual(44)= lhs-rhs;
lhs =y(45);
rhs =y(6);
residual(45)= lhs-rhs;
lhs =y(46);
rhs =y(6);
residual(46)= lhs-rhs;
lhs =y(47);
rhs =y(6);
residual(47)= lhs-rhs;
lhs =y(48);
rhs =y(6);
residual(48)= lhs-rhs;
lhs =y(49);
rhs =y(4);
residual(49)= lhs-rhs;
lhs =y(50);
rhs =y(4);
residual(50)= lhs-rhs;
lhs =y(51);
rhs =y(4);
residual(51)= lhs-rhs;
lhs =y(52);
rhs =y(4);
residual(52)= lhs-rhs;
lhs =y(53);
rhs =y(4);
residual(53)= lhs-rhs;
lhs =y(54);
rhs =y(4);
residual(54)= lhs-rhs;
lhs =y(55);
rhs =y(4);
residual(55)= lhs-rhs;
lhs =y(56);
rhs =y(4);
residual(56)= lhs-rhs;
lhs =y(57);
rhs =y(4);
residual(57)= lhs-rhs;
lhs =y(58);
rhs =y(4);
residual(58)= lhs-rhs;
lhs =y(59);
rhs =y(5);
residual(59)= lhs-rhs;
lhs =y(60);
rhs =y(5);
residual(60)= lhs-rhs;
lhs =y(61);
rhs =y(5);
residual(61)= lhs-rhs;
lhs =y(62);
rhs =y(5);
residual(62)= lhs-rhs;
lhs =y(63);
rhs =y(5);
residual(63)= lhs-rhs;
lhs =y(64);
rhs =y(5);
residual(64)= lhs-rhs;
lhs =y(65);
rhs =y(5);
residual(65)= lhs-rhs;
lhs =y(66);
rhs =y(5);
residual(66)= lhs-rhs;
lhs =y(67);
rhs =y(5);
residual(67)= lhs-rhs;
lhs =y(68);
rhs =y(5);
residual(68)= lhs-rhs;
lhs =y(69);
rhs =y(6);
residual(69)= lhs-rhs;
lhs =y(70);
rhs =y(6);
residual(70)= lhs-rhs;
lhs =y(71);
rhs =y(6);
residual(71)= lhs-rhs;
lhs =y(72);
rhs =y(6);
residual(72)= lhs-rhs;
lhs =y(73);
rhs =y(13);
residual(73)= lhs-rhs;
lhs =y(74);
rhs =y(13);
residual(74)= lhs-rhs;
lhs =y(75);
rhs =y(13);
residual(75)= lhs-rhs;
lhs =y(76);
rhs =y(13);
residual(76)= lhs-rhs;
lhs =y(77);
rhs =y(13);
residual(77)= lhs-rhs;
lhs =y(78);
rhs =y(13);
residual(78)= lhs-rhs;
lhs =y(79);
rhs =y(13);
residual(79)= lhs-rhs;
lhs =y(80);
rhs =y(13);
residual(80)= lhs-rhs;
lhs =y(81);
rhs =y(13);
residual(81)= lhs-rhs;
lhs =y(82);
rhs =y(13);
residual(82)= lhs-rhs;
lhs =y(83);
rhs =x(4);
residual(83)= lhs-rhs;
lhs =y(84);
rhs =x(4);
residual(84)= lhs-rhs;
lhs =y(85);
rhs =x(4);
residual(85)= lhs-rhs;
lhs =y(86);
rhs =x(4);
residual(86)= lhs-rhs;
lhs =y(87);
rhs =x(4);
residual(87)= lhs-rhs;
lhs =y(88);
rhs =x(4);
residual(88)= lhs-rhs;
lhs =y(89);
rhs =x(4);
residual(89)= lhs-rhs;
lhs =y(90);
rhs =x(4);
residual(90)= lhs-rhs;
lhs =y(91);
rhs =x(4);
residual(91)= lhs-rhs;
lhs =y(92);
rhs =x(4);
residual(92)= lhs-rhs;
lhs =y(93);
rhs =x(4);
residual(93)= lhs-rhs;
lhs =y(94);
rhs =x(4);
residual(94)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(94, 94);

  %
  % Jacobian matrix
  %

T3 = (-1);
  g1(1,2)=params(11);
  g1(1,14)=T3;
  g1(2,1)=1-params(17);
  g1(2,3)=(-((1-params(17))*params(16)));
  g1(2,4)=(-((1-params(17))*params(15)));
  g1(2,16)=T3;
  g1(3,3)=(-params(23));
  g1(3,4)=1;
  g1(3,5)=(-(params(21)+1-params(21)));
  g1(3,15)=T3;
  g1(4,6)=1-(params(5)+params(4)+params(2)+params(3));
  g1(5,14)=1-params(24);
  g1(6,15)=1-params(25);
  g1(7,16)=1-params(26);
  g1(8,1)=1;
  g1(8,2)=T3;
  g1(8,4)=T3;
  g1(9,4)=(-(1-params(1)));
  g1(9,5)=1;
  g1(9,6)=(-params(1));
  g1(10,4)=T3;
  g1(10,7)=1;
  g1(11,5)=T3;
  g1(11,8)=1;
  g1(12,6)=T3;
  g1(12,9)=1;
  g1(13,7)=T3;
  g1(13,10)=1;
  g1(14,8)=T3;
  g1(14,11)=1;
  g1(15,4)=T3;
  g1(15,13)=1;
  g1(15,15)=1;
  g1(16,12)=1;
  g1(16,13)=T3;
  g1(17,5)=T3;
  g1(17,19)=1;
  g1(18,17)=1;
  g1(19,1)=T3;
  g1(19,18)=1;
  g1(20,6)=T3;
  g1(20,17)=T3;
  g1(20,20)=1;
  g1(21,7)=T3;
  g1(21,21)=1;
  g1(22,7)=T3;
  g1(22,22)=1;
  g1(23,7)=T3;
  g1(23,23)=1;
  g1(24,7)=T3;
  g1(24,24)=1;
  g1(25,7)=T3;
  g1(25,25)=1;
  g1(26,7)=T3;
  g1(26,26)=1;
  g1(27,7)=T3;
  g1(27,27)=1;
  g1(28,7)=T3;
  g1(28,28)=1;
  g1(29,7)=T3;
  g1(29,29)=1;
  g1(30,7)=T3;
  g1(30,30)=1;
  g1(31,7)=T3;
  g1(31,31)=1;
  g1(32,8)=T3;
  g1(32,32)=1;
  g1(33,8)=T3;
  g1(33,33)=1;
  g1(34,8)=T3;
  g1(34,34)=1;
  g1(35,8)=T3;
  g1(35,35)=1;
  g1(36,8)=T3;
  g1(36,36)=1;
  g1(37,8)=T3;
  g1(37,37)=1;
  g1(38,8)=T3;
  g1(38,38)=1;
  g1(39,8)=T3;
  g1(39,39)=1;
  g1(40,8)=T3;
  g1(40,40)=1;
  g1(41,8)=T3;
  g1(41,41)=1;
  g1(42,8)=T3;
  g1(42,42)=1;
  g1(43,6)=T3;
  g1(43,43)=1;
  g1(44,6)=T3;
  g1(44,44)=1;
  g1(45,6)=T3;
  g1(45,45)=1;
  g1(46,6)=T3;
  g1(46,46)=1;
  g1(47,6)=T3;
  g1(47,47)=1;
  g1(48,6)=T3;
  g1(48,48)=1;
  g1(49,4)=T3;
  g1(49,49)=1;
  g1(50,4)=T3;
  g1(50,50)=1;
  g1(51,4)=T3;
  g1(51,51)=1;
  g1(52,4)=T3;
  g1(52,52)=1;
  g1(53,4)=T3;
  g1(53,53)=1;
  g1(54,4)=T3;
  g1(54,54)=1;
  g1(55,4)=T3;
  g1(55,55)=1;
  g1(56,4)=T3;
  g1(56,56)=1;
  g1(57,4)=T3;
  g1(57,57)=1;
  g1(58,4)=T3;
  g1(58,58)=1;
  g1(59,5)=T3;
  g1(59,59)=1;
  g1(60,5)=T3;
  g1(60,60)=1;
  g1(61,5)=T3;
  g1(61,61)=1;
  g1(62,5)=T3;
  g1(62,62)=1;
  g1(63,5)=T3;
  g1(63,63)=1;
  g1(64,5)=T3;
  g1(64,64)=1;
  g1(65,5)=T3;
  g1(65,65)=1;
  g1(66,5)=T3;
  g1(66,66)=1;
  g1(67,5)=T3;
  g1(67,67)=1;
  g1(68,5)=T3;
  g1(68,68)=1;
  g1(69,6)=T3;
  g1(69,69)=1;
  g1(70,6)=T3;
  g1(70,70)=1;
  g1(71,6)=T3;
  g1(71,71)=1;
  g1(72,6)=T3;
  g1(72,72)=1;
  g1(73,13)=T3;
  g1(73,73)=1;
  g1(74,13)=T3;
  g1(74,74)=1;
  g1(75,13)=T3;
  g1(75,75)=1;
  g1(76,13)=T3;
  g1(76,76)=1;
  g1(77,13)=T3;
  g1(77,77)=1;
  g1(78,13)=T3;
  g1(78,78)=1;
  g1(79,13)=T3;
  g1(79,79)=1;
  g1(80,13)=T3;
  g1(80,80)=1;
  g1(81,13)=T3;
  g1(81,81)=1;
  g1(82,13)=T3;
  g1(82,82)=1;
  g1(83,83)=1;
  g1(84,84)=1;
  g1(85,85)=1;
  g1(86,86)=1;
  g1(87,87)=1;
  g1(88,88)=1;
  g1(89,89)=1;
  g1(90,90)=1;
  g1(91,91)=1;
  g1(92,92)=1;
  g1(93,93)=1;
  g1(94,94)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],94,8836);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],94,830584);
end
end
end
end
