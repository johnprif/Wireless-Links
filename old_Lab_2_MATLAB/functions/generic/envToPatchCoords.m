function inPatchCoords = envToPatchCoords( PointInEnvironmentCoords, PatchLift, PatchTilt, PatchPositionCart )

% Takes a point in environment coordinates and transaltes it to
% Patch-centric coordinates

%   Tilt in rads
%   Direction in rads
%   PointInEnvironmentCoords : 3x1 matrix in cartesian coordinates 
%   inPatchCoords           : 3x1 matrix in cartesian coordinates
%   PatchPositionCart       : 3x1 matrix in cartesian coordinates  - patch center


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
                       
            inPatchCoords=(B*A)*(PointInEnvironmentCoords-ro);
            
end

