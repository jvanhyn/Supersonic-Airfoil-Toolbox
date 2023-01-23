function [Cl , varargout] = superSonicLift(p1,p2,p3,p4,M,alpha,gamma)
N = (p3 + p4 - p1 - p2)/(gamma*M^2);
Cl = N*cosd(alpha)
Cdi = N*sind(alpha)
varargout = {Cdi, N};
end 