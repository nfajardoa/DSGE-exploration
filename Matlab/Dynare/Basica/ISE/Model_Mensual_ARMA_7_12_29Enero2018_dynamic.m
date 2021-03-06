function [residual, g1, g2, g3] = Model_Mensual_ARMA_7_12_29Enero2018_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(94, 1);
lhs =y(63);
rhs =y(155)-params(11)*y(62)+y(74);
residual(1)= lhs-rhs;
lhs =y(61);
rhs =params(17)*y(1)+(1-params(17))*(params(15)*y(64)+y(63)*params(16))+y(76);
residual(2)= lhs-rhs;
lhs =y(64);
rhs =y(63)*params(23)+(1-params(21))*y(157)+params(21)*y(3)+y(75);
residual(3)= lhs-rhs;
lhs =y(66);
rhs =params(9)*y(60)+params(8)*y(58)+params(7)*y(51)+x(it_, 4)+params(2)*y(4)+params(3)*y(9)+params(4)*y(10)+params(5)*y(14)+params(6)*y(49);
residual(4)= lhs-rhs;
lhs =y(74);
rhs =params(24)*y(6)+x(it_, 1);
residual(5)= lhs-rhs;
lhs =y(75);
rhs =params(25)*y(7)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(76);
rhs =params(26)*y(8)+x(it_, 3);
residual(7)= lhs-rhs;
lhs =y(61);
rhs =y(62)+y(156);
residual(8)= lhs-rhs;
lhs =y(65);
rhs =y(64)*(1-params(1))+y(66)*params(1);
residual(9)= lhs-rhs;
lhs =y(67);
rhs =(y(64)+y(2)+y(15)+y(16)+y(17)+y(18)+y(19)+y(20)+y(21)+y(22)+y(23)+y(24))/12;
residual(10)= lhs-rhs;
lhs =y(68);
rhs =(y(3)+y(65)+y(25)+y(26)+y(27)+y(28)+y(29)+y(30)+y(31)+y(32)+y(33)+y(34))/12;
residual(11)= lhs-rhs;
lhs =y(69);
rhs =(y(14)+y(13)+y(12)+y(11)+y(10)+y(66)+y(4)+y(9)+y(35)+y(36)+y(37)+y(38))/12;
residual(12)= lhs-rhs;
lhs =y(70);
rhs =y(170);
residual(13)= lhs-rhs;
lhs =y(71);
rhs =y(181);
residual(14)= lhs-rhs;
lhs =y(73);
rhs =y(64)-y(75);
residual(15)= lhs-rhs;
lhs =y(72);
rhs =(y(73)+y(5)+y(39)+y(40)+y(41)+y(42)+y(43)+y(44)+y(45)+y(46)+y(47)+y(48))/12;
residual(16)= lhs-rhs;
lhs =y(79);
rhs =y(65);
residual(17)= lhs-rhs;
lhs =y(77);
rhs =params(28);
residual(18)= lhs-rhs;
lhs =y(78);
rhs =y(61);
residual(19)= lhs-rhs;
lhs =y(80);
rhs =y(66)+y(77);
residual(20)= lhs-rhs;
lhs =y(81);
rhs =y(158);
residual(21)= lhs-rhs;
lhs =y(82);
rhs =y(160);
residual(22)= lhs-rhs;
lhs =y(83);
rhs =y(161);
residual(23)= lhs-rhs;
lhs =y(84);
rhs =y(162);
residual(24)= lhs-rhs;
lhs =y(85);
rhs =y(163);
residual(25)= lhs-rhs;
lhs =y(86);
rhs =y(164);
residual(26)= lhs-rhs;
lhs =y(87);
rhs =y(165);
residual(27)= lhs-rhs;
lhs =y(88);
rhs =y(166);
residual(28)= lhs-rhs;
lhs =y(89);
rhs =y(167);
residual(29)= lhs-rhs;
lhs =y(90);
rhs =y(168);
residual(30)= lhs-rhs;
lhs =y(91);
rhs =y(169);
residual(31)= lhs-rhs;
lhs =y(92);
rhs =y(159);
residual(32)= lhs-rhs;
lhs =y(93);
rhs =y(171);
residual(33)= lhs-rhs;
lhs =y(94);
rhs =y(172);
residual(34)= lhs-rhs;
lhs =y(95);
rhs =y(173);
residual(35)= lhs-rhs;
lhs =y(96);
rhs =y(174);
residual(36)= lhs-rhs;
lhs =y(97);
rhs =y(175);
residual(37)= lhs-rhs;
lhs =y(98);
rhs =y(176);
residual(38)= lhs-rhs;
lhs =y(99);
rhs =y(177);
residual(39)= lhs-rhs;
lhs =y(100);
rhs =y(178);
residual(40)= lhs-rhs;
lhs =y(101);
rhs =y(179);
residual(41)= lhs-rhs;
lhs =y(102);
rhs =y(180);
residual(42)= lhs-rhs;
lhs =y(103);
rhs =y(4);
residual(43)= lhs-rhs;
lhs =y(104);
rhs =y(9);
residual(44)= lhs-rhs;
lhs =y(105);
rhs =y(10);
residual(45)= lhs-rhs;
lhs =y(106);
rhs =y(11);
residual(46)= lhs-rhs;
lhs =y(107);
rhs =y(12);
residual(47)= lhs-rhs;
lhs =y(108);
rhs =y(13);
residual(48)= lhs-rhs;
lhs =y(109);
rhs =y(2);
residual(49)= lhs-rhs;
lhs =y(110);
rhs =y(15);
residual(50)= lhs-rhs;
lhs =y(111);
rhs =y(16);
residual(51)= lhs-rhs;
lhs =y(112);
rhs =y(17);
residual(52)= lhs-rhs;
lhs =y(113);
rhs =y(18);
residual(53)= lhs-rhs;
lhs =y(114);
rhs =y(19);
residual(54)= lhs-rhs;
lhs =y(115);
rhs =y(20);
residual(55)= lhs-rhs;
lhs =y(116);
rhs =y(21);
residual(56)= lhs-rhs;
lhs =y(117);
rhs =y(22);
residual(57)= lhs-rhs;
lhs =y(118);
rhs =y(23);
residual(58)= lhs-rhs;
lhs =y(119);
rhs =y(3);
residual(59)= lhs-rhs;
lhs =y(120);
rhs =y(25);
residual(60)= lhs-rhs;
lhs =y(121);
rhs =y(26);
residual(61)= lhs-rhs;
lhs =y(122);
rhs =y(27);
residual(62)= lhs-rhs;
lhs =y(123);
rhs =y(28);
residual(63)= lhs-rhs;
lhs =y(124);
rhs =y(29);
residual(64)= lhs-rhs;
lhs =y(125);
rhs =y(30);
residual(65)= lhs-rhs;
lhs =y(126);
rhs =y(31);
residual(66)= lhs-rhs;
lhs =y(127);
rhs =y(32);
residual(67)= lhs-rhs;
lhs =y(128);
rhs =y(33);
residual(68)= lhs-rhs;
lhs =y(129);
rhs =y(14);
residual(69)= lhs-rhs;
lhs =y(130);
rhs =y(35);
residual(70)= lhs-rhs;
lhs =y(131);
rhs =y(36);
residual(71)= lhs-rhs;
lhs =y(132);
rhs =y(37);
residual(72)= lhs-rhs;
lhs =y(133);
rhs =y(5);
residual(73)= lhs-rhs;
lhs =y(134);
rhs =y(39);
residual(74)= lhs-rhs;
lhs =y(135);
rhs =y(40);
residual(75)= lhs-rhs;
lhs =y(136);
rhs =y(41);
residual(76)= lhs-rhs;
lhs =y(137);
rhs =y(42);
residual(77)= lhs-rhs;
lhs =y(138);
rhs =y(43);
residual(78)= lhs-rhs;
lhs =y(139);
rhs =y(44);
residual(79)= lhs-rhs;
lhs =y(140);
rhs =y(45);
residual(80)= lhs-rhs;
lhs =y(141);
rhs =y(46);
residual(81)= lhs-rhs;
lhs =y(142);
rhs =y(47);
residual(82)= lhs-rhs;
lhs =y(143);
rhs =x(it_, 4);
residual(83)= lhs-rhs;
lhs =y(144);
rhs =y(49);
residual(84)= lhs-rhs;
lhs =y(145);
rhs =y(50);
residual(85)= lhs-rhs;
lhs =y(146);
rhs =y(51);
residual(86)= lhs-rhs;
lhs =y(147);
rhs =y(52);
residual(87)= lhs-rhs;
lhs =y(148);
rhs =y(53);
residual(88)= lhs-rhs;
lhs =y(149);
rhs =y(54);
residual(89)= lhs-rhs;
lhs =y(150);
rhs =y(55);
residual(90)= lhs-rhs;
lhs =y(151);
rhs =y(56);
residual(91)= lhs-rhs;
lhs =y(152);
rhs =y(57);
residual(92)= lhs-rhs;
lhs =y(153);
rhs =y(58);
residual(93)= lhs-rhs;
lhs =y(154);
rhs =y(59);
residual(94)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(94, 185);

  %
  % Jacobian matrix
  %

