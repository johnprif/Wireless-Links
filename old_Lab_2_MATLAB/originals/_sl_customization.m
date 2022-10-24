function sl_customization( cm )
cm.LibraryBrowserCustomizer.applyFilter({'Aerospace Blockset','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simulink','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Control System Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Fuzzy Logic Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Image Acquisition Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Instrument Control Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Model Predictive Control Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Neural Network Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'RF Blockset','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Real-Time Workshop','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Real-Time Workshop Embedded Coder','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Report Generator','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Robust Control Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Signal Processing Blockset','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'SimEvents','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'SimPowerSystems','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simscape','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simulink 3D Animation','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simulink Control Design','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simulink Design Optimization','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simulink Extras','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Simulink Verification and Validation','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Stateflow','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'System Identification Toolbox','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Video and Image Processing Blockset','Hidden'});

cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Modulation','Enabled'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Channels','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Comm Filters','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Comm Sinks','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Comm Sources','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Equalizers','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Error Detection and Correction','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Interleaving','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/MIMO','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/RF Impairments','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Sequence Operations','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Source Coding','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Synchronization','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Utility Blocks','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Comm Filters','Hidden'});
cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Modulation/Analog Passband Modulation','Hidden'});

cm.LibraryBrowserCustomizer.applyFilter({'Communications Blockset/Modulation/Digital Passband Modulation','Enabled'});

cm.addCustomFilterFcn('Simulink:EditMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:ViewMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:SimulationMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:FormatMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:ToolsMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:NewMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:Open',@myFilter);
cm.addCustomFilterFcn('Simulink:SaveAs',@myFilter);
cm.addCustomFilterFcn('Simulink:ModelProperties',@myFilter);
cm.addCustomFilterFcn('Simulink:SimulinkPreferences',@myFilter);
cm.addCustomFilterFcn('Simulink:ExportToWeb',@myFilter);
cm.addCustomFilterFcn('Simulink:Reports',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextMenu',@myFilter);

cm.addCustomFilterFcn('Simulink:Undo',@myFilter);
cm.addCustomFilterFcn('Simulink:Redo',@myFilter);
cm.addCustomFilterFcn('Simulink:Paste',@myFilter);
cm.addCustomFilterFcn('Simulink:PasteDuplicate',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextSelectAll',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextHiliteOptionsMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:MostFreqBlocksMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:Back',@myFilter);
cm.addCustomFilterFcn('Simulink:Forward',@myFilter);
cm.addCustomFilterFcn('Simulink:GotoParent',@myFilter);
cm.addCustomFilterFcn('Simulink:LibraryLinkMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:ConfigurationParameters',@myFilter);
cm.addCustomFilterFcn('Simulink:FixedPointInterface',@myFilter);
cm.addCustomFilterFcn('Simulink:WatchSignalsDialog',@myFilter);
cm.addCustomFilterFcn('Simulink:ScreenColorMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:LibraryLinkDisplayMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:SampleTimeDisplayMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextBlockDiagramFormatMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:SysRequirementsMenu',@myFilter);

cm.addCustomFilterFcn('Simulink:BlockPortsMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:LookUnderMask',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextCreateMask',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextFPTMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextRTWMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:BlockRequirementsMenu',@myFilter);
cm.addCustomFilterFcn('Simulink:ModelAdvisorSubsys',@myFilter);
cm.addCustomFilterFcn('Simulink:BlockProperties',@myFilter);
cm.addCustomFilterFcn('Simulink:BlockParameters',@myFilter);
cm.addCustomFilterFcn('Simulink:MaskParameters',@myFilter);
cm.addCustomFilterFcn('Simulink:BlockLinearizeOptions',@myFilter);
cm.addCustomFilterFcn('Simulink:BlockExplore',@myFilter);
cm.addCustomFilterFcn('Simulink:SSToMdlRef',@myFilter);
cm.addCustomFilterFcn('Simulink:ContextUpdateDiagram',@myFilter);


end

function state = myFilter(callbackInfo)
  state = 'Hidden';
end
