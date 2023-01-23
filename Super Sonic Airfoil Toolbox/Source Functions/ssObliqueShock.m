%% Oblique Shock Downstream Properties
function [Md, varargout] = ssObliqueShock(Mu,delta,beta,gamma)

% Mach Number 
Mun = Mu*sind(beta);
Mdn = sqrt((2+(gamma-1)*Mun^2)/(2*gamma*Mun^2+1-gamma));
Md = Mdn/sind(beta-delta);

% Density 
rho =  (gamma+1)*Mun/(2+(gamma-1)*Mun^2);

% Pressure
p = (2*gamma*Mun^2+1-gamma)/(gamma+1);

% Tempurature
T =  (2*gamma*Mun^2+1-gamma)/((gamma+1)^2*Mun^2);

% Output
varargout = {p rho T Mun Mdn};
end

