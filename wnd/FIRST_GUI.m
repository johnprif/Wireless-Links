function wnd = FIRST_GUI()
  pkg load communications;
  pkg load image;
  FIRST_GUI_def;
  showReport;
  
  wnd = show_FIRST_GUI();
  #new figure for carSimulator
  realCarSimulator_figure = figure;
  #10 = min distance from road
  realCarSimulator(10, 100, 0); 
end
