function wnd = FIRST_GUI()
  pkg load communications;
  pkg load image;
  FIRST_GUI_def;
  showReport;
  
  wnd = show_FIRST_GUI();
  #new figure for carSimulator
  realCarSimulator_figure = figure;
  #10 = min distance from road 
  #100 = min LOS
  #0 = first car position
  figure(2);
  realCarSimulator(10, 100, 0); 
end
