% set_param('vrWorldVlab2','simulationcommand','continue');

N=handles.Nofpaths;
rms=get(handles.Delayenvpop,'String');
i=get(handles.Delayenvpop,'Value');
switch rms{i}  %mod gains by X20 8/7/2010
    case 'Indoor cells'
        a=0.01;
        b=0.05;
    case 'Urban macrocell'
        a=1;
        b=3;
    case 'Suburban macrocell'
        a=0;
        b=1;
    case 'Open area'
        a=0;
        b=0.2;
    case 'Hilly area macrocell'
        a=3;
        b=10;
    case 'Mobile satellite'
        a=0.04;
        b=0.05;   
end


Ptx_dBW=10*log10(handles.environment.Sender.Signal.P);
Rx_powAvg_dBW=Ptx_dBW-10*log10(globalPgain)+10*log10(globalRgain)+10*log10(globalTgain)+ShadowvaryDB;
Rx_powAvg_W=10.^(0.1*Rx_powAvg_dBW);


FreqCarrier=handles.environment.Sender.Signal.F;
PeriodCarrier=2*pi*FreqCarrier;
sampleCarrier=PeriodCarrier*0.01;
t=0:sampleCarrier:PeriodCarrier;

totSigAmpl=zeros(1,length(t));

ImResp=[];

GGains={};
GDelays={};

for i=1:200
      x=(i-1)*Dx;
      t=x/handles.carspeed;
      [Tgain Sgain Pgain Rgain SNRdB K Fd avPathG pathDelays carpos]=timevary(u);
      %only the gains, K, Fd and the carpos are valid.
      %setcarpos(carpos);
      
      Dist=handles.environment.Receiver.TotDist(i);
      
      Delays_each= sort((Dist/1e+8)*(a+(b-a).*rand(1,N)));
      GDelays{i}=Delays_each;
      
      LOSpow_W=Rx_powAvg_W;
      NLOSpow_W_tot=Rx_powAvg_W / K;
      
      powNLOS_each=rand(1,N-1);
      powNLOS_each=NLOSpow_W_tot./sum(powNLOS_each);
      
      Amplitudes=[sqrt(LOSpow_W) sqrt(powNLOS_each) ];
      
      GGains{i}=20*log10(Amplitudes);
              
      for k=1:N
          totSigAmpl=totSigAmpl+Amplitudes(k)*sin(2*pi*(FreqCarrier-Fd)*(t-Delays_each(k)));
      end
          
      ImResp=[ImResp totSigAmpl];
end


HH=findobj(findobj('Tag','MainFigureOfVlabs2'),'Type','uicontrol');
for i=1:length(HH)
  set(HH(i),'enable','on');
  if strcmp(get(HH(i),'Tag'),'Pausebtn' )
      set(HH(i),'enable','off');
  end
  if strcmp(get(HH(i),'Tag'),'Stopbtn' )
      set(HH(i),'enable','off');
  end
end




  set(findobj('Tag','ShowViewerBtnMenu'),'Enable','on');
  set(findobj('Tag','DemoPlayMenuBtn'),'Enable','on');  

showGains=get(findobj('Tag','Fdcheck'),'Value'); %show gains..
if showGains
    global globalTgain;
    global globalPgain;
    global globalRgain;
    global ShadowvaryDB;

    figure;
    subplot(3,2,1);
    plot(0:180/199:180,10*log10(globalTgain));
    xlabel('distance - (m)');
    ylabel('dB');
    title('Transmitter Antenna Gain');

    subplot(3,2,2);
    plot(0:180/199:180,-10*log10(globalPgain));
    xlabel('distance - (m)');
    ylabel('dB');
    title('Path Loss');

    subplot(3,2,3);
    plot(0:180/199:180,10*log10(globalRgain));
    xlabel('distance - (m)');
    ylabel('dB');
    title('Receiver Antenna Gain');

    subplot(3,2,4);
    plot(0:180/199:180,ShadowvaryDB);
    xlabel('distance - (m)');
    ylabel('dB');
    title('Shadowing Losses');

    subplot(3,2,5:6);
    plot(0:180/199:180,-10*log10(globalPgain)+10*log10(globalRgain)+10*log10(globalTgain)+ShadowvaryDB);
    xlabel('distance - (m)');
    ylabel('dB');
    title('Aggregate Gains');

end

showTIR=get(findobj('Tag','TIRcheck'),'Value'); %show TIR..
showPDP=get(findobj('Tag','PDPcheck'),'Value'); %show PDP..


ImResp=rand(1,100);

if showTIR
    n=length(ImResp);
    x3=0:180/(n-1):180;
    y3=10*log10(ImResp);
else
    x3=1;
    y3=1;
end

if showPDP
    x2=GDelays;
    y2=GGains;
else
    x2=1;
    y2=1;
end


x1=1;
y1=1;

global globalT;

BER(1:100)=1;
SER(1:100)=1;


report([1 0 showPDP showTIR], ...
           {'minimum BER' 'minimum SER' 'Average Fade Duration' 'Level Crossing Frequency'}, ...
           {BER(1) SER(1) 3 4}, ...
           {x1 abs(y1)},...
           {x2 y2},...
           {x3 y3 globalT}  );

