% Vorher WerteGenerator.p ausfuehren!
clc 
close all
%% Aufgabe 1a)
disp('Aufgabe 1a)');
fprintf('\n');
X=[A1_SystemI(1:5,2),A1_SystemI(1:5,1),A1_SystemI(1:5,3)];
Z=[A1_SystemII(1:5,2),A1_SystemII(1:5,1),A1_SystemII(1:5,3)];
disp('x0, y0, z0, ex, ey, ez, m:');
p=trafoparam_3d_12p(X,Z)
%% Aufgabe 1b)
disp('Aufgabe 1b)');
fprintf('\n');
Xfull=[A1_SystemI(:,2),A1_SystemI(:,1),A1_SystemI(:,3)];
disp('Punkt 4 [x,y,z]:');
Z4=trafo3d(Xfull(4,:),p(1),p(2),p(3),p(4),p(5),p(6),p(7));
fprintf('%.4f\n',Z4);
fprintf('\n');
disp('Punkt 5 [x,y,z]:');
Z5=trafo3d(Xfull(5,:),p(1),p(2),p(3),p(4),p(5),p(6),p(7));
fprintf('%.4f\n',Z5);
fprintf('\n');
disp('Punkt 6 [x,y,z]:');
Z6=trafo3d(Xfull(6,:),p(1),p(2),p(3),p(4),p(5),p(6),p(7));
fprintf('%.4f\n',Z6);
fprintf('\n');
disp('Punkt 7 [x,y,z]:');
Z7=trafo3d(Xfull(7,:),p(1),p(2),p(3),p(4),p(5),p(6),p(7));
fprintf('%.4f\n',Z7);
fprintf('\n');
%% Aufgabe 2b)
p=[20,10,-5,0,0,0,1];
disp('Aufgabe 1b)');
fprintf('\n');
disp('Parameter fuer Punkt 1, 2, 5:');
X1=[A1_SystemI(1,2) A1_SystemI(1,1) A1_SystemI(1,3);A1_SystemI(2,2) A1_SystemI(2,1) A1_SystemI(2,3);A1_SystemI(5,2) A1_SystemI(5,1) A1_SystemI(5,3)];
Z1=[A1_SystemII(1,2) A1_SystemII(1,1) A1_SystemII(1,3);A1_SystemII(2,2) A1_SystemII(2,1) A1_SystemII(2,3);A1_SystemII(5,2) A1_SystemII(5,1) A1_SystemII(5,3)];
trafoparam_3d_7p(X1,Z1,p)
fprintf('\n');
disp('Parameter fuer Punkt 1, 2, 6:');
X2=[A1_SystemI(1,2) A1_SystemI(1,1) A1_SystemI(1,3);A1_SystemI(2,2) A1_SystemI(2,1) A1_SystemI(2,3);A1_SystemI(6,2) A1_SystemI(6,1) A1_SystemI(6,3)];
Z2=[A1_SystemII(1,2) A1_SystemII(1,1) A1_SystemII(1,3);A1_SystemII(2,2) A1_SystemII(2,1) A1_SystemII(2,3);A1_SystemII(6,2) A1_SystemII(6,1) A1_SystemII(6,3)];
trafoparam_3d_7p(X2,Z2,p)
fprintf('\n');
disp('Parameter fuer Punkt 1, 4, 5, 6:');
X3=[A1_SystemI(1,2) A1_SystemI(1,1) A1_SystemI(1,3);A1_SystemI(4,2) A1_SystemI(4,1) A1_SystemI(4,3);A1_SystemI(5,2) A1_SystemI(5,1) A1_SystemI(5,3);A1_SystemI(6,2) A1_SystemI(6,1) A1_SystemI(6,3)];
Z3=[A1_SystemII(1,2) A1_SystemII(1,1) A1_SystemII(1,3);A1_SystemII(4,2) A1_SystemII(4,1) A1_SystemII(4,3);A1_SystemII(5,2) A1_SystemII(5,1) A1_SystemII(5,3);A1_SystemII(6,2) A1_SystemII(6,1) A1_SystemII(6,3)];
trafoparam_3d_7p(X3,Z3,p)
fprintf('\n');