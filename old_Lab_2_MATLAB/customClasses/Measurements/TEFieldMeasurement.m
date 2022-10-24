classdef TEFieldMeasurement < TMeasurement
    
    properties (Constant)
        GUIName='E - V/m'; %EVERY MEASUREMENT SHOULD DEFINE a GUINAME (see TAntenna)        
    end
    
    methods 
        function obj=TEFieldMeasurement %MUST NOT TAKE ARGUMENTS  
            obj.Points{4}=[];              %MUST BE INITIALIZED AS IS IN ALL TMeasurement CHILDREN
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
            [Er Ef Eth Hr Hf Hth]=environment.Sender.Antenna.fieldAt(r, f, th, environment);
            Ex=Er*sin(th)*cos(f)+Eth*cos(th)*cos(f)-Ef*sin(f);
            Ey=Er*sin(th)*sin(f)+Eth*cos(th)*sin(f)+Ef*cos(f);
            Ez=Er*cos(th)-Eth*sin(th);
            
            %visualize:
            prompt={'Description','$E_x$','$E_y$','$E_z$'};
            name=strcat(obj.GUIName, '- Measurement Output');
            numlines=1;
            defaultanswer={obj.Description,sprintf('%f',abs(Er)),sprintf('%f',abs(Ef)),sprintf('%f',abs(Eth))};
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
                [Er Ef Eth Hr Hf Hth]=environment.Sender.Antenna.fieldAt(r, f, th, environment);        
                Ex=Er*sin(th)*cos(f)+Eth*cos(th)*cos(f)-Ef*sin(f);
                Ey=Er*sin(th)*sin(f)+Eth*cos(th)*sin(f)+Ef*cos(f);
                Ez=Er*cos(th)-Eth*sin(th);
                Px(K)=abs(Ex);
                Py(K)=abs(Ey);
                Pz(K)=abs(Ez);
                
                Cx(K)=sum(([x y z]-P1).^2).^0.5;
                Cy(K)=0;
                Cz(K)=0;
                K=K+1;
            end
            
            % Visualize
            hh=figure;
            axh=axes('Parent',hh,'NextPlot','add');
            qh=quiver3(axh,Cx,Cy,Cz,Px,Py,Pz);
            view([-14 36]);
            grid on;
            set(qh,'Marker','o','ShowArrowHead','off','MarkerSize',2);
            xlabel(sprintf('Distance from point $[%f$ $%f$ $%f]$ to $[%f$ $%f$ $%f]$', ...
                P1(1),P1(2),P1(3),P2(1),P2(2),P2(3)),'Interpreter','latex');
            zlabel(strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
            title(axh,sprintf('%s - ''o'' denotes arrow start',obj.Description),'Interpreter','latex');
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
                    [Er Ef Eth Hr Hf Hth]=environment.Sender.Antenna.fieldAt(r, f, th, environment);        
                    Ex=Er*sin(th)*cos(f)+Eth*cos(th)*cos(f)-Ef*sin(f);
                    Ey=Er*sin(th)*sin(f)+Eth*cos(th)*sin(f)+Ef*cos(f);
                    Ez=Er*cos(th)-Eth*sin(th);
                    Px(i,j)=abs(Ex);
                    Py(i,j)=abs(Ey);
                    Pz(i,j)=abs(Ez);
                    ZZ(i,j)=0;
                end
            end
            % Visualize
            hh=figure;
            axh=axes('Parent',hh,'NextPlot','add');
            qh=quiver3(axh,XX,YY,ZZ,Px,Py,Pz);
            set(qh,'Marker','o','ShowArrowHead','off','MarkerSize',2);
            grid on;
            view([-30 35]);
            xlabel(sprintf('Plane X-coordinate'),'Interpreter','latex');
            ylabel(sprintf('Plane Y-coordinate'),'Interpreter','latex');
            zlabel(strcat('$',obj.GUIName,'$'),'Interpreter','latex');            
            title(axh,sprintf('%s - ''o'' denotes arrow start',obj.Description),'Interpreter','latex');            
        end
    end
    
end

