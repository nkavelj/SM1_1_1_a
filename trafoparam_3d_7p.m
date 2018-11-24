function [ p ] = trafoparam_3d_7p( X,Z,p_ )
%TRAFOPARAM_3D_7P Berechnung der Transformationsparameter für eine
%Aehnlichkeitstrafo mit der iterativen 7-Parameter-Methode
%X beinaltet die Koordinaten im Ausgangssystem als nx3-Matrix, Z die
%Koordinaten im Zielsystem, auch als nx3-Matrix, p_ die (genaeherten)
%Parameter, mit denen die Iteration begonnen wird
x0=p_(1);
y0=p_(2);
z0=p_(3);
ex=p_(4);
ey=p_(5);
ez=p_(6);
m=p_(7);

%X_t beinhaltet die Koodinaten jedes Punktes in X als Spaltenvektor in der
%Reihenfolge x1,y1,z1,x2,y,y2,z2 etc.
X_t=[];
for i=1:1:size(X)
    for j=1:1:3
        X_t=[X_t;X(i,j)];
    end
end

%Aus den gegebenen Parametern ex,ey,ez wird hier die Rotationsmatrix
%aufgestellt
D=zeros(3,3);
D(1,1)=cos(ey)*cos(ez);
D(2,1)=cos(ey)*sin(ez);
D(3,2)=-sin(ey);
D(1,2)=sin(ex)*sin(ey)*cos(ez)-cos(ex)*sin(ez);
D(2,2)=sin(ex)*sin(ey)*sin(ez)+cos(ex)*cos(ez);
D(3,2)=sin(ex)*cos(ey);
D(1,3)=cos(ex)*sin(ey)*cos(ez)+sin(ex)*sin(ez);
D(2,3)=cos(ex)*sin(ey)*sin(ez)-sin(ex)*cos(ez);
D(3,3)=cos(ex)*cos(ey);

%Hier wird eine Matrix mit x0,y0,z0 in den drei Zeilen und so vielen
%Spalten wie es Punkte gibt angelegt, um dann im naechsten Schritt die
%Transformation aller Punkte in das Zielsystem in einem Schrott zu
%berechnen
X0=[x0*transpose(ones(size(X,1),1));y0*transpose(ones(size(X,1),1));z0*transpose(ones(size(X,1),1))];
%Es wird die Differenz aus den Zielsystemkoordinaten und transformierten
%Ausgangssystemkoordinaten als Spaltenvektor berechnet
X_d=Z-transpose(X0+m*D*transpose(X));
%X_d_t beinhaltet die Koodinaten jedes Punktes in X_d als Spaltenvektor in 
%der Reihenfolge x1,y1,z1,x2,y,y2,z2 etc.
X_d_t=[];
for i=1:1:size(X_d)
    for j=1:1:3
        X_d_t=[X_d_t;X_d(i,j)];
    end
end

%Die G-Matrix wird wie auf den Folien zur 3D-Trafo gezeigt berechnet
G=zeros(size(X_t,1),7);
%Zuerst werden in die drei linken Spalten die Einser eingefuegt
for i=1:1:size(G,1)
    G(i,(mod(i-1,3)+1))=1;
