function dz = springCartPoleDynamics(~,z,P) 
%DZ = SPRINGCARTPOLEDYNAMICS(T,Z,P)
% 
%FUNCTION:  This function computes the dynamics of a rolling
%    cart-pole, and is designed to be called from ode45.
% 
%INPUTS: 
%    t = time. Dummy input for ode45. Not used.
%    z = [4xn] matrix of states.
%    P = struct of parameters
%OUTPUTS: 
%    dz = [4xn] matrix of state derivatives
% 
%NOTES:
%    This file was automatically generated by writeRollingCartPoleDynamics

m = P.m; %bob mass
I = P.I; %disk moment of inertia
g  = P.g ; %gravity
l = P.l; %pendulum length
r = P.r; %disk radius

phi = z(1,:); %link one absolute angle
th = z(2,:); %link one angular rate
dphi = z(3,:); %link two absolute angle
dth = z(4,:); %link two angular rate

f1 = -r.*sin(th).*(g.*m.*cos(th) + dth.^2.*l.*m);
f2 = -g.*m.*sin(th);

M11 = - I - m.*r.^2.*sin(th).^2;
M12 = 0;
M21 = m.*r.*cos(th);
M22 = -l.*m;

D = M11.*M22 - M12.*M21;

ddphi = (f2.*M12 - f1.*M22)./D;
ddth = -(f2.*M11 - f1.*M21)./D;

dz = [...
    dphi; %derivative of link one absolute angle
    dth; %derivative of link one angular rate
    ddphi; %derivative of link two absolute angle
    ddth; %derivative of link two angular rate
];
end 
