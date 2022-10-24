function drawlines(carPos)
% Draws the LOS and NLOS 3D lines in the demo
setcarpos(carPos);

x=vrworld('myworld.wrl');
open(x);
car=vrnode(x,'CARXFORM');
ant=vrnode(x,'ANTENNAMAINXFORM');

A=getfield(ant,'translation');
C=getfield(car,'translation');

Pa=[A(1) A(2) A(3)];
Pc=[C(1) C(2) C(3)];

P1=[43 -5 -56];
P2=[43 -5  14];
P3=[43 -5  71];

vrCustomLine(Pa, P1, 'myworld.wrl', 'LINE11');
vrCustomLine(P1, Pc, 'myworld.wrl', 'LINE12');

vrCustomLine(Pa, P2, 'myworld.wrl', 'LINE21');
vrCustomLine(P2, Pc, 'myworld.wrl', 'LINE22');

vrCustomLine(Pa, P3, 'myworld.wrl', 'LINE31');
vrCustomLine(P3, Pc, 'myworld.wrl', 'LINE32');

vrCustomLine(Pa, Pc, 'myworld.wrl', 'LINE');

return;