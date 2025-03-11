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
 %M_Bermudan=2;

 Underlying=100;
 %reading underlying for Asian Arithmetic
data1=load('AsianAaGreeks.txt'); 
x=data1(:,1);
AsianAaDelta=data1(:,2);

%reading underlying for Asia Geometric
data2=load('AsianGaGreeks.txt'); 
%x=data2(:,1);
AsianGaDelta=data2(:,2);  


%reading underlying for European
data2=load('EuropeanGreeks.txt'); 
%x=data2(:,1);
EuropeanDelta=data2(:,2); 

%reading underlying for American
data2=load('AmericanGreeks.txt'); 
%x=data2(:,1);
AmericanDelta=data2(:,2);


%reading underlying for Bermudan
data2=load('BermudanGreeks.txt'); 
%x=data2(:,1);
BermudanDelta=data2(:,2);


samplingRateIncrease = 20;
newXSamplePoints = linspace(50, 150, length(x) * samplingRateIncrease);

smoothedYAsianAa = spline(x, AsianAaDelta, newXSamplePoints);

smoothedYAsianGa = spline(x, AsianGaDelta, newXSamplePoints);

smoothedYEuropean = spline(x,EuropeanDelta, newXSamplePoints);

smoothedYAmerican = spline(x,AmericanDelta, newXSamplePoints);

smoothedYBermudan = spline(x,BermudanDelta, newXSamplePoints);

%%
range=60:0.1:150;
%Interpolation & Extrapolation
type='pchip';
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

blsDelta=blsdelta(range,Strike,r,T,Sigma);
plot(range,blsDelta,'m')
hold on

plot(range,IntYAmerican)
hold on

plot(range,IntYBermudan,'c')
ylim([0 max([IntYAsianAa,IntYAsianGa,IntYEuropean,IntYAmerican])])

legend('AsianAa','AsianGa', 'European', 'blsDelta', 'American', 'Bermudan')
saveas(gcf,'DeltaInterpolation_Aux31.png')
hold off
min(x)
max(x)
%hold off
toc