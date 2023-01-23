function cm_LE = ssMomentLE(p1,p2,p3,p4,M,lambda1,lambda2,gamma)
cm_LE = (p1/4/(cosd(lambda1))^2 + p2*(3/4 - 1/4*tand(lambda1)*sind(lambda1)) - p3/4/(cosd(lambda2))^2 - p4*(3/4 - 1/4*tand(lambda2)*sind(lambda2)))/(gamma*M^2);
end