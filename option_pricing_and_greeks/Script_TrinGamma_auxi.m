clear;
clc;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=13;
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
         
          
  
%gammax=sort(gammax);

%gamma=sort(gamma);
%lengthX=length(deltax);
%xi = min(deltax):.25:max(deltax);
%yi=interp1(deltax, delta, xi,'cubic');
%plot (xi, yi, 'g')
%hold on



%%
%samplingRateIncrease = 10;
%newXSamplePoints = linspace(min(deltax), max(deltax), 20);
%smoothedY = spline(deltax,delta, newXSamplePoints);
% Now flip back
%ySmooth = newXSamplePoints;
%xSmooth = smoothedY;
%plot(newXSamplePoints, smoothedY, 'b');

%bls_delta=blsdelta(20:160,Strike,r,T,Sigma);
%plot(20:160, bls_delta,'r')
figure 
x = gammax;
y = gamma;
xx = linspace(min(x),max(x),101);
cs = spline(x,y,xx);

plot(x,y,'o',xx,cs,'-');
%xx = min(gammax):.01:max(gammax);
%yy = spline(gammax,gamma,xx);
%plot(xx, yy, 'b');
%legend('interpp','deltabls')
saveas(gcf,'TrinGamma_auxi.png')
hold off
toc