function handles=initGUI2(hObject, handles)
%   Initializes the GUI with the default values;

%Check if VLABS is properly installed. The registry key is ABSOLUTELY
%NEEDED!!
    try
       handles.installPath=winqueryreg('HKEY_LOCAL_MACHINE', 'SOFTWARE\IHUvlab2', 'installPath');
    catch MException 
       disp('IHU-Vlab#1 is not properly installed! Repeat the setup process..');
       close(handles.mainFig);
       return;
    end
    cd(handles.installPath);
    set(0,'ShowHiddenHandles','on');
    
% Customize the simulink environment    
copyfile('ORIGINALS/sl_customization.m','sl_customization.m');
sl_refresh_customizations;    

%Warm-up Java interpreter and add needed paths
    jarpath=strcat(handles.installPath,'\java\JPropertySheet.jar');
    jarfound = exist(jarpath, 'file');
    if ~jarfound
        javaaddpath(jarpath);
    end
    javastartup;
%Set the block diagram
       x=imread(strcat(handles.installPath,'\blocks.png'));
       image(x,'Parent',handles.axes1);
       set(handles.axes1,'XTick',[]);
       set(handles.axes1,'YTick',[]);

% Buttons..
  set(handles.Startbtn,'Enable','on');
  set(handles.Stopbtn,'Enable','off');
  set(handles.Pausebtn,'Enable','off');

% CheckBoxes..
set(handles.Fdcheck,'Value',1);
%set(handles.Transfercheck,'Value',1);
set(handles.TIRcheck,'Value',1);
set(handles.PDPcheck,'Value',1);
set(handles.RTCcheck,'Value',1);

  
% update sliders' min-max and starting positions.
set(handles.Hslider,'Min',-15);
set(handles.Hslider,'Max',100);
set(handles.Hslider,'Value',0);

set(handles.Elslider,'Min',-60);
set(handles.Elslider,'Max',60);
set(handles.Elslider,'Value',0);

set(handles.Azslider,'Min',-180);
set(handles.Azslider,'Max',180);
set(handles.Azslider,'Value',0);

set(handles.Horslider,'Min',-100);
set(handles.Horslider,'Max',100);
set(handles.Horslider,'Value',0);

set(handles.Distslider,'Min',-100);
set(handles.Distslider,'Max',35);
set(handles.Distslider,'Value',0);

set(handles.Losslider,'Min',0);
set(handles.Losslider,'Max',10);
set(handles.Losslider,'Value',8);

set(handles.Wideslider,'Min',0);
set(handles.Wideslider,'Max',50);
set(handles.Wideslider,'Value',0);

set(handles.Powerslider,'Min',1);
set(handles.Powerslider,'Max',100);
set(handles.Powerslider,'Value',1);

set(handles.Freqslider,'Min',1);
set(handles.Freqslider,'Max',100);
set(handles.Freqslider,'Value',1);

set(handles.Speedslider,'Min',1);
set(handles.Speedslider,'Max',200);
set(handles.Speedslider,'Value',80);

set(handles.Riceslider,'Min',1);
set(handles.Riceslider,'Max',50);
set(handles.Riceslider,'Value',5);

set(handles.Nofpathsslider,'Min',0);
set(handles.Nofpathsslider,'Max',20);
set(handles.Nofpathsslider,'Value',1);

set(handles.SNRslider,'Min',-100);
set(handles.SNRslider,'Max',100);
set(handles.SNRslider,'Value',0);

% Set contents of unit selection lists
set(handles.Frequnitspop,'String',{'MHz'});
set(handles.Frequnitspop,'Value',1);
set(handles.Powerunitspop,'String',{'W';'dbW';'mW';'dbmW'});
set(handles.Speedunitspop,'String',{'Km/h';'m/s'});
set(handles.Delayenvpop,'String',{'Indoor cells';'Urban macrocell';'Suburban macrocell';'Open area';'Hilly area macrocell';'Mobile satellite'});

%Update Antenna, Medium and Measurement drop-down lists   
       handles.antennaLookupTable=java.util.Hashtable;
       antennaDir=strcat(handles.installPath,'\customClasses\Antennas');
       antennaFiles=dir(antennaDir);
       k=1;
       for i=1:length(antennaFiles)
           if ~antennaFiles(i).isdir
               [~, name, ~, ~]=fileparts(antennaFiles(i).name);
               AntennaStrings{k}=eval(sprintf('%s.GUIName',name));
               handles.antennaLookupTable.put(AntennaStrings{k},name);
               k=k+1;
           end
       end
       set(handles.Receiverantennapop,'String',unique(AntennaStrings));
       set(handles.Receiverantennapop,'Value',1);
       set(handles.Senderantennatypepop,'String',unique(AntennaStrings));
       set(handles.Senderantennatypepop,'Value',1);
       
       handles.mediumLookupTable=java.util.Hashtable;       
       MediumDir=strcat(handles.installPath,'\customClasses\Mediums');
       mediumFiles=dir(MediumDir);
       k=1;
       for i=1:length(mediumFiles)
           if ~mediumFiles(i).isdir
               [~, name, ~, ~]=fileparts(mediumFiles(i).name);
               MediumStrings{k}=eval(sprintf('%s.GUIName',name));
               handles.mediumLookupTable.put(MediumStrings{k},name);
               k=k+1;
           end
       end
       set(handles.Mediumtypepop,'String',unique(MediumStrings));
       set(handles.Mediumtypepop,'Value',1);

%Create an initial environment   
             
           i=get(handles.Mediumtypepop,'Value');
           Vals=get(handles.Mediumtypepop,'String');
           eval(sprintf('handles.environment.Medium=%s;',handles.mediumLookupTable.get(Vals{i})));       

           handles.environment.Sender=TNode;
                 handles.environment.Sender.Signal=TSignal;

                 i=get(handles.Senderantennatypepop,'Value');
                 Vals=get(handles.Senderantennatypepop,'String');
                 eval(sprintf('handles.environment.Sender.Antenna=%s;',handles.antennaLookupTable.get(Vals{i})));
       
           handles.environment.Receiver=TNode;
                 i=get(handles.Receiverantennapop,'Value');
                 Vals=get(handles.Receiverantennapop,'String');
                 eval(sprintf('handles.environment.Receiver.Antenna=%s;',handles.antennaLookupTable.get(Vals{i})));

%Set static environment values

       handles.environment.Receiver.Height=1.75;
       handles.environment.Receiver.Direction=0;  % Will be set externally whenever needed during simulink simulations
       handles.environment.Receiver.Tilt=0;

       handles.environment.Receiver.HorDistanceFromSender=0; % Will be set externally whenever needed during simulink simulations
       handles.environment.Sender.Direction=0;          % Will be set externally whenever needed during simulink simulations
       
% Update handles structure
       guidata(hObject, handles);
       

end

