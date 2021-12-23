function realCarSimulator(distanceFromRoad, width)

  tx = linspace (-8, 20, 41)';
  ty = linspace (-8, 20, 41)';
  [xx, yy] = meshgrid (tx, ty);
  r = sqrt (xx .^ 2 + yy .^ 2) + eps;
  tz = sin (r) ./ r;


  surf (tx, ty, ones(length(r)).*(-0.5), 'FaceColor',[0 1 1], 'linestyle', 'none'); #rruge

  hold on;

  a = -pi : pi/2 : pi;                             % Define Corners
  ph = pi/4;                                          % Define Angular Orientation (‘Phase’)
  x = [cos(a+ph); cos(a+ph)]/cos(ph);
  y = [sin(a+ph); sin(a+ph)]/sin(ph);
  z = [-ones(size(a)); ones(size(a))];

  x = x.*(0.05);
  y = y.*(0.05);
  z = z.+(0.5); 


  #x = x.*5; max width
  #------------------------
  #y = y.+0.93; max distance from road 
  old_x = x;
  old_y = y;
  
  x = x.*abs((5*(width/100))-5);
  y = y.+((0.93+0.1)-(distanceFromRoad/100));
  
  surf(x.+0, y.-(1.5), z, 'FaceColor','y'); 
  surf(x.-(0.5), y.-(1.5), z, 'FaceColor','y');
  surf(x.-1, y.-(1.5), z, 'FaceColor','y'); 
  surf(x.-(1.5), y.-(1.5), z, 'FaceColor','y'); 

  #(ty.*0.04).-0.2
  surf (tx.*10, (ty.*0.04).-0.24, ones(length(r)).*(-0.45), 'FaceColor','b', 'linestyle', 'none'); #rruge2

  y = old_y.-((0.93+0.1)-(distanceFromRoad/100));
  
  surf(x.+0, y.+(1.5), z, 'FaceColor','g'); 
  surf(x.-(0.5), y.+(1.5), z, 'FaceColor','g');
  surf(x.-1, y.+(1.5), z, 'FaceColor','g'); 
  surf(x.-(1.5), y.+(1.5), z, 'FaceColor','g'); 
  hold on
  axis([ -1  1    -1  1    -1  1]*1.5)
  grid on

  hold on;
  xlabel("X-axis");
  ylabel("Y-axis");
  zlabel("Z-axis");
  hold off;
end