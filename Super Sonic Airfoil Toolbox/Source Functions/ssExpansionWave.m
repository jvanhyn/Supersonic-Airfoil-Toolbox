%% Expansion Wave Downstream Properties
function [Md, varargout] = ssExpansionWave(Mu,theta,gamma)

% Convert theta to Radians
rtheta = theta/360*2*pi;

% Prandtl-Meyer Equation
v = @(M) sqrt((gamma+1)/(gamma-1)) * atan(sqrt((gamma-1)/(gamma+1)*(M^2-1))) - atan(sqrt(M^2-1));

% Calculate v(Md) 
v(Mu)
vMd = rtheta + v(Mu)

% Solve Numerically for Md
Md_solv = @(M) v(M)-vMd;
Md = fsolve(Md_solv,10,optimset('Display','off'));

% Calculate Pressure Using Isentropic Propperties
p = ((1+(gamma-1)/2*Mu^2)/(1+(gamma-1)/2*Md^2))^(gamma/(gamma-1));

%Output 
varargout = {p};
end