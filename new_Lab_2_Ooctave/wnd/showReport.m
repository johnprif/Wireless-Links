graphics_toolkit qt;

%Close all figures when close button(X) of main window is pressed
function myCloseReq(src,event)
  close all;
end

%Function that creates the report figure after simulation end
function ret = showFinalReport()
  _scrSize = get(0, "screensize");
  _xPos = (_scrSize(3) - 1173)/2;
  _yPos = (_scrSize(4) - 711)/2;
   Dialog_1 = figure ( ... 
	'Color', [0.941 0.941 0.941], ...
	'Position', [_xPos _yPos 1173 711], ...
	'resize', 'off', ...
	'windowstyle', 'modal', ...
	'MenuBar', 'none', ...
  'NumberTitle', 'off', ...
  'name', 'report', ...
  "DeleteFcn", {@myCloseReq});
	 set(Dialog_1, 'visible', 'off');
  Received_Field = uipanel( ...
	'parent',Dialog_1, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'bold', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [10 408 1150 300], ... 
	'title', 'Received Field', ... 
	'TitlePosition', 'lefttop');
  Image_1 = axes( ...
	'Units', 'pixels', ... 
	'parent',Received_Field, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'Position', [24 65 701 212]);
  Image_2 = axes( ...
	'Units', 'pixels', ... 
	'parent',Received_Field, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'Position', [751 64 388 212]);
  Window_Slider = uicontrol( ...
	'parent',Received_Field, ... 
	'Style','slider', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Max', 99, ... 
	'Min', 0, ... 
	'Position', [22 8 705 22], ... 
	'TooltipString', '', ... 
	'Value', 0);
  Sensitivity_Slider = uicontrol( ...
	'parent',Received_Field, ... 
	'Style','slider', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Max', 99, ... 
	'Min', 0, ... 
	'Position', [751 8 388 22], ... 
	'TooltipString', '', ... 
	'Value', 0);
  Window_Slider_Label = uicontrol( ...
	'parent',Received_Field, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [20 29 114 16], ... 
	'String', 'Window Slider', ... 
	'TooltipString', '');
  Sensitivity_Slider_Label = uicontrol( ...
	'parent',Received_Field, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [750 29 96 16], ... 
	'String', 'Sensitivity Slider', ... 
	'TooltipString', '');
  Power_delay_profile = uipanel( ...
	'parent',Dialog_1, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'bold', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [10 133 1149 272], ... 
	'title', 'Profile Delay Profile', ... 
	'TitlePosition', 'lefttop');
  Image_3 = axes( ...
	'Units', 'pixels', ... 
	'parent',Power_delay_profile, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'Position', [21 18 1107 230]);
  Data = uipanel( ...
	'parent',Dialog_1, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'bold', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [10 18 1147 108], ... 
	'title', 'Data', ... 
	'TitlePosition', 'lefttop');
  Data_table = uipanel( ...
	'parent',Data, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [325 12 535 81], ... 
	'title', '', ... 
	'TitlePosition', 'lefttop');
  minimum_Ber = uicontrol( ...
	'parent',Data_table, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [10 50 84 16], ... 
	'String', 'minimum BER', ... 
	'TooltipString', '');
  minimumBERview = uicontrol( ...
	'parent',Data_table, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [10 19 85 22], ... 
	'String', '0', ... 
	'TooltipString', '');
  minimum_SER = uicontrol( ...
	'parent',Data_table, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [110 50 84 16], ... 
	'String', 'minimum SER', ... 
	'TooltipString', '');
  minimumSERview = uicontrol( ...
	'parent',Data_table, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [106 19 94 22], ... 
	'String', '0', ... 
	'TooltipString', '');
  AvgFadeDur = uicontrol( ...
	'parent',Data_table, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [210 50 106 16], ... 
	'String', 'Avg Fade Duration', ... 
	'TooltipString', '');
  VvgFadeDurationView = uicontrol( ...
	'parent',Data_table, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [209 19 111 22], ... 
	'String', '0', ... 
	'TooltipString', '');
  Level_Crossing_frequency = uicontrol( ...
	'parent',Data_table, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'center', ... 
	'Position', [350 50 149 16], ... 
	'String', 'Level Crossing Frequency', ... 
	'TooltipString', '');
  LevelCrossingFrequencyView = uicontrol( ...
	'parent',Data_table, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [329 19 196 22], ... 
	'String', '0', ... 
	'TooltipString', '');

  Dialog_1 = struct( ...
      'figure', Dialog_1, ...
      'Received_Field', Received_Field, ...
      'Image_1', Image_1, ...
      'Image_2', Image_2, ...
      'Window_Slider', Window_Slider, ...
      'Sensitivity_Slider', Sensitivity_Slider, ...
      'Window_Slider_Label', Window_Slider_Label, ...
      'Sensitivity_Slider_Label', Sensitivity_Slider_Label, ...
      'Power_delay_profile', Power_delay_profile, ...
      'Image_3', Image_3, ...
      'Data', Data, ...
      'Data_table', Data_table, ...
      'minimum_Ber', minimum_Ber, ...
      'minimumBERview', minimumBERview, ...
      'minimum_SER', minimum_SER, ...
      'minimumSERview', minimumSERview, ...
      'AvgFadeDur', AvgFadeDur, ...
      'VvgFadeDurationView', VvgFadeDurationView, ...
      'Level_Crossing_frequency', Level_Crossing_frequency, ...
      'LevelCrossingFrequencyView', LevelCrossingFrequencyView);


  dlg = struct(Dialog_1);

%
% The source code writed here will be executed when
% windows load. Work like 'onLoad' event of other languages.
%

  set(Dialog_1.figure, 'visible', 'on');
  ret = Dialog_1;
end

