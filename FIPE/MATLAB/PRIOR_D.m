function [prior] = PRIOR_D(Theta)

% This function allows you to set the priors. 

%% 1. Setting the priors for each parameter to estimate


mf1 = 1.5;   % Mean
sf1 = 0.1;   % Std. Deviation
[af1, bf1]     = gammaparam(mf1,sf1); % Gamma's Parameters
PDF_PARAM_1    = gampdf(Theta(1),af1,bf1);

mf2 = 0.98;   % Mean
sf2 = 0.007;  % Std. Deviation
[af2, bf2]     = betaparam(mf2,sf2); % Beta's Parameters
PDF_PARAM_2    = betapdf(Theta(2),af2,bf2);

mf3 = 0.5;   % Mean
sf3 = 0.1;  % Std. Deviation
[af3, bf3]     = betaparam(mf3,sf3); % Beta's Parameters
PDF_PARAM_3    = betapdf(Theta(3),af3,bf3);

mf4 = 0.5;   % Mean
sf4 = 0.2;   % Std. Deviation
[af4, bf4]     = gammaparam(mf4,sf4); % Gamma's Parameters
PDF_PARAM_4    = gampdf(Theta(4),af4,bf4);


%% 2. Building the Joint Prior Distribution

f = PDF_PARAM_1*PDF_PARAM_2*PDF_PARAM_3*PDF_PARAM_4;

if f <= 10^(-13)
   prior = -Inf;
else
   prior = log(f);
end

save Prior_Outcomes;

end


%% 3. Function to Compute Beta's parameters a and b.

function [a, b] = betaparam(m,s)

a  = m*(m*(1-m)/(s^2)-1);
b  = (1-m)*(m*(1-m)/(s^2)-1);

end


%% 4. Function to Compute Gamma's parameters ag and bg.

function [ag, bg] = gammaparam(mg,sg)

ag  = (mg/sg)^2;
bg  = sg^2/mg;



end


