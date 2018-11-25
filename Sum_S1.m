% Vorher WerteGenerator.p ausfuehren!
clc
close all
%% Aufgabe 1a)
disp('Aufgabe 1a)');
fprintf('\n');
%Hier werden jeweils immer die 1. und 2. Spalte vertauscht, um die x- und
%y-Koordinaten in der richtigen Spalte zu haben
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
%fprintf wird deshalb zur Ausgabe verwendet, weil die Array sonst
%automatisch in Gleitkommaschreibweise ausgegeben werden
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
disp('Aufgabe 2b)');
fprintf('\n');
disp('Parameter fuer Punkt 1, 2, 5 (x0, y0, z0, ex, ey, ez, m):');
X1=[A1_SystemI(1,2) A1_SystemI(1,1) A1_SystemI(1,3);A1_SystemI(2,2) A1_SystemI(2,1) A1_SystemI(2,3);A1_SystemI(5,2) A1_SystemI(5,1) A1_SystemI(5,3)];
Z1=[A1_SystemII(1,2) A1_SystemII(1,1) A1_SystemII(1,3);A1_SystemII(2,2) A1_SystemII(2,1) A1_SystemII(2,3);A1_SystemII(5,2) A1_SystemII(5,1) A1_SystemII(5,3)];
p1=trafoparam_3d_7p(X1,Z1,p);
fprintf('%.4f\n',p1);
fprintf('\n');
%Die Verwendung der Funktion mit den Punkten 1, 2 6 fuehrt, wie richtig
%vorausgesagt, zu einem Fehler
disp('Parameter fuer Punkt 1, 4, 5, 6 (x0, y0, z0, ex, ey, ez, m):');
X3=[A1_SystemI(1,2) A1_SystemI(1,1) A1_SystemI(1,3);A1_SystemI(4,2) A1_SystemI(4,1) A1_SystemI(4,3);A1_SystemI(5,2) A1_SystemI(5,1) A1_SystemI(5,3);A1_SystemI(6,2) A1_SystemI(6,1) A1_SystemI(6,3)];
Z3=[A1_SystemII(1,2) A1_SystemII(1,1) A1_SystemII(1,3);A1_SystemII(4,2) A1_SystemII(4,1) A1_SystemII(4,3);A1_SystemII(5,2) A1_SystemII(5,1) A1_SystemII(5,3);A1_SystemII(6,2) A1_SystemII(6,1) A1_SystemII(6,3)];
p3=trafoparam_3d_7p(X3,Z3,p);
fprintf('%.4f\n',p3);
fprintf('\n');
%% Aufgabe 2 c)
t11=trafo3d(Xfull(1,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));
t12=trafo3d(Xfull(2,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));
t13=trafo3d(Xfull(3,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));
t14=trafo3d(Xfull(4,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));
t15=trafo3d(Xfull(5,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));
t16=trafo3d(Xfull(6,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));
t17=trafo3d(Xfull(7,:),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6),p1(7));

t21=trafo3d(Xfull(1,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
t22=trafo3d(Xfull(2,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
t23=trafo3d(Xfull(3,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
t24=trafo3d(Xfull(4,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
t25=trafo3d(Xfull(5,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
t26=trafo3d(Xfull(6,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
t27=trafo3d(Xfull(7,:),p3(1),p3(2),p3(3),p3(4),p3(5),p3(6),p3(7));
%% Aufgabe 3a)
X_voll=[A1_SystemI(1:7,2),A1_SystemI(1:7,1),A1_SystemI(1:7,3)];
Z_sys3=[A1_SystemIII(1:7,2),A1_SystemIII(1:7,1),A1_SystemIII(1:7,3)];
Z_sys3_135=[Z_sys3(1,:);Z_sys3(3,:);Z_sys3(5,:)];
X_135=[X(1,:);X(3,:);X(5,:)];
ergebnisse_Aufgabe_3a=trafoparam_3d_kD(X_135,Z_sys3_135);
%% Aufgabe 3 b)
ergebnisse_Aufgabe_3b=trafoparam_3d_7p(X_135,Z_sys3_135,(ergebnisse_Aufgabe_3a)');
%% Aufgabe 3 c)
ergebnisse_Aufgabe_3c=trafoparam_3d_kD(X_voll,Z_sys3);