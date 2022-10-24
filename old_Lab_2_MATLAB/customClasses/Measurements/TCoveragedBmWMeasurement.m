classdef TCoveragedBmWMeasurement < TMeasurement
    
    properties (Constant)
        GUIName='Coverage - dBmWatt'; %EVERY MEASUREMENT SHOULD DEFINE a GUINAME (see TAntenna)        
        Units='dBmWatt';
    end
    
    methods 
        function obj=TCoveragedBmWMeasurement %MUST NOT TAKE ARGUMENTS  
            obj.Points{4}=[];              %MUST BE INITIALIZED AS IS IN ALL TMeasurement CHILDREN
        end
        
        %ALL PAINT FUNCTIONS MUST CHECK FOR PROPER INPUTS AND ACT ACCORDINGLY                     
        function paint1D(obj, environment)
            %input
            prompt={strcat('Input Receiver''s Sensitivity in ',obj.Units)};
            name=strcat('Input Receiver''s Sensitivity in ',obj.Units);
            numlines=1;
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            answer=inputdlg(prompt,name,numlines,{''},options);      
            if numel(answer)~=1
                return;
            end
            if isnan(str2double(answer{1}))
                warndlg('Invalid Number given..');
                return;
            end
            limit=str2double(answer{1});
            
            %compute
            Side=4*environment.Receiver.HorDistanceFromSender;
            [XX,YY] = meshgrid(-0.5*Side:Side*0.05:0.5*Side, -0.5*Side:Side*0.05:0.5*Side);
            P=zeros(size(XX));
            [I, J]=size(P);
            
            hr=environment.Receiver.Height;
            
            for i=1:I
                for j=1:J
                    inEnvCoords = PatchToEnvCoords( [XX(i,j); YY(i,j);hr], obj.f, obj.th, [0;0;0] );
                    np=envToSenderCoords( inEnvCoords, environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );                    
                    [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
                    th=0.5*pi-th;                            %matlab coord crap
                    P(i,j)=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);        
                end
            end
            P=10*log10(1000*P);
            % Visualize
            error=false;
            hh=figure;

            %Draw contours
            h1=subplot(1,2,1);
            set(h1,'NextPlot','add');
                      
            try
               contour(h1,interp2(XX,4),interp2(YY,4),interp2(P,4));
            catch MException
               error=true; 
            end
            try
            colormap winter;
            catch MException
               error=true; 
            end
            try            
               [C,h]=contour3(h1,interp2(XX,4),interp2(YY,4),interp2(P,4),[limit*(0.9999999) limit*(1.0000001)],'red');
               %set(h,'ZData',zeros(get(h,'ZData')));
            catch MException
               error=true; 
            end
            try                        
               text_handle = clabel(C,h);
               set(text_handle,'BackgroundColor',[1 1 .6],'Edgecolor',[.7 .7 .7]);
            catch MException
               error=true; 
            end
            try 
               plot3(h1, 0,0,0,'r*');
               plot3(h1, environment.Receiver.HorDistanceFromSender,0,0,'ro');
            catch MException
               error=true; 
            end
            try
               xlabel(h1,sprintf('Plane X-coordinate'),'Interpreter','latex');
               ylabel(h1,sprintf('Plane Y-coordinate'),'Interpreter','latex');
               zlabel(h1,strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
               title(h1,sprintf('%s: %s \n ''*'' denotes SENDER \n ''o'' denotes RECEIVER',obj.GUIName, obj.Description),'Interpreter','latex');               
            catch MException
               error=true; 
            end

            %Draw the same in surf mode
            h2=subplot(1,2,2);
            set(h2,'NextPlot','add');
            hans=surf(h2,interp2(XX,4),interp2(YY,4),interp2(P,4));
            set(hans,'EdgeAlpha',0.1);
            view([-27 20]);
            xlabel(h2,sprintf('Plane X-coordinate'),'Interpreter','latex');
            ylabel(h2,sprintf('Plane Y-coordinate'),'Interpreter','latex');
            zlabel(h2,strcat('$',obj.GUIName,'$'),'Interpreter','latex');  
            title(h2,'Power plot and RECEIVER''s Sensitivity limit','Interpreter','latex');               


            P=zeros(4,3);
            X=get(h2,'XLim');
            Y=get(h2,'YLim');
            P(1,:)=[ X(1)  Y(1) limit];
            P(2,:)=[ X(2)  Y(1) limit];
            P(3,:)=[ X(2)  Y(2) limit];
            P(4,:)=[ X(1)  Y(2) limit];

            nph=patch('Vertices',P,'Faces',[1 2 3 4]);
            set(nph,'FaceColor','y','FaceAlpha',0.5);
            set(nph,'Parent',h2);

            %if error detected, show a warning
            if error
                warndlg('Inappropriate Loss Model or too big cut-off power selected','Warning');
            end

           
        end
        
        function paint2D(obj, environment)
            %input
            prompt={strcat('Input Receiver''s Sensitivity in ',obj.Units)};
            name=strcat('Input Receiver''s Sensitivity in ',obj.Units);
            numlines=1;
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            answer=inputdlg(prompt,name,numlines,{''},options);      
            if numel(answer)~=1
                return;
            end
            if isnan(str2double(answer{1}))
                warndlg('Invalid Number given..');
                return;
            end
            limit=str2double(answer{1});
            
            %compute
            Side=4*environment.Receiver.HorDistanceFromSender;
            [XX,YY] = meshgrid(-0.5*Side:Side*0.05:0.5*Side, -0.5*Side:Side*0.05:0.5*Side);
            P=zeros(size(XX));
            [I, J]=size(P);
            
            hr=environment.Receiver.Height;
            
            for i=1:I
                for j=1:J
                    inEnvCoords = PatchToEnvCoords( [XX(i,j); YY(i,j);hr], obj.f, obj.th, [0;0;0] );
                    np=envToSenderCoords( inEnvCoords, environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );
                    [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
                    th=0.5*pi-th;                            %matlab coord crap
                    P(i,j)=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);        
                end
            end
            P=10*log10(1000*P);
            % Visualize
            error=false;
            hh=figure;

            %Draw contours
            h1=subplot(1,2,1);
            set(h1,'NextPlot','add');
                      
            try
               contour(h1,interp2(XX,4),interp2(YY,4),interp2(P,4));
            catch MException
               error=true; 
            end
            try
            colormap winter;
            catch MException
               error=true; 
            end
            try            
               [C,h]=contour3(h1,interp2(XX,4),interp2(YY,4),interp2(P,4),[limit*(0.9999999) limit*(1.0000001)],'red');
               %set(h,'ZData',zeros(get(h,'ZData')));
            catch MException
               error=true; 
            end
            try                        
               text_handle = clabel(C,h);
               set(text_handle,'BackgroundColor',[1 1 .6],'Edgecolor',[.7 .7 .7]);
            catch MException
               error=true; 
            end
            try 
               plot3(h1, 0,0,0,'r*');
               plot3(h1, environment.Receiver.HorDistanceFromSender,0,0,'ro');
            catch MException
               error=true; 
            end
            try
               xlabel(h1,sprintf('Plane X-coordinate'),'Interpreter','latex');
               ylabel(h1,sprintf('Plane Y-coordinate'),'Interpreter','latex');
               zlabel(h1,strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
               title(h1,sprintf('%s: %s \n ''*'' denotes SENDER \n ''o'' denotes RECEIVER',obj.GUIName, obj.Description),'Interpreter','latex');               
            catch MException
               error=true; 
            end

            %Draw the same in surf mode
            h2=subplot(1,2,2);
            set(h2,'NextPlot','add');
            hans=surf(h2,interp2(XX,4),interp2(YY,4),interp2(P,4));
            set(hans,'EdgeAlpha',0.1);
            view([-27 20]);
            xlabel(h2,sprintf('Plane X-coordinate'),'Interpreter','latex');
            ylabel(h2,sprintf('Plane Y-coordinate'),'Interpreter','latex');
            zlabel(h2,strcat('$',obj.GUIName,'$'),'Interpreter','latex');  
            title(h2,'Power plot and RECEIVER''s Sensitivity limit','Interpreter','latex');               


            P=zeros(4,3);
            X=get(h2,'XLim');
            Y=get(h2,'YLim');
            P(1,:)=[ X(1)  Y(1) limit];
            P(2,:)=[ X(2)  Y(1) limit];
            P(3,:)=[ X(2)  Y(2) limit];
            P(4,:)=[ X(1)  Y(2) limit];

            nph=patch('Vertices',P,'Faces',[1 2 3 4]);
            set(nph,'FaceColor','y','FaceAlpha',0.5);
            set(nph,'Parent',h2);

            %if error detected, show a warning
            if error
                warndlg('Inappropriate Loss Model or too big cut-off power selected','Warning');
            end
        end
        
        function paint3D(obj, environment)
            %input
            prompt={strcat('Input Receiver''s Sensitivity in ',obj.Units)};
            name=strcat('Input Receiver''s Sensitivity in ',obj.Units);
            numlines=1;
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            answer=inputdlg(prompt,name,numlines,{''},options);      
            if numel(answer)~=1
                return;
            end
            if isnan(str2double(answer{1}))
                warndlg('Invalid Number given..');
                return;
            end
            limit=str2double(answer{1});
            
            %compute
            Side=4*environment.Receiver.HorDistanceFromSender;
            [XX,YY] = meshgrid(-0.5*Side:Side*0.05:0.5*Side, -0.5*Side:Side*0.05:0.5*Side);
            P=zeros(size(XX));
            [I, J]=size(1000*P);
            
            hr=environment.Receiver.Height;
            
            for i=1:I
                for j=1:J
                    inEnvCoords = PatchToEnvCoords( [XX(i,j); YY(i,j);hr], obj.f, obj.th, [0;0;0] );
                    np=envToSenderCoords( inEnvCoords, environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );
                    [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
                    th=0.5*pi-th;                            %matlab coord crap
                    P(i,j)=environment.Sender.Antenna.PowerAtPoint(r, f, th, environment);        
                end
            end
            P=10*log10(1000*P);
            % Visualize
            error=false;
            hh=figure;

            %Draw contours
            h1=subplot(1,2,1);
            set(h1,'NextPlot','add');
                      
            try
               contour(h1,interp2(XX,4),interp2(YY,4),interp2(P,4));
            catch MException
               error=true; 
            end
            try
            colormap winter;
            catch MException
               error=true; 
            end
            try            
               [C,h]=contour3(h1,interp2(XX,4),interp2(YY,4),interp2(P,4),[limit*(0.9999999) limit*(1.0000001)],'red');
               %set(h,'ZData',zeros(get(h,'ZData')));
            catch MException
               error=true; 
            end
            try                        
               text_handle = clabel(C,h);
               set(text_handle,'BackgroundColor',[1 1 .6],'Edgecolor',[.7 .7 .7]);
            catch MException
               error=true; 
            end
            try 
               plot3(h1, 0,0,0,'r*');
               plot3(h1, environment.Receiver.HorDistanceFromSender,0,0,'ro');
            catch MException
               error=true; 
            end
            try
               xlabel(h1,sprintf('Plane X-coordinate'),'Interpreter','latex');
               ylabel(h1,sprintf('Plane Y-coordinate'),'Interpreter','latex');
               zlabel(h1,strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
               title(h1,sprintf('%s: %s \n ''*'' denotes SENDER \n ''o'' denotes RECEIVER',obj.GUIName, obj.Description),'Interpreter','latex');               
            catch MException
               error=true; 
            end

            %Draw the same in surf mode
            h2=subplot(1,2,2);
            set(h2,'NextPlot','add');
            hans=surf(h2,interp2(XX,4),interp2(YY,4),interp2(P,4));
            set(hans,'EdgeAlpha',0.1);
            view([-27 20]);
            xlabel(h2,sprintf('Plane X-coordinate'),'Interpreter','latex');
            ylabel(h2,sprintf('Plane Y-coordinate'),'Interpreter','latex');
            zlabel(h2,strcat('$',obj.GUIName,'$'),'Interpreter','latex');  
            title(h2,'Power plot and RECEIVER''s Sensitivity limit','Interpreter','latex');               


            P=zeros(4,3);
            X=get(h2,'XLim');
            Y=get(h2,'YLim');
            P(1,:)=[ X(1)  Y(1) limit];
            P(2,:)=[ X(2)  Y(1) limit];
            P(3,:)=[ X(2)  Y(2) limit];
            P(4,:)=[ X(1)  Y(2) limit];

            nph=patch('Vertices',P,'Faces',[1 2 3 4]);
            set(nph,'FaceColor','y','FaceAlpha',0.5);
            set(nph,'Parent',h2);

            %if error detected, show a warning
            if error
                warndlg('Inappropriate Loss Model or too big cut-off power selected','Warning');
            end
        end
    end
    
end

