function [Z] = trafo3d(Q,x0,y0,z0,ex,ey,ez,m)
%TRAFO3D Summary of this function goes here
%   Detailed explanation goes here
D = [cos(ey)*cos(ez) sin(ex)*sin(ey)*cos(ez)-cos(ex)*sin(ez) cos(ex)*sin(ey)*cos(ez)+sin(ex)*sin(ez); cos(ey)*sin(ez) sin(ex)*sin(ey)*sin(ez)+cos(ex)*cos(ez) cos(ex)*sin(ey)*sin(ez)-sin(ex)*cos(ez); -sin(ey) sin(ex)*cos(ey) cos(ex)*cos(ey)];
X0 = [x0;y0;z0];
Z = X0 + m * D * transpose(Q);
end

