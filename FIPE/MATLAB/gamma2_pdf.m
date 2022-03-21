function f = gamma2_pdf (x, s, nu)
% PURPOSE: returns the pdf at x of the gamma(a) distribution
%---------------------------------------------------
% USAGE: pdf = gamm_pdf(x,a)
% where: x = a vector  
%        a = a scalar for gamma(a)
%---------------------------------------------------
% RETURNS:
%        a vector of pdf at each element of x of the gamma(a) distribution      
% --------------------------------------------------
% SEE ALSO: gamm_cdf, gamm_rnd, gamm_inv
%---------------------------------------------------

%       Anders Holtsberg, 18-11-93
%       Copyright (c) Anders Holtsberg

a=nu/2;
b=2*s./nu;

if nargin ~= 3
error('Wrong # of arguments to gamm_cdf');
end;

if any(any(a<=0))
   error('gamm_pdf: parameter a is wrong')
end
if any(any(b<=0))
   error('gamm_pdf: parameter a is wrong')
end

f = x .^ (a-1) .* exp(-x./b) ./ (gamma(a).*b.^a);
I0 = find(x<0);
f(I0) = zeros(size(I0));
