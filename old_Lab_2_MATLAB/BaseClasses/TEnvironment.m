classdef (ConstructOnLoad=true) TEnvironment  
    %Defines a lab environment comprised of 
        %One TNode Sender
        %One TNode Receiver
        %One TMedium Medium
    properties 
        Sender;
        Receiver;
        Medium;
    end
    
    methods
        function obj=TEnvironment %SHOULD NOT TAKE ARGUMENTS
        end
    end
end




