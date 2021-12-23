## -*- texinfo -*-
## @deftypefn  {} {@var{wnd} =} FIRST_GUI ()
##
## Create and show the dialog, return a struct as representation of dialog.
##
## @end deftypefn


function wnd = FIRST_GUI()
  pkg load communications;
  pkg load image;
  FIRST_GUI_def;
  #carSimulator;
  
  Dialog_1_def;
  wnd = show_FIRST_GUI();
  #new figure for carSimulator
  realCarSimulator_figure = figure;
  #10 = min distance from road
  realCarSimulator(10, 100);
  #showCarSimulator();
  #ricepdf;
  #jakes;
  
end
