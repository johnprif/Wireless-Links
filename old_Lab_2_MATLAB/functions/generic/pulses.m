function P=pulses(NofPoints,NofPulses,NLOS)
% creates a signal of N smoothed pulses, emulating the shadowing imposed by the buildings.

f=0.05; %smoothing factor; 23/11/2010 decreased from 1 to 0.05

if NLOS==1
    P=ones(1,NofPoints);
    return;
end

P=zeros(1,NofPoints);
if NLOS==0
    return;
end

%PulseCenterSpacing=round(NofPoints/ofPulses);
%PulseWidth=NLOS*PulseCenterSpacing;
%currentCenter=round(PulseCenterSpacing/2);

PulseCenterSpacing=round(NofPoints*(2.5/8.4));
PulseWidth=(NLOS/0.8)*(NofPoints*2/8.4);
currentCenter=round((0.1/8.4)*NofPoints);
for i=1:NofPulses
    lowbound=ceil(currentCenter-PulseWidth*0.5);
    if lowbound<1
        lowbound=1;
    end
    highbound=floor(currentCenter+PulseWidth*0.5);
    if highbound>NofPoints
        highbound=NofPoints;
    end    
    P(lowbound:highbound)=1;    
    currentCenter=currentCenter+PulseCenterSpacing;
end


P=smooth(P,round(NofPoints*f),'lowess');
P(P<0)=0;
P(P>1)=1;
P=P';
end