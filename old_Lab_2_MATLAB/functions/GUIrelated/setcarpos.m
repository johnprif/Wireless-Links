function  setcarpos( carpos )
% Moves the 3D car to a defined point.
x=vrworld('myworld.wrl');
carXFnode=vrnode(x,'CARXFORM');
cart=getfield(carXFnode,'translation');
cart(3)=carpos;
setfield(carXFnode,'translation',cart);
end

