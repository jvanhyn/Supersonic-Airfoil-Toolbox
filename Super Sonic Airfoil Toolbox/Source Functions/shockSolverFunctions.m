clear 
clc
%% Shock Solver Functions
% Mach Number 
Mun_solv = @(Mu,beta) Mu*sind(beta);
Mdn_solv = @(Mun,gamma) sqrt((2+(gamma-1)*Mun^2)/(2*gamma*Mun^2+1-gamma));
Md_solv = @(Mun,beta, delta, gamma) Mdn_solv(Mun,gamma)/sind(beta-delta);

% Density 
rho_solv = @(Mun,gamma) (gamma+1)*Mun/(2+(gamma-1)*Mun^2);

% Pressure
p_solv = @(Mun,gamma) (2*gamma*Mun^2+1-gamma)/(gamma+1);

% Tempurature
T_solv = @(Mun,gamma) (2*gamma*Mun^2+1-gamma)/((gamma+1)^2*Mun^2);

%% Upstream Properties 
beta = 27;
delta = 15;
Mu = 4;
gamma =1.4; 

%% Evaluation
Mun = Mun_solv(Mu,beta)
Mdn = Mdn_solv(Mun,gamma)

Md = Md_solv(Mun,beta,delta, gamma)
rho = rho_solv(Mun,gamma)
p = p_solv(Mun,gamma)
T = T_solv(Mun,gamma)

downStream = [Md rho p T];