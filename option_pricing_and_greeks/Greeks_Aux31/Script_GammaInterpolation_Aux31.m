clear;
clc;
tic
alpha = 1.2;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=11;
Sigma=0.15;
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;
StrCallPut='Call';
 %dynamics.S0=S0;
 %M_Bermudan=2;

Underlying=100;
 %reading underlying for Asian Arithmetic
data1=load('AsianAaGreeks.txt'); 
x=data1(:,1);
AsianAaGamma=data1(:,3);

%reading underlying for Asia Geometric
data2=load('AsianGaGreeks.txt'); 
%x=data2(:,1);
AsianGaGamma=data2(:,3);  


%reading underlying for European
data2=load('EuropeanGreeks.txt'); 
%x=data2(:,1);
EuropeanGamma=data2(:,3); 

%reading underlying for American
data2=load('AmericanGreeks.txt'); 
%x=data2(:,1);
AmericanGamma=data2(:,3);


%reading underlying for Bermudan
data2=load('BermudanGreeks.txt'); 
%x=data2(:,1);
BermudanGamma=data2(:,3);


samplingRateIncrease = 10;
newXSamplePoints = linspace(70, 160, length(x) * samplingRateIncrease);

smoothedYAsianAa = spline(x, AsianAaGamma, newXSamplePoints);

smoothedYAsianGa = spline(x, AsianGaGamma, newXSamplePoints);

smoothedYEuropean = spline(x,EuropeanGamma, newXSamplePoints);

smoothedYAmerican = spline(x,AmericanGamma, newXSamplePoints);

smoothedYBermudan = spline(x,BermudanGamma, newXSamplePoints);

%%
range=70:0.1:160;
%Interpolation & Extrapolation
type='cubic';
IntYAsianAa = interp1(newXSamplePoints,smoothedYAsianAa,range,type,'extrap');

IntYAsianGa = interp1(newXSamplePoints, smoothedYAsianGa, range,type,'extrap');

IntYEuropean = interp1(newXSamplePoints,smoothedYEuropean,range,type,'extrap');

IntYAmerican = interp1(newXSamplePoints,smoothedYAmerican,range,type,'extrap');

IntYBermudan = interp1(newXSamplePoints,smoothedYBermudan,range,type,'extrap');

%%

plot(range,IntYAsianAa,'k')
hold on

plot(range,IntYAsianGa,'r')
hold on

plot(range,IntYEuropean,'b')
hold on

blsGamma=blsgamma(range,Strike,r,T,Sigma);
plot(range,blsGamma,'m')
hold on

plot(range,IntYAmerican)
hold on

plot(range,IntYBermudan,'c')
axis tight
legend('AsianAa','AsianGa', 'European', 'blsGamma', 'American', 'Bermudan')
saveas(gcf,'GammaInterpolation_Aux31.png')
hold off
%hold off
toc