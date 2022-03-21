N = 1; % Dimensions
F = @(t,X) eye(N,1)*0.5; % Drift
G = @(t,X) eye(N)*sqrt(10); % Diffusion
T = 100; % Periods
S = sde(F,G,'startState',zeros(N,1)); % Start at the origin
X = 0;

while 1;
    if length(X) == T+1
    break 
    else X = S.simByEuler(T,'ntrials',1,'Z',@(t,X) RandDir(N));
    end
    A = double(X>=10);
    A(A==0) = NaN ;
end

comet(1:numel(X),X);
plot(1:numel(X),X);
grid on;


