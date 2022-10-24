classdef (ConstructOnLoad=true) TDlDipoleAntenna < TAntenna
    % Infinitesimal (Hertzian) Dipole
    
    properties % TDlDipoleSpecific Properties
        Dl=0.01;    % Elementary Dipole Legth in meters
        Rin=0;      % Circuit resistance (before the antenna)        
    end
    properties (Constant)
        GUIName='Hertzian Dipole'; %EVERY ANTENNA SHOULD DEFINE a GUINAME (see TAntenna)        
    end
    
    methods        
        function obj=TDlDipoleAntenna   %CONSTRUCTOR MUST NOT TAKE ARGUMENTS!      
        end
        
        function Bool=isPointInFarField(obj, r, Environment)
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            
            %For elem. dipole, r > (2*l^2)/lamda
            if r>(2*(obj.Dl^2)/lamda)
                Bool=true;
            else
                Bool=false;
            end
        end

        function [Er Ef Eth Hr Hf Hth]=fieldAt(obj, r, ~, th, Environment)
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Z=Medium.c*Medium.m;
            Io=Signal.Io(obj.Rin+AntennaResistance(obj, lamda, Environment));
            
            %Calculate E,H at the Antenna-centric coordinate system (see documentation)
            Er=(1/(2*pi))*Z*Io*(obj.Dl)*cos(th)*exp(-2*pi*r/lamda)*((1/(r^2))-1i*lamda/(2*pi*(r^3)));
            Ef=0;
            Eth=1i*(1/(2*lamda))*Z*Io*(obj.Dl)*sin(th)*exp(-2*pi*r/lamda)*((1/r)-1i*lamda/(2*pi*(r^2))-(lamda^2)/(4*pi*pi*r*r*r));
            Hr=0;
            Hf=1i*(1/(2*lamda))*Io*(obj.Dl)*sin(th)*exp(-2*pi*r/lamda)*((1/r)-1i*lamda/(2*pi*(r^2)));
            Hth=0;            
        end   
        
        function G=Gain(obj, r, f, th, Environment)
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Z=Medium.c*Medium.m;
            k=2*pi/lamda;
            Ra=AntennaResistance(obj, lamda, Environment);
            Io=Signal.Io(obj.Rin+Ra);
            
            %Using G=4 pi U/Pin, U is the radiation intensity
            U=0.5*Z*(sin(th)^2)*((k*Io*obj.Dl/(4*pi))^2);
            Pin=0.5*(Ra)*((Io)^2);
            G=(4*pi)*(U)/Pin;   
        end
        
        function D=Directivity(obj, r, f, th, Environment)
            D=1.5*(sin(th)^2);
        end
        
        function Ra=AntennaResistance(obj, wavelength, Environment)
            Ra=80*(pi*obj.Dl/wavelength)^2;
        end
        
        function Pp=PowerAtPoint(obj, r, f, th, Environment)
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Ra=AntennaResistance(obj, lamda, Environment);
            Io=Signal.Io(obj.Rin+Ra);
            Pin=0.5*Ra*((Io)^2);

            %Using Pp=Pin*G/L, L is the space loss (see TMedium)
            G=Gain(obj, r, f, th, Environment); 
            L=Medium.Loss([r f th], Environment);
            
            Pp=Pin*G/L;
            
        end
        
        function Pm=PowerAtMesh(obj, r, F, TH, Environment)
            %This one is optimized for speed: all functions are inline.
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            Pm=zeros(size(F));
            [I,J]=size(F);
            N=size(F,2);
            
            lamda=Medium.c/Signal.F;
            Z=Medium.c*Medium.m;
            Io=Signal.Io(obj.Rin+AntennaResistance(obj, lamda, Environment));
            k=2*pi/lamda;
            Ra=AntennaResistance(obj, lamda, Environment);
            Pin=0.5*Ra*((Io)^2);
            DL=obj.Dl;
            
            constant=0.5*Z*((k*Io*DL/(4*pi))^2);
            
            for i=1:I
                myTemp=zeros(1,N);
                myTH=TH(i,:);
                myF=F(i,:);
                for j=1:J
                    th=myTH(j);
                    f=myF(j);
                    U=(sin(th)^2)*constant;
                    G=(4*pi)*(U)/Pin;
                    L=Medium.Loss([r f th], Environment);
                    myTemp(j)= Pin*G/L;   
                end
                Pm(i,:)=myTemp;
            end
        end      
        
        function Wr=RadialPowerDensity(obj, r, f, th, Environment)
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Ra=AntennaResistance(obj, lamda, Environment);
            Io=Signal.Io(obj.Rin+Ra);
            Z=Medium.c*Medium.m;
            L=Medium.Loss([r f th], Environment);
            %Wr=...
            Wr=(Z*0.25)*((Io*obj.Dl*sin(th)/r)^2)/lamda;
            Wr=Wr/L;
        end

    end
    
end

