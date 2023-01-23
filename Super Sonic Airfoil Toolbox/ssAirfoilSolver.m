function [cl, varargout] = ssAirfoilSolver(Minf,lambda1,lambda2,alpha,gamma)

% Region 1
Mu1 = Minf;
if lambda1-alpha > 0
    delta1 = lambda1 - alpha;
    beta1 = ssShockAngle(Mu1,delta1,gamma);
    [Md1,p1] = ssObliqueShock(Mu1,delta1,beta1,gamma);
elseif lambda1-alpha < 0 
    theta1 = lambda1 - alpha;
    [Md1,p1] = ssExpansionWave(Mu1,theta1,gamma);
    else
    Md1 = Minf;
    p1 = 1;
end

% Region 2
Mu2 = Md1;
if lambda1 < 0
    delta2 = -2*lambda1; 
    beta2 = ssShockAngle(Mu2,delta2,gamma);
    [Md2,p2] = ssObliqueShock(Mu2,delta2,beta2,gamma);
elseif lambda1 > 0
    theta2 = 2*lambda1;
    [Md2,p2] = ssExpansionWave(Mu2,theta2,gamma);
    else
    Md2 = Md1;
    p2 = 1;
end

% Region 3
Mu3 = Minf;
if lambda2+alpha > 0
    delta3 = lambda2 + alpha;
    beta3 = ssShockAngle(Mu3,delta3,gamma);
    [Md3,p3] = ssObliqueShock(Mu3,delta3,beta3,gamma);
elseif lambda2+alpha < 0 
    theta3 = lambda2 + alpha;
    [Md3,p3] = ssExpansionWave(Mu3,theta3,gamma);
    else
    Md3 = Minf;
    p3 = 1;
end

% Region 4
Mu4 = Md3;
if lambda2 < 0
    delta4 = -2*lambda2; 
    beta4 = ssShockAngle(Mu4,delta4,gamma);
    [Md4,p4] = ssObliqueShock(Mu4,delta4,beta4,gamma);
elseif lambda2 > 0
    theta4 = 2*lambda2;
    [Md4,p4] = ssExpansionWave(Mu4,theta4,gamma);
    else
    Md4 = Md3;
    p4 = 1;
end

% Stagnation Pressures
p1_0 = p1;
p2_0 = p2*p1;
p3_0 = p3;
p4_0 = p4*p3;

% Lift and Drag
[Cl, Cdi] = ssLift(p1_0,p2_0,p3_0,p4_0,Minf,alpha,gamma);
[Cd, Cli] = ssDrag(p1_0,p2_0,p3_0,p4_0,Minf,lambda1,lambda2,alpha,gamma);

cd = Cd+Cdi;
cl = Cl+Cli;

% Moment
cm_LE = ssMomentLE(p1_0,p2_0,p3_0,p4_0,Minf,lambda1,lambda2,gamma);

% Answer
M = [Md1 Md2 Md3 Md4];
P = [p1_0 p2_0 p3_0 p4_0];

varargout = {cd,cm_LE,M,P};
end

function beta = ssShockAngle(Mu,delta,gamma)
B_solv = @(b) 2*cotd(b)*(Mu^2*sind(b)^2-1)/(2+Mu^2*abs(gamma+cosd(2*b))) - tand(delta);
beta = fsolve(B_solv,10,optimset('Display','off'));
end

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

function cm_LE = ssMomentLE(p1,p2,p3,p4,M,lambda1,lambda2,gamma)
cm_LE = (p1/4/(cosd(lambda1))^2 + p2*(3/4 - 1/4*tand(lambda1)*sind(lambda1)) - p3/4/(cosd(lambda2))^2 - p4*(3/4 - 1/4*tand(lambda2)*sind(lambda2)))/(gamma*M^2);
end

function [Cl , varargout] = ssLift(p1,p2,p3,p4,M,alpha,gamma)
N = (p3 + p4 - p1 - p2)/(gamma*M^2)*cosd(alpha);
Cl = N*cosd(alpha);
Cdi = N*sind(alpha);
varargout = {Cdi, N};
end 

function [Md, varargout] = ssExpansionWave(Mu,theta,gamma)

% Convert theta to Radians
rtheta = theta/360*2*pi;

% Prandtl-Meyer Equation
v = @(M) sqrt((gamma+1)/(gamma-1)) * atan(sqrt((gamma-1)/(gamma+1)*(M^2-1))) - atan(sqrt(M^2-1));

% Calculate v(Md) 
vMd = rtheta + v(Mu);

% Solve Numerically for Md
Md_solv = @(M) v(M)-vMd;
Md = fsolve(Md_solv,10,optimset('Display','off'));

% Calculate Pressure Using Isentropic Propperties
p = ((1+(gamma-1)/2*Mu^2)/(1+(gamma-1)/2*Md^2))^(gamma/(gamma-1));

%Output 
varargout = {p};
end

function [Cd, varargout] = ssDrag(p1,p2,p3,p4,M,lambda1,lambda2,alpha,gamma)
A = 1/(gamma*M^2)*(tand(lambda1)*(p1-p2)+tand(lambda2)*(p3-p4));
Cd = A*cosd(alpha);
Cli = A*sind(alpha);
varargout = {Cli,A};
end 


