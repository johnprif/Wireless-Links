classdef THataUrbanMedium < TMedium

   properties (Constant)
        GUIName='Okumura-Hata Urban Area'; %EVERY MEDIUM SHOULD DEFINE a GUINAME   
   end
    
   methods
        function obj=THataUrbanMedium %CONSTRUCTOR MUST NOT TAKE ARGUMENTS!
        end
        
        function L=Loss(obj, point, Environment)
            r=point(1);
            th=point(3);
                      
            hb=Environment.Sender.Height;
            hm=hb-r*cos(th);

            R=r*sin(th);   %horizontal distance
            
            fc=Environment.Sender.Signal.F;

            %in hata, fc in MHz, R in Km.
            fc=fc*(1e-6);
            R=R*(1e-3);
            
            A=69.55+26.16*log10(fc)-13.82*log10(hb);
            B=44.9-6.55*log10(hb);
            C=2*((log10(fc/28))^2)+5.4;
            D=4.78*((log10(fc))^2)-18.33*log10(fc)+40.94;
            
            E=0;
            if fc>=300
                E=3.2*((log10(hm*11.75))^2)-4.97;
            else
                E=3.2*((log10(hm*1.54))^2)-1.1;
            end

            L=A+B*log10(R)-E;
            
            L=10^(L*0.1);
        end
   end
    
end

