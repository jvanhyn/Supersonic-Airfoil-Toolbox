%% Final Exam Practice 2022
%{ 
Examples problems for triangular or diamond shaped super sonic 
airfoils. Solve for oblique shock or expansion wave, lift and draf
coefficient, and moment coefficient. This example analsyses a thin-plate
airforil in a triangular configuration. 
%}

%% Problem 1A - Zero Angle of Attack
clear
clc

% Set Up
Minf = 2.8;
gamma = 1.4;
lambda = 10;

% Geometry
lambda1 = lambda;
lambda2 = -lambda;
alpha = 0;

% Deflections
delta1 = lambda;
theta2 = 2*lambda;
theta3 = lambda;
delta3 = 2*lambda;

%  1 - Shock 
Mu1 = Minf;
beta1 = ssShockAngle(Mu1,delta1,gamma);
[Md1,p1] = ssObliqueShock(Mu1,delta1,beta1,gamma);

% 2 - Expansion 
Mu2 = Md1;
[Md2,p2] = ssExpansionWave(Mu2,theta2,gamma);

% 3 - Expansion
Mu3 = Minf;
[Md3,p3] = ssExpansionWave(Mu3,theta3,gamma);

% 4 - Shock
Mu4 = Md3;
beta4 = ssShockAngle(Mu4,delta3,gamma)
[Md4,p4] = ssObliqueShock(Mu4,delta3,beta4,gamma);

% Stagnation Pressures
p1_0 = p1;
p2_0 = p2*p1;
p3_0 = p3;
p4_0 = p4*p3;

% Lift
Cl1 = ssLift(p1_0,p2_0,p3_0,p4_0,Minf,alpha,gamma);

% Drag
Cd1 = ssDrag(p1_0,p2_0,p3_0,p4_0,Minf,lambda1,lambda2,alpha,gamma);

% Moment
cm_LE = ssMomentLE(p1_0,p2_0,p3_0,p4_0,Minf,lambda1,lambda2,gamma);

% Answer
Q1 = {[p1_0 p2_0 p3_0 p4_0], [Md1 Md2 Md3 Md4]}
Q2 = [Cl1 Cd1];
Q3 = cm_LE;

%% Part B - Finite Angle of Attack
% Geometry
lambda1 = lambda;
lambda2 = -lambda;
alpha = lambda; 

% Deflections
delta5 = 0;
theta6 = 2*lambda;
theta7 = 0;
delta8 = 2*lambda;

% 5 - No Flow Deflection 
Mu5 = Minf;
Md5 = Mu5;
p5 = 1;

% 6 - Expansion
Mu6 = Md5;
[Md6,p6] = ssExpansionWave(Mu6,theta6,gamma);

% 7 - No Flow Deflection
Mu7 = Minf;
Md7 = Mu7;
p7 = 1;

% 8 - Shock 
Mu8 = Md7;
beta8 = ssShockAngle(Mu8,delta8,gamma);
[Md8,p8] = ssObliqueShock(Mu8,delta8,beta8,gamma);

% Stagnation Pressures
p5_0 = p5;
p6_0 = p6*p5;
p7_0 = p7;
p8_0 = p8*p7;

% Lift and Drag
[Cl, Cdi] = ssLift(p5_0,p6_0,p7_0,p8_0,Minf,alpha,gamma);
[Cd, Cli] = ssDrag(p5_0,p6_0,p7_0,p8_0,Minf,lambda1,lambda2,alpha,gamma);

Cd2 = Cd+Cdi;
Cl2 = Cl+Cli;

% Moment
cm_LE = ssMomentLE(p5_0,p6_0,p7_0,p7_0,Minf,lambda1,lambda2,gamma);

% Answer
Q5 = {[p5_0 p6_0 p7_0 p8_0],[Md5 Md6 Md7 Md8]}
Q6 = [Cl2 Cd2];