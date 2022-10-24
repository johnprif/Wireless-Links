classdef (ConstructOnLoad=true) TShortDipoleAntenna < TAntenna
    % Short Dipole Antenna.
    % This implementation demonstrates generic code usage, as opposed to
    % TDlDipoleAntenna, where the code is inline and antenna specific in order to improve speed.
    % isPointInFarField, FieldAt and AntennaResistance are the only antenna-specific functions used.
    
    % Even AntennaResistance can be replaced by generic calculations on
    % fieldAt results, but the overhead would be tremendous for MATLAB.
    
    properties % Specific Properties
        length=0.01;    % Dipole Legth in meters
        Rin=0;      % Circuit resistance (before the antenna)        
    end
    properties (Constant)
        GUIName='Short Dipole'; %EVERY ANTENNA SHOULD DEFINE a GUINAME (see TAntenna)        
    end
    
    methods        
        function obj=TShortDipoleAntenna   %CONSTRUCTOR MUST NOT TAKE ARGUMENTS!      
        end
        
        function Bool=isPointInFarField(obj, r, Environment)
            %Calculate prerequisites
            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            
            %For short. dipole, r > (2*l^2)/lamda
            if r>(2*(obj.length^2)/lamda)
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
            k=2*pi/lamda;
            l=obj.length;
            
            %Calculate E,H at the Antenna-centric coordinate system (see documentation)
            Er=0;
            Eth=1i*Z*k*Io*l*exp(-1i*k*r)*sin(th)/(8*pi*r);
            Ef=0;
            Hr=0;
            Hf=1i*k*Io*l*sin(th)*exp(-1i*k*r)/(8*pi*r);
            Hth=0;            
        end   

        function Ra=AntennaResistance(obj, wavelength, Environment)
            Ra=20*(pi*obj.length/wavelength)^2;
        end
        
        % From here and on, everthing relies on 
        % fieldAt, AntennaResistance functions. 
        % Code is generic for every possible Antenna.
        
        
        function G=Gain(obj, r, f, th, Environment)
            %Calculate prerequisites

            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Ra=AntennaResistance(obj, lamda, Environment);
            Io=Signal.Io(obj.Rin+Ra);
            Pin=0.5*Ra*((Io)^2);
            
            [Er Ef Eth Hr Hf Hth]=fieldAt(obj, r, f, th, Environment);
            E=[Er Eth Ef];
            H=[Hr Hth Hf];
            
            Wav=  sqrt(sum( (0.5*real(cross(E,conj(H)))).^2 ));
            U=Wav*(r^2);
            G=4*pi*U/Pin;
            
        end
        
        function D=Directivity(obj, r, f, th, Environment)
            [Er Ef Eth Hr Hf Hth]=fieldAt(obj, r, f, th, Environment);
            E=[Er Eth Ef];
            H=[Hr Hth Hf];
            
            Wav=  sqrt(sum( (0.5*real(cross(E,conj(H)))).^2 ));
            U=Wav*(r^2);

            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Ra=AntennaResistance(obj, lamda, Environment);
            Io=Signal.Io(obj.Rin+Ra);
            Pin=0.5*Ra*((Io)^2);
            
            D=4*pi*U/Pin;
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
            %optimized for speed: some functions are inline.
            %Calculate prerequisites
            Pm=zeros(size(F));
            [I,J]=size(F);
            N=size(F,2);

            Medium=Environment.Medium;
            Signal=Environment.Sender.Signal;
            lamda=Medium.c/Signal.F;
            Ra=AntennaResistance(obj, lamda, Environment);
            Io=Signal.Io(obj.Rin+Ra);
            Pin=0.5*Ra*((Io)^2);
            
            for i=1:I
                myTemp=zeros(1,N);
                myTH=TH(i,:);
                myF=F(i,:);
                for j=1:J
                    th=myTH(j);
                    f=myF(j);
                    [Er Ef Eth Hr Hf Hth]=fieldAt(obj, r, f, th, Environment);
                    E=[Er Eth Ef];
                    H=[Hr Hth Hf];
                    Wav=  sqrt(sum( (0.5*real(cross(E,conj(H)))).^2 ));
                    U=Wav*(r^2);
                    G=4*pi*U/Pin;
                    L=Medium.Loss([r f th], Environment);
                    myTemp(j)= Pin*G/L;
                end
                Pm(i,:)=myTemp;
            end
        end      
        
        function Wr=RadialPowerDensity(obj, r, f, th, Environment)
            %Calculate prerequisites
            [Er Ef Eth Hr Hf Hth]=fieldAt(obj, r, f, th, Environment);
            E=[Er Eth Ef];
            H=[Hr Hth Hf];
            
            WavVect=0.5*real(cross(E,conj(H)));
            Wr=WavVect(1);
        end

    end
    
end

