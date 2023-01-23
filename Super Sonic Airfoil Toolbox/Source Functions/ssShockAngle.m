function beta = ssShockAngle(Mu,delta,gamma)
B_solv = @(b) 2*cotd(b)*(Mu^2*sind(b)^2-1)/(2+Mu^2*abs(gamma+cosd(2*b))) - tand(delta);
beta = fsolve(B_solv,10,optimset('Display','off'));
end