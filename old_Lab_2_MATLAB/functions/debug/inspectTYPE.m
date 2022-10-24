function inspectTYPE(obj)
%inspect the current environment
     
  if isa(obj,'TEnvironment')
     disp('----------------MEDIUM')
     obj.Medium
     disp('----------------SENDER')
     obj.Sender
     obj.Sender.Signal
     obj.Sender.Antenna
     disp('----------------RECEIVER')
     obj.Receiver
     obj.Receiver.Antenna
  elseif isa(obj,'TMeasurement')
     disp('----------------MEASUREMENT') 
     obj 
  end

end