end
%Nun werden die anderen Eintraege von G berechnet. Die Ausdruecke (x-x_0'),
%(y-y_0') und (z-z_0') wurden durch aequivalente Terme ersetzt, die nur 
%Quellkoordinaten und Unbekannte beinhalten
for i=1:3:(size(G,1)-2)
    G(i,4)=m*(D(1,3)*X_t(i+1)-D(1,2)*X_t(i+2));
    G(i,5)=m*(D(3,1)*X_t(i)+D(3,2)*X_t(i+1)+D(3,3)*X_t(i+2))*cos(ez);
    G(i,6)=-(m*(D(2,1)*X_t(i)+D(2,2)*X_t(i+1)+D(2,3)*X_t(i+2)));
    G(i,7)=(1/m)*(D(1,1)*X_t(i)+D(1,2)*X_t(i+1)+D(1,3)*X_t(i+2));
    G(i+1,4)=m*(D(2,3)*X_t(i+1)-D(2,2)*X_t(i+2));
    G(i+1,5)=m*(D(3,1)*X_t(i)+D(3,2)*X_t(i+1)+D(3,3)*X_t(i+2))*sin(ez);
    G(i+1,6)=m*(D(1,1)*X_t(i)+D(1,2)*X_t(i+1)+D(1,3)*X_t(i+2));
    G(i+1,7)=(1/m)*(m*(D(2,1)*X_t(i)+D(2,2)*X_t(i+1)+D(2,3)*X_t(i+2)));
    G(i+2,4)=m*(D(3,3)*X_t(i+1)-D(3,2)*X_t(i+2));
    G(i+2,5)=m*(-cos(ey)*X_t(i)-sin(ex)*sin(ey)*X_t(i+1)-cos(ex)*sin(ey)*X_t(i+2));
    G(i+2,6)=0;
    G(i+2,7)=(1/m)*(D(3,1)*X_t(i)+D(3,2)*X_t(i+1)+D(3,3)*X_t(i+2));
end

%Jede Koordinate in X_d_t, die gleich NaN ist, und die dazugehoerige Zeile 
%in G, werden in die Arrays X_d_t_ und G_, die fuer die entgueltige 
%Berechnung der Parameter gedacht sind, nicht uebernommen
%Faktisch betrifft das also, da sich X_d u.a. aus Z berechnet, jede Zeile,
%für die die dazugehoerige Koordinate in Z NaN ist
X_d_t_=[];
G_=[];
for i=1:1:size(X_d_t)
    if isnan(X_d_t(i))==0
        X_d_t_=[X_d_t_;X_d_t(i)];
        G_=[G_;G(i,:)];
    end
end
X_d_t=X_d_t_;
G=G_;

dp=G\X_d_t;
p_=p_+transpose(dp);

%Das Abbruchkriterium fuer die Iteration wird hier durch den maximalen Wert
%unter den Koordinatendifferenzen in X_d_t und die Grenze 0.00005
%definiert. Die Grenze ist so gewaehlt, dass die Genauigkeit gleich der der
%gegebenen Koordinaten ist (vier Nachkommastellen).
X_d_t_check=max(X_d_t);
while X_d_t_check>=0.00005
    %Diese while-Schleife fuehrt dieselben Operationen wie bisher so oft
    %aus, bis das Abbruchkriterium erfuellt ist
    x0=p_(1);
    y0=p_(2);
    z0=p_(3);
    ex=p_(4);
    ey=p_(5);
    ez=p_(6);
    m=p_(7);
    
    D=zeros(3,3);
    D(1,1)=cos(ey)*cos(ez);
    D(2,1)=cos(ey)*sin(ez);
    D(3,2)=-sin(ey);
    D(1,2)=sin(ex)*sin(ey)*cos(ez)-cos(ex)*sin(ez);
    D(2,2)=sin(ex)*sin(ey)*sin(ez)+cos(ex)*cos(ez);
    D(3,2)=sin(ex)*cos(ey);
    D(1,3)=cos(ex)*sin(ey)*cos(ez)+sin(ex)*sin(ez);
    D(2,3)=cos(ex)*sin(ey)*sin(ez)-sin(ex)*cos(ez);
    D(3,3)=cos(ex)*cos(ey);
    
    X0=[x0*transpose(ones(size(X,1),1));y0*transpose(ones(size(X,1),1));z0*transpose(ones(size(X,1),1))];
    X_d=Z-transpose(X0+m*D*transpose(X));
    X_d_t=[];
    for i=1:1:size(X_d)
        for j=1:1:3
            X_d_t=[X_d_t;X_d(i,j)];
        end
    end
    
    G=zeros(size(X_t,1),7);
    for i=1:1:size(G,1)
        G(i,(mod(i-1,3)+1))=1;
    end
    for i=1:3:(size(G,1)-2)
        G(i,4)=m*(D(1,3)*X_t(i+1)-D(1,2)*X_t(i+2));
        G(i,5)=m*(D(3,1)*X_t(i)+D(3,2)*X_t(i+1)+D(3,3)*X_t(i+2))*cos(ez);
        G(i,6)=-(m*(D(2,1)*X_t(i)+D(2,2)*X_t(i+1)+D(2,3)*X_t(i+2)));
        G(i,7)=(1/m)*(D(1,1)*X_t(i)+D(1,2)*X_t(i+1)+D(1,3)*X_t(i+2));
        G(i+1,4)=m*(D(2,3)*X_t(i+1)-D(2,2)*X_t(i+2));
        G(i+1,5)=m*(D(3,1)*X_t(i)+D(3,2)*X_t(i+1)+D(3,3)*X_t(i+2))*sin(ez);
        G(i+1,6)=m*(D(1,1)*X_t(i)+D(1,2)*X_t(i+1)+D(1,3)*X_t(i+2));
        G(i+1,7)=(1/m)*(m*(D(2,1)*X_t(i)+D(2,2)*X_t(i+1)+D(2,3)*X_t(i+2)));
        G(i+2,4)=m*(D(3,3)*X_t(i+1)-D(3,2)*X_t(i+2));
        G(i+2,5)=m*(-cos(ey)*X_t(i)-sin(ex)*sin(ey)*X_t(i+1)-cos(ex)*sin(ey)*X_t(i+2));
        G(i+2,6)=0;
        G(i+2,7)=(1/m)*(D(3,1)*X_t(i)+D(3,2)*X_t(i+1)+D(3,3)*X_t(i+2));
    end
    
    X_d_t_=[];
    G_=[];
    for i=1:1:size(X_d_t)
        if isnan(X_d_t(i))==0
            X_d_t_=[X_d_t_;X_d_t(i)];
            G_=[G_;G(i,:)];
        end
    end
    X_d_t=X_d_t_;
    X_d_t_check=max(X_d_t);
    G=G_;
    
    dp=G\X_d_t;
    p_=p_+transpose(dp);
end

p=p_;
end