clc 
close all
%% Aufgabe 1a)
% Vorher WerteGenerator.p ausfuehren!
disp('Aufgabe 1a)');
X=[A1_SystemI(1:5,2),A1_SystemI(1:5,1),A1_SystemI(1:5,3)];
Z=[A1_SystemII(1:5,2),A1_SystemII(1:5,1),A1_SystemII(1:5,3)];
disp('x0, y0, z0, ex, ey, ez, m:');
p=trafoparam_3d_12p(X,Z)
%% Aufgabe 1b)