T3 = (-1);
  g1(1,62)=params(11);
  g1(1,63)=1;
  g1(1,155)=T3;
  g1(1,74)=T3;
  g1(2,1)=(-params(17));
  g1(2,61)=1;
  g1(2,63)=(-((1-params(17))*params(16)));
  g1(2,64)=(-((1-params(17))*params(15)));
  g1(2,76)=T3;
  g1(3,63)=(-params(23));
  g1(3,64)=1;
  g1(3,3)=(-params(21));
  g1(3,157)=(-(1-params(21)));
  g1(3,75)=T3;
  g1(4,4)=(-params(2));
  g1(4,66)=1;
  g1(4,185)=T3;
  g1(4,9)=(-params(3));
  g1(4,10)=(-params(4));
  g1(4,14)=(-params(5));
  g1(4,49)=(-params(6));
  g1(4,51)=(-params(7));
  g1(4,58)=(-params(8));
  g1(4,60)=(-params(9));
  g1(5,6)=(-params(24));
  g1(5,74)=1;
  g1(5,182)=T3;
  g1(6,7)=(-params(25));
  g1(6,75)=1;
  g1(6,183)=T3;
  g1(7,8)=(-params(26));
  g1(7,76)=1;
  g1(7,184)=T3;
  g1(8,61)=1;
  g1(8,62)=T3;
  g1(8,156)=T3;
  g1(9,64)=(-(1-params(1)));
  g1(9,65)=1;
  g1(9,66)=(-params(1));
  g1(10,2)=(-0.08333333333333333);
  g1(10,64)=(-0.08333333333333333);
  g1(10,67)=1;
  g1(10,15)=(-0.08333333333333333);
  g1(10,16)=(-0.08333333333333333);
  g1(10,17)=(-0.08333333333333333);
  g1(10,18)=(-0.08333333333333333);
  g1(10,19)=(-0.08333333333333333);
  g1(10,20)=(-0.08333333333333333);
  g1(10,21)=(-0.08333333333333333);
  g1(10,22)=(-0.08333333333333333);
  g1(10,23)=(-0.08333333333333333);
  g1(10,24)=(-0.08333333333333333);
  g1(11,3)=(-0.08333333333333333);
  g1(11,65)=(-0.08333333333333333);
  g1(11,68)=1;
  g1(11,25)=(-0.08333333333333333);
  g1(11,26)=(-0.08333333333333333);
  g1(11,27)=(-0.08333333333333333);
  g1(11,28)=(-0.08333333333333333);
  g1(11,29)=(-0.08333333333333333);
  g1(11,30)=(-0.08333333333333333);
  g1(11,31)=(-0.08333333333333333);
  g1(11,32)=(-0.08333333333333333);
  g1(11,33)=(-0.08333333333333333);
  g1(11,34)=(-0.08333333333333333);
  g1(12,4)=(-0.08333333333333333);
  g1(12,66)=(-0.08333333333333333);
  g1(12,69)=1;
  g1(12,9)=(-0.08333333333333333);
  g1(12,10)=(-0.08333333333333333);
  g1(12,11)=(-0.08333333333333333);
  g1(12,12)=(-0.08333333333333333);
  g1(12,13)=(-0.08333333333333333);
  g1(12,14)=(-0.08333333333333333);
  g1(12,35)=(-0.08333333333333333);
  g1(12,36)=(-0.08333333333333333);
  g1(12,37)=(-0.08333333333333333);
  g1(12,38)=(-0.08333333333333333);
  g1(13,70)=1;
  g1(13,170)=T3;
  g1(14,71)=1;
  g1(14,181)=T3;
  g1(15,64)=T3;
  g1(15,73)=1;
  g1(15,75)=1;
  g1(16,72)=1;
  g1(16,5)=(-0.08333333333333333);
  g1(16,73)=(-0.08333333333333333);
  g1(16,39)=(-0.08333333333333333);
  g1(16,40)=(-0.08333333333333333);
  g1(16,41)=(-0.08333333333333333);
  g1(16,42)=(-0.08333333333333333);
  g1(16,43)=(-0.08333333333333333);
  g1(16,44)=(-0.08333333333333333);
  g1(16,45)=(-0.08333333333333333);
  g1(16,46)=(-0.08333333333333333);
  g1(16,47)=(-0.08333333333333333);
  g1(16,48)=(-0.08333333333333333);
  g1(17,65)=T3;
  g1(17,79)=1;
  g1(18,77)=1;
  g1(19,61)=T3;
  g1(19,78)=1;
  g1(20,66)=T3;
  g1(20,77)=T3;
  g1(20,80)=1;
  g1(21,158)=T3;
  g1(21,81)=1;
  g1(22,160)=T3;
  g1(22,82)=1;
  g1(23,161)=T3;
  g1(23,83)=1;
  g1(24,162)=T3;
  g1(24,84)=1;
  g1(25,163)=T3;
  g1(25,85)=1;
  g1(26,164)=T3;
  g1(26,86)=1;
  g1(27,165)=T3;
  g1(27,87)=1;
  g1(28,166)=T3;
  g1(28,88)=1;
  g1(29,167)=T3;
  g1(29,89)=1;
  g1(30,168)=T3;
  g1(30,90)=1;
  g1(31,169)=T3;
  g1(31,91)=1;
  g1(32,159)=T3;
  g1(32,92)=1;
  g1(33,171)=T3;
  g1(33,93)=1;
  g1(34,172)=T3;
  g1(34,94)=1;
  g1(35,173)=T3;
  g1(35,95)=1;
  g1(36,174)=T3;
  g1(36,96)=1;
  g1(37,175)=T3;
  g1(37,97)=1;
  g1(38,176)=T3;
  g1(38,98)=1;
  g1(39,177)=T3;
  g1(39,99)=1;
  g1(40,178)=T3;
  g1(40,100)=1;
  g1(41,179)=T3;
  g1(41,101)=1;
  g1(42,180)=T3;
  g1(42,102)=1;
  g1(43,4)=T3;
  g1(43,103)=1;
  g1(44,9)=T3;
  g1(44,104)=1;
  g1(45,10)=T3;
  g1(45,105)=1;
  g1(46,11)=T3;
  g1(46,106)=1;
  g1(47,12)=T3;
  g1(47,107)=1;
  g1(48,13)=T3;
  g1(48,108)=1;
  g1(49,2)=T3;
  g1(49,109)=1;
  g1(50,15)=T3;
  g1(50,110)=1;
  g1(51,16)=T3;
  g1(51,111)=1;
  g1(52,17)=T3;
  g1(52,112)=1;
  g1(53,18)=T3;
  g1(53,113)=1;
  g1(54,19)=T3;
  g1(54,114)=1;
  g1(55,20)=T3;
  g1(55,115)=1;
  g1(56,21)=T3;
  g1(56,116)=1;
  g1(57,22)=T3;
  g1(57,117)=1;
  g1(58,23)=T3;
  g1(58,118)=1;
  g1(59,3)=T3;
  g1(59,119)=1;
  g1(60,25)=T3;
  g1(60,120)=1;
  g1(61,26)=T3;
  g1(61,121)=1;
  g1(62,27)=T3;
  g1(62,122)=1;
  g1(63,28)=T3;
  g1(63,123)=1;
  g1(64,29)=T3;
  g1(64,124)=1;
  g1(65,30)=T3;
  g1(65,125)=1;
  g1(66,31)=T3;
  g1(66,126)=1;
  g1(67,32)=T3;
  g1(67,127)=1;
  g1(68,33)=T3;
  g1(68,128)=1;
  g1(69,14)=T3;
  g1(69,129)=1;
  g1(70,35)=T3;
  g1(70,130)=1;
  g1(71,36)=T3;
  g1(71,131)=1;
  g1(72,37)=T3;
  g1(72,132)=1;
  g1(73,5)=T3;
  g1(73,133)=1;
  g1(74,39)=T3;
  g1(74,134)=1;
  g1(75,40)=T3;
  g1(75,135)=1;
  g1(76,41)=T3;
  g1(76,136)=1;
  g1(77,42)=T3;
  g1(77,137)=1;
  g1(78,43)=T3;
  g1(78,138)=1;
  g1(79,44)=T3;
  g1(79,139)=1;
  g1(80,45)=T3;
  g1(80,140)=1;
  g1(81,46)=T3;
  g1(81,141)=1;
  g1(82,47)=T3;
  g1(82,142)=1;
  g1(83,185)=T3;
  g1(83,143)=1;
  g1(84,49)=T3;
  g1(84,144)=1;
  g1(85,50)=T3;
  g1(85,145)=1;
  g1(86,51)=T3;
  g1(86,146)=1;
  g1(87,52)=T3;
  g1(87,147)=1;
  g1(88,53)=T3;
  g1(88,148)=1;
  g1(89,54)=T3;
  g1(89,149)=1;
  g1(90,55)=T3;
  g1(90,150)=1;
  g1(91,56)=T3;
  g1(91,151)=1;
  g1(92,57)=T3;
  g1(92,152)=1;
  g1(93,58)=T3;
  g1(93,153)=1;
  g1(94,59)=T3;
  g1(94,154)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],94,34225);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],94,6331625);
end
end
end
end
