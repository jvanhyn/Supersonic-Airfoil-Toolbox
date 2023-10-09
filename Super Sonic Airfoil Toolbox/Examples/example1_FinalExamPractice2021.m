%% Final Exam Practice 2021
%{ 
Examples problems for triangular or diamond shaped super sonic 
airfoils. Solve for oblique shock or expansion wave, lift and draf
coefficient, and moment coefficient. This example analizes a triangular
airforil. 
%}

%% Problem 1A - Zero Angle of Attack
clear
clc

% Setup
Minf = 4;
lambda = 15;
gamma = 1.4;

% 1 - Shock 
Mu1= Minf;
delta = lambda;
beta1 = ssShockAngle(Minf,delta,gamma);
[Md1,p1] = ssObliqueShock(Mu1,delta,beta1,gamma);

% 2 - Expansion
Mu2 = Md1;
theta2 = 2*lambda;
[Md2,p2] = ssExpansionWave(Mu2,theta2,gamma);

% 3 - No Flow Difflection 
Md3 = Minf;
p3 = 1;

% 4 - No Flow Difflection 
Md4 = Minf;
p4 = 1;

% Stagnation Pressures
p1_0 = p1;
p2_0 = p2*p1;
p3_0 = p3;
p4_0 = p4*p3;

% Geometry
lambda1 = lambda; 
lambda2 = 0;
alpha = 0;

% Lift
Cl1 = ssLift(p1_0,p2_0,p3_0,p4_0,Minf,0,gamma);

% Drag
Cd1 = ssDrag(p1_0,p2_0,p3_0,p4_0,Minf,lambda1,lambda2,alpha,gamma);

% Moment
cm_LE = ssMomentLE(p1_0,p2_0,p3_0,p4_0,Minf,lambda1,lambda2,gamma);

% Answer
Q1 = {[p1_0 p2_0 p3_0 p4_0], [Md1 Md2 Md3 Md4]};
Q2 = [Cl1 Cd1];
Q3 = cm_LE;

%% Part B - Finite Angle of Attack

% Geometry
lambda1 = lambda;
lambda2 = 0;
alpha = lambda; 

% 5 - No Flow Difflection 
Md5 = Minf;
p5 = 1;

% 6 - Expansion
Mu6 = Minf;
theta6 = 2*lambda;
[Md6,p6] = ssExpansionWave(Mu6,theta6,gamma);

% 7 - Shock 
Mu7 = Minf;
delta7 = lambda;
beta7 = ssShockAngle(Mu7,delta7,gamma);
[Md7,p7] = ssObliqueShock(Mu7,delta7,beta7,gamma);

% 8 - No Flow Deflection
Md8 = Md7;
p8 = p7;

% Stagnation Pressures
p5_0 = p5;
p6_0 = p6;
p7_0 = p7;
p8_0 = p8;

% Lift and Drag
[Cl, Cdi] = ssLift(p5_0,p6_0,p7_0,p8_0,Minf,alpha,gamma);
[Cd, Cli] = ssDrag(p5_0,p6_0,p7_0,p8_0,Mu1,lambda1,lambda2,alpha,gamma);

Cd2 = Cd+Cdi;
Cl2 = Cl+Cli;

% Moment
cm_LE = ssMomentLE(p5_0,p6_0,p7_0,p7_0,Mu1,lambda1,lambda2,gamma);

% Answer
Q5 = {[p5_0 p6_0 p7_0 p8_0], [Md5 Md6 Md7 Md8]};
Q6 = [Cl2 Cd2];