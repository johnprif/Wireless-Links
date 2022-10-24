function inEnvCoords = PatchToEnvCoords( PointInPatchCoords, PatchLift, PatchTilt, PatchPositionCart )

% Takes a point in Patch-centric coordinates and transaltes it to
% environment coordinates

%   Tilt in rads
%   Direction in rads
%   PointInEnvironmentCoords : 3x1 matrix in cartesian coordinates 
%   inPatchCoords           : 3x1 matrix in cartesian coordinates
%   PatchPositionCart       : 3x1 matrix in cartesian coordinates -patch center

         
            f=PatchTilt;
            th=PatchLift;
            
            ro=PatchPositionCart;
            
            %rotate around z-axis by +f
            A=[ cos(f)   sin(f)   0; ...
               -sin(f)   cos(f)   0; ...
                    0        0    1];   
            
            %rotate around y-axis by +th    
            B=[ cos(th)    0     sin(th); ...
                      0    1           0; ... 
               -sin(th)    0     cos(th)];
                       
            C=(B*A)^(-1);
            
            inEnvCoords=(C*PointInPatchCoords)+ro;
            
end
