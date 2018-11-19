clc 
close all
%% Aufgabe 1 a)
% Vorher WerteGenerator.p ausfuehren!
X=[A1_SystemI(1:5,2),A1_SystemI(1:5,1),A1_SystemI(1:5,3)];
Z=[A1_SystemII(1:5,2),A1_SystemII(1:5,1),A1_SystemII(1:5,3)];
t=trafoparam_3d_12p(X,Z);
