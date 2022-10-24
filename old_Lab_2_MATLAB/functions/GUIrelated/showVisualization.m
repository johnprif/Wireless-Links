function showVisualization(af, environment, boolSenderPat, boolRecvPat, boolTopo, boolDLines, boolEarth)
% Depicts the current environment at axes 'af'.
% environment is the relevant class instance
% boolSenderPat : boolean for show Sender Power Pattern
% boolRecvPat : boolean for show Receiver Power Pattern
% boolTopo : boolean for show Topology Geometry () 
% boolDLines : boolean for show directivity lines '--' 
% boolEarth : boolean for show earth plane as a green mesh
% Feel free to add you own implementations of 'showVisualization' function.

% This version is optimized for speed: all needed functions are inline.

noFig=af; %keep a backup just in case..

%helper variables 
D=environment.Receiver.HorDistanceFromSender;
fs=environment.Sender.Direction;
hs=environment.Sender.Height;
hr=environment.Receiver.Height;
fr=environment.Receiver.Direction;
    %These are conventions for the directivity lines.
    %Should you replace the line drawing algorithm, these will not be needed. 
thr=-environment.Receiver.Tilt+pi/2;
ths=environment.Sender.Tilt+pi/2;

%Avoid negative values! Antennas cannot be burried...
if hr<=0
    hr=0.001;
end

if hs<=0
    hs=0.001;
end

%setup axis
if af==0       %if no axis supplied, create one on a new figure.
    hf=figure;
    af=axes('Parent',hf);
    set(af,'NextPlot','add','Box','on','DataAspectRatioMode','manual','CameraPosition',[D/2 -4*D 10*max([hr hs])]);
end
set(af,'DataAspectRatio',[1 1 1]);


if boolEarth  %draw earth
    [X,Y] = meshgrid((-10):(D+10),-D*0.5:D*0.5);
    Z=zeros(size(X));
    surf(af,X,Y,Z,'EdgeAlpha',0,'FaceColor','green','FaceLighting','phong');
end

if boolTopo  % draw Topology
    
    hl=line([0 0] , [0 0], [0 hs], 'Color','blue');
    set(hl,'Parent',af);
    hl=line([D D] , [0 0], [0 hr], 'Color','red');
    set(hl,'Parent',af);
    
end

if boolDLines  % Draw directivity lines: lines cannot be very big! will hinder proper visualization. Thus limit them to a bounding box 
    gca=af;
    %Sender
    point1=[0 0 hs];
    point2=[0 0 0];

    z=0;
    x=(z-hs)*tan(ths)*cos(fs);
    y=(hs-z)*tan(ths)*sin(fs);
    if isInBoundingBox(x,y,z,D,max([hr hs]),ths,fs,hs)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','blue','LineStyle','--');
        set(hl,'Parent',af);
    end
    
    z=max([hr hs])*1.1;
    x=(z-hs)*tan(ths)*cos(fs);
    y=(hs-z)*tan(ths)*sin(fs);
    if isInBoundingBox(x,y,z,D,max([hr hs]),ths,fs,hs)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','blue','LineStyle','--');
        set(hl,'Parent',af);
    end
    
    x=-10;
    y=-x*tan(fs);
    z=hs+x*cos(ths)/(sin(ths)*cos(fs));
    if isInBoundingBox(x,y,z,D,max([hr hs]),ths,fs,hs)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','blue','LineStyle','--');
        set(hl,'Parent',af);
    end
    
    x=D+10;
    y=-x*tan(fs);
    z=hs+x*cos(ths)/(sin(ths)*cos(fs));
    if isInBoundingBox(x,y,z,D,max([hr hs]),ths,fs,hs)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','blue','LineStyle','--');
        set(hl,'Parent',af);
    end

    y=-D*0.5;
    x=-y*cot(fs);
    z=hs-y*cos(ths)/(sin(ths)*sin(fs));
    if isInBoundingBox(x,y,z,D,max([hr hs]),ths,fs,hs)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','blue','LineStyle','--');
        set(hl,'Parent',af);
    end

    y=D*0.5;
    x=-y*cot(fs);
    z=hs-y*cos(ths)/(sin(ths)*sin(fs));
    if isInBoundingBox(x,y,z,D,max([hr hs]),ths,fs,hs)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','blue','LineStyle','--');
        set(hl,'Parent',af);
    end
    
