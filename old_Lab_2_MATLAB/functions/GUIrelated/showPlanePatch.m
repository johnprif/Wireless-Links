function nph=showPlanePatch(ah, ph ,center, f, th, D)
% preview/draw the plane on the measurement setup panel 

if isempty(center)
    center=[0;0;0];
end


P=zeros(4,3);

P(1,:)=PatchToEnvCoords( [ D/4;  D/4; 0], f, th, center );
P(2,:)=PatchToEnvCoords( [-D/4;  D/4; 0], f, th, center );
P(3,:)=PatchToEnvCoords( [-D/4; -D/4; 0], f, th, center );
P(4,:)=PatchToEnvCoords( [ D/4; -D/4; 0], f, th, center );


if ph~=-1
    delete(ph);
end

nph=patch('Vertices',P,'Faces',[1 2 3 4]);
set(nph,'FaceColor','r','FaceAlpha',0.5);
set(nph,'Parent',ah);
end

