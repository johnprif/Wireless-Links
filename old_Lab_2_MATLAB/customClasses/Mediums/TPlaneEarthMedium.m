classdef TPlaneEarthMedium < TMedium

   properties (Constant)
        GUIName='Plane Earth'; %EVERY MEDIUM SHOULD DEFINE a GUINAME   
        ReflectionLoss=-1;   % Reflection Loss
   end
    
   methods
        function obj=TPlaneEarthMedium %CONSTRUCTOR MUST NOT TAKE ARGUMENTS!
        end
        
        function L=Loss(obj, point, Environment)
            r=point(1);
            f=point(2);
            th=point(3);
            
            R=obj.ReflectionLoss;
            
            l=r*sin(th); %horizontal distance
            hb=Environment.Sender.Height;
            hm=hb-r*cos(th);
            
            frequency=Environment.Sender.Signal.F;
            lamda=obj.c/frequency;
            k=2*pi/lamda;
            
            L=( ((4*pi*l)/lamda)/abs(1+R*exp(1i*k*2*hm*hb/l))   )^2;
        end
   end
    
end

