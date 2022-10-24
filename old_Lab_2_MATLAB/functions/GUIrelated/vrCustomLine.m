function [Rotation Translation Scale]=vrCustomLine(A,B,WORLD,LINEXFORM)
%Manipulates a cylinder to become a 3D-line connecting two given points.

Translation=(A+B)/2;
Scale = [1 (sum((A-B).^2).^0.5)*0.5 1];
Rotation=cross([0 1 0],B-A);
Rotation(4)=acos(sum((B-A).*[0 1 0])/(sum((B-A).^2).^0.5));

x=vrworld(WORLD);
%open(x);
%view(x);
node=vrnode(x,LINEXFORM);

T=getfield(node,'translation');
T(1)=Translation(1);
T(2)=Translation(2);
T(3)=Translation(3);
setfield(node,'translation',T);

R=getfield(node,'rotation');
R(1)=Rotation(1);
R(2)=Rotation(2);
R(3)=Rotation(3);
R(4)=Rotation(4);
setfield(node,'rotation',R);

S=getfield(node,'scale');
S(1)=Scale(1);
S(2)=Scale(2);
S(3)=Scale(3);
setfield(node,'scale',S);


return;
