## -*- texinfo -*-
## @deftypefn  {} {@var{wnd} =} FIRST_GUI ()
##
## Create and show the dialog, return a struct as representation of dialog.
##
## @end deftypefn


function wnd = FIRST_GUI()
  pkg load communications;
  FIRST_GUI_def;
  carSimulator;
  
  wnd = show_FIRST_GUI();
  #showCarSimulator();
  #ricepdf;
  #jakes;
  
end
