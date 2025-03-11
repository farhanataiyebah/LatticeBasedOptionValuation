clear;
clc;
tic
alpha = 1.999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8;
 Sigma=0.15;
 lambda=sqrt(1.5);
 M=2*NumOfTimeSteps+1;
 StrCallPut='Call';
 %dynamics.S0=S0;
 %M_Bermudan=2;

 Underlying=100;
 
 [ x,delta, gamma ] = AuxLatticeGreeks_31(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
x          
delta
gamma
figure 
y = gamma;
xx = linspace(min(x),max(x),130);
cs = spline(x,y,xx);

plot(xx,cs,'b');
hold on

%xx = min(gammax):.01:max(gammax);
%yy = spline(gammax,gamma,xx);
%plot(xx, yy, 'b');
%legend('interpp','deltabls')
blsGamma=blsgamma(xx,Strike,r,T,Sigma);
plot(xx,blsGamma,'r')
legend('EuropeanCEVgamma','blsGamma')
saveas(gcf,'TrinGamma_auxi.png')
hold off
%hold off
toc