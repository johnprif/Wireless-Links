## -*- texinfo -*-
## @deftypefn  {} {@var{wnd} =} FIRST_GUI ()
##
## Create and show the dialog, return a struct as representation of dialog.
##
## @end deftypefn
function wnd = FIRST_GUI()
  FIRST_GUI_def;
  
  wnd = show_FIRST_GUI();
  
  %ricepdf;
end