%Receiver
    point1=[D 0 hr];
    point2=[D 0 0];
       
    x=-10;
    z=hr+(x-D)*cot(thr)/cos(pi+fr);
    y=(x-D)*tan(pi+fr);
    
    if isInBoundingBoxRecv(x,y,z,D,max([hr hs]),thr,fr,hr)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','red','LineStyle','--');
        set(hl,'Parent',af);
    end
    
    x=D+10;
    z=hr+(x-D)*cot(thr)/cos(pi+fr);
    y=(x-D)*tan(pi+fr);
    if isInBoundingBoxRecv(x,y,z,D,max([hr hs]),thr,fr,hr)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','red','LineStyle','--');
        set(hl,'Parent',af);
    end
    
    z=0;
    y=(z-hr)*tan(thr)*sin(pi+fr);
    x=D+(z-hr)*tan(thr)*cos(pi+fr);
    if isInBoundingBoxRecv(x,y,z,D,max([hr hs]),thr,fr,hr)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','red','LineStyle','--');
        set(hl,'Parent',af);
    end
    
    z=max([hr hs])*1.1;
    y=(z-hr)*tan(thr)*sin(pi+fr);
    x=D+(z-hr)*tan(thr)*cos(pi+fr);
    if isInBoundingBoxRecv(x,y,z,D,max([hr hs]),thr,fr,hr)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','red','LineStyle','--');
        set(hl,'Parent',af);
    end

    y=-D*0.5;
    x=D+y*cot(pi+fr);
    z=hr+y*cot(thr)/sin(pi+fr);
    if isInBoundingBoxRecv(x,y,z,D,max([hr hs]),thr,fr,hr)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','red','LineStyle','--');
        set(hl,'Parent',af);
    end

    y=D*0.5;
    x=D+y*cot(pi+fr);
    z=hr+y*cot(thr)/sin(pi+fr);
    if isInBoundingBoxRecv(x,y,z,D,max([hr hs]),thr,fr,hr)
        point2=[x y z];
        hl=line([point1(1) point2(1)] , [point1(2) point2(2)], [point1(3) point2(3)], 'Color','red','LineStyle','--');
        set(hl,'Parent',af);
    end    
    

end

%make sure everything is untouched: entering critical section
ths= environment.Sender.Tilt;
thr= environment.Receiver.Tilt;
fs = environment.Sender.Direction;
fr = environment.Receiver.Direction;
hs = environment.Sender.Height;
hr = environment.Receiver.Height;

if boolSenderPat
            %create a mesh 
            phi = -pi:pi/120:pi;
            theta = 0:pi/120:pi;
            [phi2,theta2] = meshgrid(phi,theta);

            %make sure the pattern is drawn as in free space medium
            Environment=environment;
            Environment.Medium=TFreeSpaceMedium;            

            %calculate R coordinates and scale them at (20%)Field Depth for better viewing 
            R = environment.Sender.Antenna.PowerAtMesh(1, phi2, theta2, Environment);
            Rmax=max(max(R));
            R=R*D*0.2/Rmax;
            
            %Translate to cartesian: SPH2CART uses MATLAB coord system!
            %thus phi<->theta and phi=pi/2-phi 
            [XX,YY,ZZ] = sph2cart(phi2,pi/2-theta2,R);

            %create the surf and get X,Y,Z data
            handle_s=surf(af,XX,YY,ZZ,'EdgeAlpha',0,'FaceAlpha',0.3);            
            XData=get(handle_s,'XData');
            YData=get(handle_s,'YData');
            ZData=get(handle_s,'ZData');
            
            %X,Y,Z Data are in sender-centric coordinates, so rotate them accordingly!
            %Setting rotation matrix:  r_antenna = (Mth * Mf) * (r_env - r_o)
            %Also see SenderToEnvCoords.m - here inline for speed
            
            % Sender system conventions
            f=-fs;
            th=-ths;
            
            %Mf: rotate around z-axis by +f
            A=[ cos(f)    sin(f)   0; ...
               -sin(f)    cos(f)   0; ...
                    0         0    1];   
            
            %Mth: rotate around y-axis by +th    
            B=[ cos(th)    0     sin(th); ...
                      0    1           0; ... 
               -sin(th)    0     cos(th)];
            
            C=(B*A)^(-1);
            
            ro=[ 0 ;...
                 0 ;...
                 hs];
            
            %parallelization thwarts performance here...
            for I=1:size(ZData,1)
                for J=1:size(ZData,2)
                    xx=XData(I,J);
                    yy=YData(I,J);
                    zz=ZData(I,J);
                    v=[xx; yy; zz];
                    vn=(C*v)+ro;
                    XData(I,J)=vn(1);
                    YData(I,J)=vn(2);
                    ZData(I,J)=vn(3);                    
                end
            end            
           
            set(handle_s,'XData',XData);
            set(handle_s,'YData',YData);
            set(handle_s,'ZData',ZData);

