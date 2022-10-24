classdef TRadialPowerDensityWMeasurement < TMeasurement
    
    properties (Constant)
        GUIName='Radial Power Density - W/m^2'; %EVERY MEASUREMENT SHOULD DEFINE a GUINAME (see TAntenna)        
    end
    
    methods 
        function obj=TRadialPowerDensityWMeasurement %MUST NOT TAKE ARGUMENTS  
            obj.Points{4}=[];                      %MUST BE INITIALIZED AS IS IN ALL TMeasurement CHILDREN
        end
        
        %ALL PAINT FUNCTIONS MUST CHECK FOR PROPER INPUTS AND ACT ACCORDINGLY                     
        function paint1D(obj, environment)
            %check
            if numel(obj.Points{1})~=3
                warndlg(sprintf('User requested %s measurement at a point, but no point selected!',obj.GUIName),'Point Missing.'); 
                return;
            end
            
            %compute
            np=envToSenderCoords( obj.Points{1}', environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );           
            [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
            th=0.5*pi-th;                            %matlab coord crap
            P=environment.Sender.Antenna.RadialPowerDensity(r, f, th, environment);

%            P=10*log10(P);       %dB
%            P=10*log10(1000*P);  %dBm
%            P=1000*P;            %m
            
            %visualize:
            prompt={'Description',sprintf('$%s$',obj.GUIName)};
            name='Measurement Output';
            numlines=1;
            defaultanswer={obj.Description,sprintf('%f',P)};
            options.Resize='on';
            options.WindowStyle='modal';
            options.Interpreter='latex';
            inputdlg(prompt,name,numlines,defaultanswer,options);            
        end
        
        function paint2D(obj, environment)
            %check
            if (numel(obj.Points{2})~=3) || (numel(obj.Points{3})~=3)
                warndlg(sprintf('User requested %s measurement at a line, but no proper line points selected!',obj.GUIName),'Point Missing.'); 
                return;
            end
            
            %Compute
            P1=obj.Points{2};
            P2=obj.Points{3};
            K=1;
            for t=0.0001:1/50:0.999999
                x=t*(P2(1)-P1(1))+P1(1);
                y=t*(P2(2)-P1(2))+P1(2);
                z=t*(P2(3)-P1(3))+P1(3);
                np=envToSenderCoords( [x;y;z], environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );
                [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
                th=0.5*pi-th;                            %matlab coord crap
                P(K)=environment.Sender.Antenna.RadialPowerDensity(r, f, th, environment);                
                D(K)=sum(([x y z]-P1).^2).^0.5;
                K=K+1;
            end
            
%            P=10*log10(P);       %dB
%            P=10*log10(1000*P);  %dBm
%            P=1000*P;            %m
            
            % Visualize
            hh=figure;
            axh=axes('Parent',hh,'NextPlot','add');
            plot(axh,D,P);
            xlabel(sprintf('Distance from point $[%f$ $%f$ $%f]$ to $[%f$ $%f$ $%f]$', ...
                P1(1),P1(2),P1(3),P2(1),P2(2),P2(3)),'Interpreter','latex');
            ylabel(strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
            title(axh,sprintf('%s',obj.Description),'Interpreter','latex');
        end
        
        function paint3D(obj, environment)
            %check
            if numel(obj.Points{4})~=3
                warndlg(sprintf('User requested %s measurement at a plane, but no plane center selected!',obj.GUIName),'Point Missing.'); 
                return;
            end
           
            %compute
            [XX,YY] = meshgrid(-0.5*obj.D:obj.D*0.05:0.5*obj.D, -0.5*obj.W:obj.W*0.05:0.5*obj.W);
            P=zeros(size(XX));
            [I, J]=size(P);
            
            for i=1:I
                for j=1:J
                    inEnvCoords = PatchToEnvCoords( [XX(i,j); YY(i,j);0], obj.f, obj.th, obj.Points{4}' );
                    np=envToSenderCoords( inEnvCoords, environment.Sender.Tilt, environment.Sender.Direction, [0;0;environment.Sender.Height] );
                    [f, th, r]=cart2sph(np(1),np(2),np(3));  %matlab coord crap
                    th=0.5*pi-th;                            %matlab coord crap
                    P(i,j)=environment.Sender.Antenna.RadialPowerDensity(r, f, th, environment);                                   
                end
            end
%            P=10*log10(P);       %dB
%            P=10*log10(1000*P);  %dBm
%            P=1000*P;            %m

            % Visualize
            hh=figure;
            axh=axes('Parent',hh,'NextPlot','add');
            mesh(axh,XX,YY,P);      
            grid on;
            view([-30 35]);
            xlabel(sprintf('Plane X-coordinate'),'Interpreter','latex');
            ylabel(sprintf('Plane Y-coordinate'),'Interpreter','latex');
            zlabel(strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
            title(axh,sprintf('%s',obj.Description),'Interpreter','latex');            
        end
    end
    
end

