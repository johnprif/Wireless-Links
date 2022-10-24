function inReceiverCoords = envToReceiverCoords( PointInEnvironmentCoords, ReceiverTilt, ReceiverDirection, ReceiverPositionCart )

% Takes a point in environment coordinates and transaltes it to
% Receiver-centric coordinates

%   Tilt in rads
%   Direction in rads
%   PointInEnvironmentCoords : 3x1 matrix in cartesian coordinates 
%   inReceiverCoords           : 3x1 matrix in cartesian coordinates
%   ReceiverPositionCart       : 3x1 matrix in cartesian coordinates


            f=ReceiverDirection+pi;
            th=ReceiverTilt;
            
            ro=ReceiverPositionCart;
            
            %rotate around z-axis by +f
            A=[ cos(f)   sin(f)   0; ...
               -sin(f)   cos(f)   0; ...
                    0        0    1];   
            
            %rotate around y-axis by +th    
            B=[ cos(th)    0     sin(th); ...
                      0    1           0; ... 
               -sin(th)    0     cos(th)];
                       
            inReceiverCoords=(B*A)*(PointInEnvironmentCoords-ro);
            
end

