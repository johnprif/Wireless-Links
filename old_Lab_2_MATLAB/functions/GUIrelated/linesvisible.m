function linesvisible( bool )
% set visibility of lines in the demo.
x=vrworld('myworld.wrl');
open(x);
sw=vrnode(x,'LINESWITCH');
if bool
   setfield(sw,'whichChoice',0);
else
   setfield(sw,'whichChoice',-1); 
end

end

