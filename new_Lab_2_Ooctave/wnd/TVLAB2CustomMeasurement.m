classdef TVLABS2CustomMeasurement < TMeasurement
    
    properties (Constant)
        GUIName='VLABS2: Received Power - Watt'; %EVERY MEASUREMENT SHOULD DEFINE a GUINAME (see TAntenna)        
    end
    
    methods 
        function obj=TVLABS2CustomMeasurement %MUST NOT TAKE ARGUMENTS  
            obj.Points{4}=[];                      %MUST BE INITIALIZED AS IS IN ALL TMeasurement CHILDREN
        end
        
        %ALL PAINT FUNCTIONS MUST CHECK FOR PROPER INPUTS AND ACT ACCORDINGLY                     
        function [Gs Gr L]=paint1D(environment)
            %check  -- NOT REQUIRED HERE!!
            
            %compute
            np=envToSenderCoords( [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height], ...
                                  environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            Gs=environment.Sender.Antenna.Gain(r, f, th, environment);
            %P=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);
            
                    %Now calculate Receiver's Gain
            p=envToReceiverCoords( [0;0;environment.Sender.Height], environment.Receiver.Tilt, environment.Receiver.Direction, ...
                                 [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height] );
            [f, th, r]=cart2sph(p(1),p(2),p(3));  %matlab coord crap
            th=0.5*pi-th;                         %matlab coord crap
            Gr=environment.Receiver.Antenna.Gain(r, f, th, environment);   
            
            
            L=environment.Medium.Loss([r f th], environment);
            %P=P*Gr;
            %Gs=(P*L/Gr)/environment.Sender.Signal.P;
            
        end

        function [Gs Gr L]=paint2D(obj, environment)
            %check  -- NOT REQUIRED HERE!!
            
            %compute
            np=envToSenderCoords( [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height], ...
                                  environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            Gs=environment.Sender.Antenna.Gain(r, f, th, environment);
            %P=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);
            
                    %Now calculate Receiver's Gain
            p=envToReceiverCoords( [0;0;environment.Sender.Height], environment.Receiver.Tilt, environment.Receiver.Direction, ...
                                 [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height] );
            [f, th, r]=cart2sph(p(1),p(2),p(3));  %matlab coord crap
            th=0.5*pi-th;                         %matlab coord crap
            Gr=environment.Receiver.Antenna.Gain(r, f, th, environment);   
            
            
            L=environment.Medium.Loss([r f th], environment);
            %P=P*Gr;
            %Gs=(P*L/Gr)/environment.Sender.Signal.P;
            
        end

        function [Gs Gr L]=paint3D(obj, environment)
            %check  -- NOT REQUIRED HERE!!
            
            %compute
            np=envToSenderCoords( [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height], ...
                                  environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            Gs=environment.Sender.Antenna.Gain(r, f, th, environment);
            %P=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);
            
                    %Now calculate Receiver's Gain
            p=envToReceiverCoords( [0;0;environment.Sender.Height], environment.Receiver.Tilt, environment.Receiver.Direction, ...
                                 [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height] );
            [f, th, r]=cart2sph(p(1),p(2),p(3));  %matlab coord crap
            th=0.5*pi-th;                         %matlab coord crap
            Gr=environment.Receiver.Antenna.Gain(r, f, th, environment);   
            
            
            L=environment.Medium.Loss([r f th], environment);
            %P=P*Gr;
            %Gs=(P*L/Gr)/environment.Sender.Signal.P;
            
        end        
    end
    
end

