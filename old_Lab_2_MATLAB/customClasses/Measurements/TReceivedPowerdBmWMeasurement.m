classdef TReceivedPowerdBmWMeasurement < TMeasurement
    
    properties (Constant)
        GUIName='Received Power - dBmWatt'; %EVERY MEASUREMENT SHOULD DEFINE a GUINAME (see TAntenna)        
    end
    
    methods 
        function obj=TReceivedPowerdBmWMeasurement %MUST NOT TAKE ARGUMENTS  
            obj.Points{4}=[];                      %MUST BE INITIALIZED AS IS IN ALL TMeasurement CHILDREN
        end
        
        %ALL PAINT FUNCTIONS MUST CHECK FOR PROPER INPUTS AND ACT ACCORDINGLY                     
        function paint1D(obj, environment)
            %check  -- NOT REQUIRED HERE!!
            
            %compute
            np=envToSenderCoords( [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height], ...
                                  environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            P=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);
                    %Now calculate Receiver's Gain
            p=envToReceiverCoords( [0;0;environment.Sender.Height], environment.Receiver.Tilt, environment.Receiver.Direction, ...
                                 [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height] );
            [f, th, r]=cart2sph(p(1),p(2),p(3));  %matlab coord crap
            th=0.5*pi-th;                         %matlab coord crap
            Gr=environment.Receiver.Antenna.Gain(r, f, th, environment);
            P=P*Gr;
            
%            P=10*log10(P);       %dB
            P=10*log10(1000*P);  %dBm
%            P=1000*P;            %m
            
            %visualize:
            prompt={'Description',obj.GUIName};
            name='Measurement Output - ONLY APPLICABLE AT THE RECEIVER';
            numlines=1;
            defaultanswer={obj.Description,sprintf('%f',P)};
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            inputdlg(prompt,name,numlines,defaultanswer,options);            
        end
        
        function paint2D(obj, environment)
            %check  -- NOT REQUIRED HERE!!
            
            %compute
            np=envToSenderCoords( [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height], ...
                                  environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            P=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);
                    %Now calculate Receiver's Gain
            p=envToReceiverCoords( [0;0;environment.Sender.Height], environment.Receiver.Tilt, environment.Receiver.Direction, ...
                                 [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height] );
            [f, th, r]=cart2sph(p(1),p(2),p(3));  %matlab coord crap
            th=0.5*pi-th;                         %matlab coord crap
            Gr=environment.Receiver.Antenna.Gain(r, f, th, environment);
            P=P*Gr;
            
%            P=10*log10(P);       %dB
            P=10*log10(1000*P);  %dBm
%            P=1000*P;            %m
            
            %visualize:
            prompt={'Description',obj.GUIName};
            name='Measurement Output - ONLY APPLICABLE AT THE RECEIVER';
            numlines=1;
            defaultanswer={obj.Description,sprintf('%f',P)};
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            inputdlg(prompt,name,numlines,defaultanswer,options);            
        end
        
        function paint3D(obj, environment)
            %check  -- NOT REQUIRED HERE!!
            
            %compute
            np=envToSenderCoords( [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height], ...
                                  environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            P=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);
                    %Now calculate Receiver's Gain
            p=envToReceiverCoords( [0;0;environment.Sender.Height], environment.Receiver.Tilt, environment.Receiver.Direction, ...
                                 [environment.Receiver.HorDistanceFromSender;0;environment.Receiver.Height] );
            [f, th, r]=cart2sph(p(1),p(2),p(3));  %matlab coord crap
            th=0.5*pi-th;                         %matlab coord crap
            Gr=environment.Receiver.Antenna.Gain(r, f, th, environment);
            P=P*Gr;
            
%            P=10*log10(P);       %dB
            P=10*log10(1000*P);  %dBm
%            P=1000*P;            %m
            
            %visualize:
            prompt={'Description',obj.GUIName};
            name='Measurement Output - ONLY APPLICABLE AT THE RECEIVER';
            numlines=1;
            defaultanswer={obj.Description,sprintf('%f',P)};
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            inputdlg(prompt,name,numlines,defaultanswer,options);            
        end
    end
    
end

