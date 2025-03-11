clear;
clc;
tic
alpha = 1.99999;
r = 0.1;

T = 0.5;
Strike = 95;
NumOfTimeSteps=8;
 Sigma=0.10;
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


samplingRateIncrease = 10;
newXSamplePoints = linspace(min(x), max(x), length(x) * samplingRateIncrease);

smoothedYAsianAa = spline(x, AsianAaDelta, newXSamplePoints);

smoothedYAsianGa = spline(x, AsianGaDelta, newXSamplePoints);

smoothedYEuropean = spline(x,EuropeanDelta, newXSamplePoints);

smoothedYAmerican = spline(x,AmericanDelta, newXSamplePoints);

smoothedYBermudan = spline(x,BermudanDelta, newXSamplePoints);



plot(newXSamplePoints,smoothedYAsianAa,'k')
hold on

plot(newXSamplePoints,smoothedYAsianGa,'r')
hold on

plot(newXSamplePoints,smoothedYEuropean,'b')
hold on

blsDelta=blsdelta(newXSamplePoints,Strike,r,T,Sigma);
plot(newXSamplePoints,blsDelta,'m')
hold on

plot(newXSamplePoints,smoothedYAmerican)
hold on

plot(newXSamplePoints,smoothedYBermudan,'c')
title(' Delta (Auxiliary Lattice) ')
xlabel('Underlying')
ylabel('Delta')

legend('Asian Arithmetic','Asian Geometric', 'European', 'BLS', 'American', 'Bermudan')
saveas(gcf,'DeltaSmoothPointPlot_Aux31.png')
hold off
%hold off
toc