end

if boolRecvPat
            %create a mesh 
            phi = (-pi):pi/120:(pi);
            theta = 0:pi/120:pi;
            [phi2,theta2] = meshgrid(phi,theta);
            
            %make sure the pattern is drawn as in free space medium
            Environment=environment;
            Environment.Medium=TFreeSpaceMedium;

            %calculate R coordinates and scale them at (20%)Field Depth for better viewing             
            R = environment.Receiver.Antenna.PowerAtMesh(1, phi2, theta2, Environment);
            Rmax=max(max(R));
            R=R*D*0.2/Rmax;
            [XX,YY,ZZ] = sph2cart(phi2,pi/2-theta2,R);

            %create the surf and get X,Y,Z data            
            handle_r=surf(af,XX,YY,ZZ,'EdgeAlpha',0,'FaceAlpha',0.3);
            XData=get(handle_r,'XData');
            YData=get(handle_r,'YData');
            ZData=get(handle_r,'ZData');

            %X,Y,Z Data are in sender-centric coordinates, so rotate them accordingly!
            %Setting rotation matrix: r_antenna = (Mth * Mf) * (r_env - r_o)           
            %Also see ReceiverToEnvCoords.m - here inline for speed
            
            f=fr+pi;
            th=thr;
            
            %rotate around z-axis by +f
            A=[ cos(f)   sin(f)   0; ...
               -sin(f)   cos(f)   0; ...
                    0        0    1];   
            
            %rotate around y-axis by +th    
            B=[ cos(th)    0     sin(th); ...
                      0    1           0; ... 
               -sin(th)    0     cos(th)];
            
            C=(B*A)^(-1);
            
            ro=[ D ;...
                 0 ;...
                 hr];

           %parallelization thwarts performance here...
           for I=1:size(ZData,1)
                for J=1:size(ZData,2)
                    xx=XData(I,J);
                    yy=YData(I,J);
                    zz=ZData(I,J);
                    v=[xx; yy; zz];
                    vn=(C*v)+ro;
                    XData(I,J)=vn(1);
                    YData(I,J)=vn(2);
                    ZData(I,J)=vn(3);                    
                end
            end            
            set(handle_r,'XData',XData);
            set(handle_r,'YData',YData);
            set(handle_r,'ZData',ZData);
           

end

%Make sure the Z limits are ok and the plot discernible
ZLimits=get(af,'ZLim');
if (ZLimits(2))<D*0.08
    ZLimits(2)=(D+20)*0.3;
    set(af,'ZLim',ZLimits);
end

if noFig==0
    xlabel(af,'distance');
    ylabel(af,'field depth');
    zlabel(af,'height');
    title(af,'Visualization of SENDER\color{blue}(----) \color{black}and RECEIVER\color{red}(----) \color{black}scenario.');
end

end


function r=isInBoundingBox(x,y,z,D,H,ths,fs,hs)
%check if point (x,y,z) is in bounding box defined by D,H, ths,fs,hs

    r=false;

    A=x/(sin(ths)*cos(fs));
    if (A<0)
        return;
    end

    A=-y/(sin(ths)*sin(fs));
    if (A<0)
        return;
    end
    A=(z-hs)/cos(ths);
    if (A<0)
        return;
    end



    if ~ ((x>=-10)&&(x<=(D+10)))
        return;
    end
    if ~ ((y>=-D*0.5)&&(y<=D*0.5))
        return;
    end
    if ~ ((z>=0)&&(z<=H*1.1))
        return;
    end

    r=true;
end



function r=isInBoundingBoxRecv(x,y,z,D,H,ths,fs,hs)
%check if point (x,y,z) is in bounding box defined by D,H, ths,fs,hs
    r=false;

    A=(x-D)/(sin(ths)*cos(pi+fs));
    if (A<0)
        return;
    end

    A=y/(sin(ths)*sin(pi+fs));
    if (A<0)
        return;
    end
    A=(z-hs)/cos(ths);
    if (A<0)
        return;
    end

    if ~ ((x>=-10)&&(x<=(D+10)))
        return;
    end
    if ~ ((y>=-D*0.5)&&(y<=D*0.5))
        return;
    end
    if ~ ((z>=0)&&(z<=H*1.1))
        return;
    end

    r=true;
end