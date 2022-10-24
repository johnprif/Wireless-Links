function handles=UpdateVRandStaticTexts( hObject, handles, TSimModelHandlerInstance )
%   reads the slider values and updates the corresponding VR and slider
%   static text. TSimModelHandlerInstance MUST be instantiated and running!
%   handles MUST contained a fully init TEnvironment instance 

x=vrworld('myworld.wrl');

%Hslider
h=handles.Hslider;
block='AntennaHGain';
th=handles.Htext;
description='Height';
units='m';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr);

XFnode=vrnode(x,'ANTENNAXFORM');
xf=getfield(XFnode,'translation');
xf(2)=vr;
setfield(XFnode,'translation',xf);

set(th,'String',sprintf('%s = %3.1f %s',description,Translate(h),units));
handles.environment.Sender.Height=Translate(h);

%Elslider
h=handles.Elslider;
block='AntennaElGain';
th=handles.Eltext;
description='Elevation';
units='deg';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr*pi/180);
XFnode=vrnode(x,'ANTENNAMAINXFORM');
xf2=getfield(XFnode,'rotation');
xf2(1)=0;
xf2(2)=0;
xf2(3)=1;
xf2(4)=vr*pi/180;
setfield(XFnode,'rotation',xf2);


set(th,'String',sprintf('%s = %3.1f %s',description,Translate(h),units));
handles.environment.Sender.Tilt=-Translate(h)*pi/180;

%Azslider
h=handles.Azslider;
block='AntennaAzGain';
th=handles.Aztext;
description='Azimuth';
units='deg';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr*pi/180);
XFnode=vrnode(x,'ANTENNAXFORM');
xf=getfield(XFnode,'rotation');
xf(1)=0;
xf(2)=1;
xf(3)=0;
xf(4)=vr*pi/180;
setfield(XFnode,'rotation',xf);

set(th,'String',sprintf('%s = %3.1f %s',description,Translate(h),units));
handles.AzAntenna=vr*pi/180;

%Horslider
h=handles.Horslider;
block='AntennaZGain';
th=handles.Hortext;
description='Horizon';
units='m';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr);
XFnode=vrnode(x,'ANTENNAXFORM');
xf=getfield(XFnode,'translation');
xf(3)=vr;
setfield(XFnode,'translation',xf);


set(th,'String',sprintf('%s = %3.1f %s',description,Translate(h),units));
handles.Horizon=Translate(h);

%Distslider
h=handles.Distslider;
block='LGain';
th=handles.Disttext;
description='Distance from road';
units='m';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr);
XFnode=vrnode(x,'ANTENNAXFORM');
xf=getfield(XFnode,'translation');
xf(1)=vr;
setfield(XFnode,'translation',xf);

set(th,'String',sprintf('%s = %3.1f %s',description,Translate(h)+Translate(handles.Wideslider)/2,units));
handles.DistFromRoad=Translate(h)+Translate(handles.Wideslider)/2;

%Wideslider
h=handles.Wideslider;
block='wideGain';
th=handles.Widetext;
description='Distance';
units='m';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr);
XFnode=vrnode(x,'ROADXFORM');
xf=getfield(XFnode,'translation');
xf(1)=vr+50;
setfield(XFnode,'translation',xf);

XFnode=vrnode(x,'CARXFORM');
xf=getfield(XFnode,'translation');
xf(1)=vr+50;
setfield(XFnode,'translation',xf);

XFnode=vrnode(x,'BACKBUILDINGSXFORM');
xf=getfield(XFnode,'translation');
xf(1)=2*vr+2.2;
setfield(XFnode,'translation',xf);

set(th,'String',sprintf('%s = %3.1f %s',description,Translate(h),units));
if vr==0
    vr=1e-6;
end
set(handles.Delayenvpop,'Value', ceil(4*(vr)/(get(h,'Max')-get(h,'Min'))));

%Losslider
h=handles.Losslider;
block='losGain';
th=handles.Lostext;
description='LOS';
units='%';

vr=get(h,'Value');
%TSimModelHandlerInstance.setParam(block,'Gain',vr);
XFnode=vrnode(x,'FRONTBUILDING1XF');
xf=getfield(XFnode,'scale');
xf(3)=vr;
setfield(XFnode,'scale',xf);

XFnode=vrnode(x,'FRONTBUILDING2XF');
xf=getfield(XFnode,'scale');
xf(3)=vr;
setfield(XFnode,'scale',xf);

XFnode=vrnode(x,'FRONTBUILDING3XF');
xf=getfield(XFnode,'scale');
xf(3)=vr;
setfield(XFnode,'scale',xf);

XFnode=vrnode(x,'FRONTBUILDING4XF');
xf=getfield(XFnode,'scale');
xf(3)=vr;
setfield(XFnode,'scale',xf);

set(th,'String',sprintf('%s : %3.0f%s',description,100-Translate(h),units));
th=handles.Nlostext;
description='NLOS';
set(th,'String',sprintf('%s : %3.0f%s',description,Translate(h),units));
handles.NLOS=Translate(h)*0.01;

%Powerslider
h=handles.Powerslider;
th=handles.Powertext;
description='Power';
i=get(handles.Powerunitspop,'Value');
Vals=get(handles.Powerunitspop,'String');
units=Vals{i};

set(th,'String',sprintf('%s = %3.0f%s',description,Translate(h),units));
handles.environment.Sender.Signal.P=applyUnitScale2(Translate(h),units);

%Freqslider
h=handles.Freqslider;
th=handles.Freqtext;
description='Frequency';
i=get(handles.Frequnitspop,'Value');
Vals=get(handles.Frequnitspop,'String');
units=Vals{i};

set(th,'String',sprintf('%s = %3.0f%s',description,Translate(h),units));
handles.environment.Sender.Signal.F=applyUnitScale2(Translate(h),units);

%Speedslider
h=handles.Speedslider;
th=handles.Speedtext;
description='Speed';
i=get(handles.Speedunitspop,'Value');
Vals=get(handles.Speedunitspop,'String');
units=Vals{i};

set(th,'String',sprintf('%s = %3.0f%s',description,Translate(h),units));
handles.carspeed=applyUnitScale2(Translate(h),units);

%Riceslider
h=handles.Riceslider;
th=handles.Ricetext;
description='LOS Rice factor';
units='';

set(th,'String',sprintf('%s = %2d%s',description,round(Translate(h)),units));
handles.rice=round(Translate(h));

%Nofpathsslider
h=handles.Nofpathsslider;
th=handles.Nofpathstext;
description='Secondary paths';
units='';

set(th,'String',sprintf('%s = %2d%s',description,round(Translate(h)),units));
handles.Nofpaths=round(Translate(h));

%SNRslider
h=handles.SNRslider;
th=handles.SNRtext;
description='Eb/No';
units='db';

set(th,'String',sprintf('%s = %3.1f%s',description,Translate(h),units));
handles.SNR=Translate(h);

% Update handles structure
guidata(hObject, handles);

end

