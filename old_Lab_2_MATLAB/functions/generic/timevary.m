function [Tgain Sgain Pgain Rgain SNRdB K Fd avPathG pathDelays carpos]=timevary(u)
  % CORE FUNCTION! synchronizes the 3D visualization form with the simulation states.        
  global globalT;
  
  i=1+floor((u/(globalT+1e-6))*200);

  global Kvary;
  global ShadowvaryDB;
  global globalSNRdb;
  global globalGains;
  global globalDelays;
  global globalDoppler;
  global globalTgain;
  global globalRgain;
  global globalPgain;
  
  SNRdB=globalSNRdb;
  
    Pgain=1/globalPgain(i);
    Tgain=globalTgain(i);
    Sgain=10^(0.1*ShadowvaryDB(i));
    Rgain=globalRgain(i);
    K=Kvary(i);
    Fd=globalDoppler(i);   
    
    if K>=1
        avPathG=[0 globalGains*20];    
        pathDelays=[0 globalDelays];
    else
        avPathG=[0 globalGains*20];    
        pathDelays=[0 globalDelays];
    end
    carpos=90-180*(u/globalT);    

end

