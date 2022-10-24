function result = Translate( Sliderhandle )
%   Translates slider values to real world units for use in measurements
  
   minimum=get(Sliderhandle,'Min');
   maximum=get(Sliderhandle,'Max');
   value=get(Sliderhandle,'Value');
   
   switch get(Sliderhandle,'Tag')
       case 'Hslider'
           v1=5;    %   5m for slider=minimum
           v2=100;  % 100m for slider=maximum
       case 'Elslider'
           v1=-60;    % -60deg for slider=minimum
           v2= 60;    %  60deg for slider=maximum
       case 'Azslider'
           v1=-180;    % -180deg for slider=minimum
           v2= 180;    %  180deg for slider=maximum
       case 'Horslider'
           v1=-100;    % -100m for slider=minimum
           v2= 100;    %  100m for slider=maximum
       case 'Distslider'
           v1= 1995;    %  150m for slider=minimum
           v2=  195;    %    5m for slider=maximum
       case 'Losslider'
           v1=   0;    %    0% for slider=minimum
           v2= 100;    %  100% for slider=maximum
       case 'Wideslider'
           v1=  10;    %   10m for slider=minimum
           v2= 100;    %  100m for slider=maximum
       case 'Powerslider'
           v1=   1;    %   10 powerunits for slider=minimum
           v2= 100;    %  100 powerunits for slider=maximum
       case 'Freqslider'
           v1= 400;    %   10 freq units for slider=minimum
           v2=5000;    %  100 freq units for slider=maximum
       case 'Speedslider'
           v1=   1;    %   10 speed units for slider=minimum
           v2= 200;    %  100 speed units for slider=maximum
       case 'Riceslider'
           v1=   1;    %    1 for slider=minimum
           v2=  50;    %   50 for slider=maximum
       case 'Nofpathsslider'
           v1=   1;    %    0 paths for slider=minimum
           v2=  20;    %   20 paths for slider=maximum
       case 'SNRslider'
           v1=-30;    % -100 db for slider=minimum
           v2= 30;    %  100 db for slider=maximum       
       otherwise
           error('Unknown object %s called the Translate.m function!',get(Sliderhandle,'Tag'));
   end
   
   %interpolation..
   a=(v2-v1)/(maximum-minimum);
   b=v1-a*minimum; 
   
   result=a*value+b;
   
end

