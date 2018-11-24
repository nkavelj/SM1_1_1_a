function [ p ] = trafoparam_3d_12p ( X,Z )
%TRAFOPARAM_3D_12P Berechnung der Transformationsparameter für eine
%Aehnlichkeitstrafo mit der 12-Parameter-Methode, fuer genau 5 Punkte
%X beinaltet die Koordinaten im Ausgangssystem als 5x3-Matrix, Z die
%Koordinaten im Zielsystem, auch als 5x3-Matrix
G=zeros(15,12);
%Hier erfolgt das Einfuegen der Einser in die ersten drei Spalten
for i=1:1:15
    G(i,(mod(i-1,3)+1))=1;
end
%Die x,y,z-Koordinaten jedes Punktes werden hier an die richtige Stelle in
%der Matrix eingefuegt
for i=1:1:5
    G(3*i-2,4)=X(i,1);
    G(3*i-2,5)=X(i,2);
    G(3*i-2,6)=X(i,3);
    G(3*i-1,7)=X(i,1);
    G(3*i-1,8)=X(i,2);
    G(3*i-1,9)=X(i,3);
    G(3*i,10)=X(i,1);
    G(3*i,11)=X(i,2);
    G(3*i,12)=X(i,3);
end
%Zs beinhaltet die Koodinaten jedes Punktes in Z als Spaltenvektor in der
%Reihenfolge x1,y1,z1,x2,y,y2,z2 etc.
Zs = [];
for i=1:1:5
    for j=1:1:3
        Zs=[Zs;Z(i,j)];
    end
end
Z_=[];
G_=[];
%Jede Koordinate in Zs, die gleich NaN ist, und die dazugehoerige Zeile in
%G, werden in die Arrays Z_ und G_, die fuer die entgueltige Berechnung der
%Parameter gedacht sind, nicht uebernommen
for i=1:1:15
    if isnan(Zs(i))==0
        Z_=[Z_;Zs(i)];
        G_=[G_;G(i,:)];
    end
end
t=G_\Z_;
%Es wird angenommen, das der Massstab das arithmetische Mittel aller drei
%errechnenten Massstaebe ist
m1=sqrt(t(4)^2+t(7)^2+t(10)^2);
m2=sqrt(t(5)^2+t(8)^2+t(11)^2);
m3=sqrt(t(6)^2+t(9)^2+t(12)^2);
m=(m1+m2+m3)/3;
ex=atan2(t(11),t(12));
ey=atan2(-t(10),sqrt(t(4)^2+t(7)^2));
ez=atan2(t(7),t(4));
x0=t(1);
y0=t(2);
z0=t(3);
p=[x0,y0,z0,ex,ey,ez,m];
end

