function [Cd, varargout] = ssDrag(p1,p2,p3,p4,M,lambda1,lambda2,alpha,gamma)
A = 1/(gamma*M^2)*(tand(lambda1)*(p1-p3)+tand(-lambda2)*(p4-p2));
Cd = A*cosd(alpha)
Cli = A*sind(alpha)
varargout = {Cli,A};
end 