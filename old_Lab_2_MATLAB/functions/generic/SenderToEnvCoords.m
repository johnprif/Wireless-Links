function inEnvCoords = SenderToEnvCoords( PointInSenderCoords, SenderTilt, SenderDirection, SenderPositionCart )

% Takes a point in Sender-centric coordinates and transaltes it to
% environment coordinates

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
                       
            C=(B*A)^(-1);
            
            inEnvCoords=(C*PointInSenderCoords)+ro;
            
end
