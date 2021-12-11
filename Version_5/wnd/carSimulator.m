function car = carSimulator()
  car = figure('visible', 'off');
  set(car, "Name", "Car Simulation", "windowstyle", "normal", "NumberTitle","off", 'MenuBar', 'figure', 'toolbar', 'figure', 'resize', 'on');
  title("Created by Priftis Brothers with love 2021©");
 
 # y1=x1+4;
 # y2=y1+1;
 # y3=y2+1
 
  #myList=[1:100]
  y1=[];
  y2=[];
  y3=[];
  y4=[];
  xa=[1:100];
  xb=[1:100];
  ya=[1:100];
  yb=[1:100];
  za=[1:100];
  zb=[1:100];

   vectorx=[xa xb]
   vectory=[ya yb]
   vectorz=[za zb]
   plot3(vectorx,vectory,vectorz)

  #bar(10, y, 5);
  #colormap (summer (64));
  set(car, "visible", "on")
end