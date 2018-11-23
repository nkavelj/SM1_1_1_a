function [ p ] = trafoparam_3d_7p( X,Z,p_ )
%TRAFOPARAM_3D_7P Summary of this function goes here
%   Detailed explanation goes here
x0=p_(1);
y0=p_(2);
z0=p_(3);
ex=p_(4);
ey=p_(5);
ez=p_(6);
m=p_(7);

X_t=[];
for i=1:1:size(X)
    for j=1:1:3
        X_t=[X_t;X(i,j)];
    end
end

Z_t=[];
for i=1:1:size(Z)
    for j=1:1:3
        Z_t=[Z_t;Z(i,j)];
    end
end

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
G=G_;

dp=G\X_d_t;
p_=p_+transpose(dp);

X_d_t_check=1;
while X_d_t_check>0.00005
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