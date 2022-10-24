function inSenderCoords = envToSenderCoords( PointInEnvironmentCoords, SenderTilt, SenderDirection, SenderPositionCart )

% Takes a point in environment coordinates and transaltes it to
% Sender-centric coordinates

%   Tilt in rads
%   Direction in rads
%   PointInEnvironmentCoords : 3x1 matrix in cartesian coordinates 
%   inSenderCoords           : 3x1 matrix in cartesian coordinates
%   SenderPositionCart       : 3x1 matrix in cartesian coordinates


            f=-SenderDirection;
            th=-SenderTilt;
            
            ro=SenderPositionCart;
            
            %rotate around z-axis by +f
            A=[ cos(f)   sin(f)   0; ...
               -sin(f)   cos(f)   0; ...
                    0        0    1];   
            
            %rotate around y-axis by +th    
            B=[ cos(th)    0     sin(th); ...
                      0    1           0; ... 
               -sin(th)    0     cos(th)];
                       
            inSenderCoords=(B*A)*(PointInEnvironmentCoords-ro);
            
end

