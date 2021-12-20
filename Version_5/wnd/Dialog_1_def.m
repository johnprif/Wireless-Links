graphics_toolkit qt;

function ret = show_Dialog_1(Received_Field_switch, Power_Delay_Profile_switch, Transfer_function_switch)
  figure;
  %Received_Field_Figure=figure('title', 'Received Field', 'visible', Received_Field_switch);
  if(strcmp(Received_Field_switch, 'on')==1)
    %Received_Field_Figure=figure('title', 'Received Field', 'visible', Received_Field_switch);
    subplot(3,2,1,"align"); 
    x=1:100:1000;
    plot(sin(x));
    title('Received Field(t)');
    xlabel('distance - (m)');
    ylabel('Received Field - dBM');
    axis('on');
    grid('on');
    subplot(3,2,2, "align"); 
    x=1:100:1000;
    hist (randn (10000, 1), 30);
    %plot(sin(x));
    title('Received Field(t)');
    xlabel('Power Values');
    ylabel('Histogram');
    axis('on');
    grid('on');
  endif
  if(strcmp(Power_Delay_Profile_switch, 'on')==1)
    %Power_Delay_Profile_switch=figure('title', 'Power Delay Profile', 'visible', Power_Delay_Profile_switch);
    x=1:4:100;
    subplot(3,1,2, "align");
    plot(x,x);
    title('Power Delay Profile');
    xlabel('Relative Delay - t(sec)');
    ylabel('Relative Power - dB');
    axis('on');
    grid('on');
  endif
  if(1)
    %Data_Table_Figure=figure('visible', 'on');
    x=1:1:10;
    subplot(3,1,3, "align"); 
    plot(x,x);
    title('Data');
    axis('on');
    grid('on');
  endif
  
  ret = 0;
end

