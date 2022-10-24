function v=applyUnitScale2(in,Scale)
% e.g. v=applyUnitScale(10,'KHz') , v-> 10000
% Scale should be of type string. in is numeric. Typechecking is disabled for speed.
% Scale is case sensitive. Values MUST INCLUDE the possible
% values of every handles.*unitpop 
    switch Scale
        case 'Hz'
            v=in;
        case 'KHz'
            v=in*(10^3);
        case 'MHz'
            v=in*(10^6);
        case 'GHz'
            v=in*(10^9);
        case 'W'
            v=in;
        case 'dbW'
            v=10^(in*0.1);
        case 'mW'
            v=in/1000;
        case 'dbmW'
            v=(10^(in*0.1))/1000;
        case 'm/s'
            v=in;
        case 'Km/h'
            v=in*1000/3600;            
        case 'deg'
            v=in*pi/180;
        otherwise
            v=in*1;
    end
end