function [Result, t]=jakes(fc,v,Sigma_0,r_Rice) 
%Reference......See Figure. 1 of IEEE Transactions on Vehicular Technology,
%June , 1997, by Matthias Patzold
%Jakes Model

imaginary=1i;
%figure
% figure

%//////////////////////
%INPUTS
%/////////////////////
%Sigma_0=sqrt(P/(r_Rice+1)); %Standard Deviation;  
N1=7;           %Number of Taps for the First Box
N2=8;           %Number of Taps for the Second Box
theta_Rice=pi./4;   %We usually use pi./4;
%////////////////////

c=3.*10.^8;     %Light Speed
WL=c./fc;       %Wavelength
fm=v./WL;       %Maximum Doppler Shift

% t=0:T/Sampling_Rate:No_Samples*T;
t=0:0.00001:0.25;

C1=Sigma_0.*sqrt(2./N1);
C2=Sigma_0.*sqrt(2./N2);
m1=r_Rice.*cos(theta_Rice);
m2=r_Rice.*sin(theta_Rice);


for kk=1:N1;
    theta=2*pi*rand(1,1000);
    Cosine_1(kk,:)=cos(2.*pi.*fm.*sin(pi.*(kk-0.5)./(2.*N1)).*t+theta(1,1));
    Box_1(kk,:)=C1.*Cosine_1(kk,:);
    
end

for jj=1:N2;
    theta=2*pi*rand(1,1000);
    Cosine_2(jj,:)=cos(2.*pi.*fm.*sin(pi.*(jj-0.5)./(2.*N2)).*t+theta(1,1));
    Box_2(jj,:)=C2.*Cosine_2(jj,:);
    
end


Box_1=sum(Box_1);
Box_2=sum(Box_2);

mr_1=Box_1+m1;
mr_2=Box_2+m2;

Result=mr_1+imaginary.*mr_2;
