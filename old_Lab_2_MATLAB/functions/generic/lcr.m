function [ lcf, afd ] = lcr( sig, thr, T )
%Calculates level cross frequency and average fade duration
% ---IN
% sig is the signal in vector form
% thr is the threshold
% T is the duration of the signal
% ---OUT
% lcf is the LCF in crossings/time unit
% afd is the average fade duration in time units

% COMMENTS:
% The algorithm usues the Matlab matrix function
% instead of algorithm mased on definition of
% LCR. 
% This algorithm is about 30 times faster than
% traditional (Matlab implementation).
figure;plot(sig)
    % check errors:
    if( (nargin~=3) || (ndims(sig)~=2) )
        error( 'Wrong input parameters!' );
    end
    
    % calculate lcf for each threshold:
    lcf=zeros(1,length( thr ));
    for i = 1:length( thr ),
        tmp = ( sig < thr(i) );
        tmp = diff( tmp );
        lcf( i ) = sum( tmp==1 );
    end
    
    if lcf~=0
        afd=(T/(length(sig)-1))*sum(sig<thr)/lcf;
    else
        afd=0;
    end
    
    lcf=lcf/T;    
return;    