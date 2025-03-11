clear;
clc;
tic
[data, txt]=xlsread('chapter6data.xlsx');
alpha = 1.9999;
r = 0.1;

T = data(19,1)/365  ; % 51/365;
Strike =  data(19,2)  ; 
NumOfTimeSteps=13;
Sigma=0.25;
lambda=sqrt(1.5);
M=2*NumOfTimeSteps+1;
StrCallPut='Call';
 %dynamics.S0=S0;
 %M_Bermudan=2;

%Underlying=data(1,4);
%reading underlying for Asian Arithmetic
data1=load('1AsianAaGreeks.txt'); 
x=data1(:,1);
AsianAaGamma=data1(:,3);

%reading underlying for Asian Geometric
data2=load('1AsianGaGreeks.txt'); 
%x=data2(:,1);
AsianGaGamma=data2(:,3);  


%reading underlying for European
data2=load('1EuropeanGreeks.txt'); 
%x=data2(:,1);
EuropeanGamma=data2(:,3); 

%reading underlying for American
data2=load('1AmericanGreeks.txt'); 
%x=data2(:,1);
AmericanGamma=data2(:,3);


%reading underlying for Bermudan
data2=load('1BermudanGreeks.txt'); 
%x=data2(:,1);
BermudanGamma=data2(:,3);


samplingRateIncrease = 20;
newXSamplePoints = linspace(min(x), max(x), length(x) * samplingRateIncrease);

smoothedYAsianAa = spline(x, AsianAaGamma, newXSamplePoints);

smoothedYAsianGa = spline(x, AsianGaGamma, newXSamplePoints);

smoothedYEuropean = spline(x,EuropeanGamma, newXSamplePoints);

smoothedYAmerican = spline(x,AmericanGamma, newXSamplePoints);

smoothedYBermudan = spline(x,BermudanGamma, newXSamplePoints);

%%
range=min(x):0.1:max(x);
%range=60:0.1:150;
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

blsGamma=blsgamma(min(x):0.1:max(x),Strike,r,T,Sigma);
plot(min(x):0.1:max(x),blsGamma,'m')
hold on

plot(range,IntYAmerican,'y')
hold on

plot(range,IntYBermudan,'c')
axis tight
legend('AsianAa','AsianGa', 'European', 'blsGamma', 'American', 'Bermudan')
saveas(gcf,'1GammaInterpolation_Aux31.png')
hold off
%hold off
min(x)
max(x)
toc
