function f = uniform_pdf(x, minn, maxx)
% PURPOSE: returns the pdf at x of the gamma(a) distribution
%---------------------------------------------------
% USAGE: pdf = unifor_pdf(x,min,max)
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
if nargin ~= 3
    maxx=1;
    minn=0;
end
rank = maxx-minn ;
%if nargin ~= 3
%    error('Wrong # of arguments to uniform_cdf');
%end;

if maxx <= minn
   error('uniform_pdf: parameter max and min are wrong')
end

%if any(x) < min 

f = ((x>=minn).*(x<=maxx))./rank ; %x .^ (a-1) .* exp(-x./b) ./ (gamma(a).*b.^a);

%I0 = find(x<0);
%f(I0) = zeros(size(I0));
