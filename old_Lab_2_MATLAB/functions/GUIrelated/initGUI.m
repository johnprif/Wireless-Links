function initGUI(hObject, handles)
    %Check if VLABS is properly installed. The registry key is ABSOLUTELY
    %NEEDED!!
    try
       handles.installPath=winqueryreg('HKEY_LOCAL_MACHINE', 'SOFTWARE\IHUvlab1', 'installPath');
    catch MException 
       disp('IHU-Vlab#1 is not properly installed! Repeat the setup process..');
       close(handles.mainFig);
       return;
    end
    cd(handles.installPath);
    %Warm-up Java interpreter and add needed paths
    jarpath=strcat(handles.installPath,'\java\JPropertySheet.jar');
    jarfound = exist(jarpath, 'file');
    if ~jarfound
        javaaddpath(jarpath);
    end
    javastartup;
    %Enable multithreading
    if matlabpool('size') == 0 % checking to see if my pool is already open
       matlabpool open;
    end
    %Show a toolbar with plot manipulation buttons on the main form
       handles.output = hObject;
       set(0,'Showhidden','on');
       set(gcf,'Toolbar','figure');
       tbh = findall(gcf,'Type','uitoolbar');
       X=get(tbh,'Children');
       %Delete buttons that may mess up user experience
       delete(X([1 2 5  9 10 11 13 14 15 16]));
    %Set the main Form's background:
       x=imread(strcat(handles.installPath,'\img\vlabs1Bckgrnd.png'));
       image(x,'Parent',handles.backGrndAxes);
       set(handles.backGrndAxes,'XTick',[]);
       set(handles.backGrndAxes,'YTick',[]);    
    %Set the GUI's default values
       set(handles.fUnitsMenu,'String',{'KHz';'MHz';'GHz'});
       set(handles.fUnitsMenu,'Value',2);
       set(handles.fEdit,'String','10'); %default F=10Mhz
       set(handles.PUnitsMenu,'String',{'W';'dbW'});
       set(handles.PUnitsMenu,'Value',1);      
       set(handles.PEdit,'String','100'); %default P=100Watt      
       set(handles.hsEdit,'String','10'); %default hs=10m
       set(handles.fsEdit,'String','0');  %default fs=0 deg
       set(handles.thsEdit,'String','0');  %default ths=0 deg      
       set(handles.hrEdit,'String','0.5'); %default hr=0.5m
       set(handles.frEdit,'String','0');  %default fr=0 deg
       set(handles.thrEdit,'String','0');  %default thr=0 deg       
       set(handles.LEdit,'String','50');  %default L=50 m
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
       set(handles.recvType,'String',unique(AntennaStrings));
       set(handles.recvType,'Value',1);
       set(handles.senderType,'String',unique(AntennaStrings));
       set(handles.senderType,'Value',1);
       
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
       set(handles.mediumType,'String',unique(MediumStrings));
       set(handles.mediumType,'Value',1);

       handles.measurementLookupTable=java.util.Hashtable;
       measurementsDir=strcat(handles.installPath,'\customClasses\Measurements');
       measurementFiles=dir(measurementsDir);
       k=1;
       for i=1:length(measurementFiles)
           if ~measurementFiles(i).isdir
               [~, name, ~, ~]=fileparts(measurementFiles(i).name);
               measurementStrings{k}=eval(sprintf('%s.GUIName',name));
               handles.measurementLookupTable.put(measurementStrings{k},name);
               k=k+1;
           end
       end
       set(handles.measTypeList,'String',unique(measurementStrings));
       set(handles.measTypeList,'Value',1);
       
    %Create an initial environment   
       
       %Create the proper object hierrarchy. Indent shows children
       handles.patchHandle=-1; %Not needed initially. Used only in some measurement visualisations.
                               %Init value must be -1 here. See
                               %showPlanePatch.m
       
       i=get(handles.measTypeList,'Value');
       Vals=get(handles.measTypeList,'String');
       eval(sprintf('handles.measurement=%s;',handles.measurementLookupTable.get(Vals{i})));       
       handles.environment=TEnvironment;

           i=get(handles.mediumType,'Value');
           Vals=get(handles.mediumType,'String');
           eval(sprintf('handles.environment.Medium=%s;',handles.mediumLookupTable.get(Vals{i})));       

           handles.environment.Sender=TNode;
                 handles.environment.Sender.Signal=TSignal;

                 i=get(handles.senderType,'Value');
                 Vals=get(handles.senderType,'String');
                 eval(sprintf('handles.environment.Sender.Antenna=%s;',handles.antennaLookupTable.get(Vals{i})));
       
           handles.environment.Receiver=TNode;
                 i=get(handles.recvType,'Value');
                 Vals=get(handles.recvType,'String');
                 eval(sprintf('handles.environment.Receiver.Antenna=%s;',handles.antennaLookupTable.get(Vals{i})));
       
       %Init the environment objects. 
       i=get(handles.fUnitsMenu,'Value');
       Vals=get(handles.fUnitsMenu,'String');
       handles.environment.Sender.Signal.F=applyUnitScale(str2double(get(handles.fEdit,'String')), Vals{i});

       i=get(handles.PUnitsMenu,'Value');
       Vals=get(handles.PUnitsMenu,'String');
       handles.environment.Sender.Signal.P=applyUnitScale(str2double(get(handles.PEdit,'String')), Vals{i});
       
       handles.environment.Sender.Height=applyUnitScale(str2double(get(handles.hsEdit,'String')), 'meters');
       handles.environment.Sender.Direction=applyUnitScale(str2double(get(handles.fsEdit,'String')), 'deg');
       handles.environment.Sender.Tilt=applyUnitScale(str2double(get(handles.thsEdit,'String')), 'deg');

       handles.environment.Receiver.Height=applyUnitScale(str2double(get(handles.hrEdit,'String')), 'meters');
       handles.environment.Receiver.Direction=applyUnitScale(str2double(get(handles.frEdit,'String')), 'deg');
       handles.environment.Receiver.Tilt=applyUnitScale(str2double(get(handles.thrEdit,'String')), 'deg');
       handles.environment.Receiver.HorDistanceFromSender=applyUnitScale(str2double(get(handles.LEdit,'String')), 'meters');
                             
       % Update handles structure
       guidata(hObject, handles);

       %Init the Sender's Receivers Radiation Power Plots (2-D and 3-D, bottom of the main Form) 
       paintAntennaPowerPat(handles.axes11, handles.axes10, ...
                            handles.environment.Sender.Antenna, handles.environment);
                        
       %paintAntennaPowerPat(handles.axes9, handles.axes5, handles.recvAntenna, handles.medium, handles.signal);
       paintAntennaPowerPat(handles.axes9, handles.axes5, ...
                            handles.environment.Receiver.Antenna, handles.environment);
      % Update handles structure
       guidata(hObject, handles);

end