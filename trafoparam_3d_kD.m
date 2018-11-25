function [ p ] = trafoparam_3d_kD( Q,Z )
%TRAFOPARAM_3D_KD 3D Transformation für kleine Drehwinkel

%Vektor aus Matrix  der Zielkoordinaten:

n=length(Q);
Zs = [];
for i=1:1:length(Z)
    for j=1:1:3
        Zs=[Zs;Z(i,j)];
    end
    
%Aufstellen der G-Matrix:

G=zeros(n,7);

%Einfügen der Einsen
for i=1:1:n*3
    G(i,(mod(i-1,3)+1))=1;
end
%Einfüge der Punktkoordinaten
for i=1:1:n
    G(3*i-2,7)=Q(i,1);
    G(3*i-2,6)=-Q(i,2);
    G(3*i-2,5)=Q(i,3);
    G(3*i-1,7)=Q(i,2);
    G(3*i-1,6)=Q(i,1);
    G(3*i-1,4)=-Q(i,3);
    G(3*i,7)=Q(i,3);
    G(3*i,5)=-Q(i,1);
    G(3*i,4)=Q(i,2);
end

% Herauslöschen der NaN Elemente 

Z_=[];
G_=[];
for i=1:1:length(Zs)
    if isnan(Zs(i))==0
        Z_=[Z_;Zs(i)];
        G_=[G_;G(i,:)];
    end
end

%Lösen des Gleichungssystems, um die Parameter zu berechnen
p=G_\Z_;
    
    
end