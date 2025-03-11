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
newXSamplePoints = linspace(min(x), max(x), length(x) * samplingRateIncrease);

smoothedYAsianAa = spline(x, AsianAaGamma, newXSamplePoints);

smoothedYAsianGa = spline(x, AsianGaGamma, newXSamplePoints);

smoothedYEuropean = spline(x,EuropeanGamma, newXSamplePoints);

smoothedYAmerican = spline(x,AmericanGamma, newXSamplePoints);

smoothedYBermudan = spline(x,BermudanGamma, newXSamplePoints);



plot(newXSamplePoints,smoothedYAsianAa,'k')
hold on

plot(newXSamplePoints,smoothedYAsianGa,'r')
hold on

plot(newXSamplePoints,smoothedYEuropean,'b')
hold on

blsGamma=blsgamma(newXSamplePoints,Strike,r,T,Sigma);
plot(newXSamplePoints,blsGamma,'m')
hold on

plot(newXSamplePoints,smoothedYAmerican)
hold on

plot(newXSamplePoints,smoothedYBermudan,'c')

legend('AsianAa','AsianGa', 'European', 'blsGamma', 'American', 'Bermudan')
saveas(gcf,'GammaSmoothPointPlot_Aux31.png')
hold off
%hold off
toc