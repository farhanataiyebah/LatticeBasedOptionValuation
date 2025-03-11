clear;
clc;
tic
alpha = 1.999999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=15; %Elapsed time is 944.260116 seconds.
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
M_Bermudan=2; 
Underlying=100;
[ deltax, gammax,delta, gamma ] = TrinGreeks_auxi_European(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
            
gammax
gamma         
         
          
  

%lengthX=length(deltax);
%xi = min(deltax):.25:max(deltax);
%yi=interp1(deltax, delta, xi,'cubic');
%plot (xi, yi, 'g')
%hold on
deltax=sort(deltax);
delta=sort(delta);






%%
figure
%samplingRateIncrease = 10;
%newXSamplePoints = linspace(min(deltax), max(deltax), 20);
%smoothedY = spline(deltax,delta, newXSamplePoints);
% Now flip back
%ySmooth = newXSamplePoints;
%xSmooth = smoothedY;
%plot(newXSamplePoints, smoothedY, 'b');

bls_delta=blsdelta(20:150,Strike,r,T,Sigma);
plot(20:150, bls_delta,'r')
hold on

xx = min(deltax):.25:max(deltax);
yy = spline(deltax,delta,xx);
plot(xx, yy, 'b');
legend('deltabls','SmoothDeltaEuropean')
saveas(gcf,'TrinGreeks_auxi.png')
hold off
toc