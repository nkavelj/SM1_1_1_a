function [ t ] = trafoparam_3d_12p ( X,Z )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
G=zeros(15,12);
for i=1:1:15
    G(i,(mod(i-1,3)+1))=1;
end
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
Zs = [];
for i=1:1:5
    for j=1:1:3
        Zs=[Zs;Z(i,j)];
    end
end
Z_=[];
G_=[];
for i=1:1:15
    if isnan(Zs(i))==0
        Z_=[Z_;Zs(i)];
        G_=[G_;G(i,:)];
    end
end
t=G_\Z_;
m1=sqrt(t(4)^2+t(7)^2+t(10)^2);
m2=sqrt(t(5)^2+t(8)^2+t(11)^2);
m3=sqrt(t(6)^2+t(9)^2+t(12)^2);
m=(m1+m2+m3)/3;
ex=atan2(t(11),t(12));
ey=atan2(-t(10),sqrt(t(4)^2+t(7)^2));
ez=atan2(t(7),t(4));
end

