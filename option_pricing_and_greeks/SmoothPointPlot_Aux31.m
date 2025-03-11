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
 
 [ s,delta, gamma ] = AuxLatticeGreeks_31(Underlying, Strike, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, StrCallPut);
s  ;        
delta;
gamma;

%%% Create the original knot points.
xInitial = gamma;
yInitial = s;
lengthX = length(xInitial);
% flip sideways so there is only 1 y for every x
x = yInitial;
y = xInitial;
% Plot it and show how the line has sharp bends.
plot(x, y, '-sr', 'LineWidth', 2);
grid on;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
% Use splines to interpolate a smoother curve,
% with 10 times as many points,
% that goes exactly through the same data points.
samplingRateIncrease = 10;
newXSamplePoints = linspace(min(x), max(x), lengthX * samplingRateIncrease);
smoothedY = spline(x, y, newXSamplePoints);
% Now flip back
ySmooth = newXSamplePoints;
xSmooth = smoothedY;
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
hold on; % Don't destroy the first curve we plotted.
plot(newXSamplePoints, smoothedY, '-ob');
hold on
blsGamma=blsgamma(newXSamplePoints,Strike,r,T,Sigma);
plot(newXSamplePoints,blsGamma,'r')
title('Spline Interpolation Demo', 'FontSize', 20);
legend('Original Points', 'Spline Points','blsGamma');
figure;
plot(xInitial, yInitial, '-sr', 'LineWidth', 2);
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
hold on; % Don't destroy the first curve we plotted.
plot(xSmooth, ySmooth, '-ob');
hold on

hold off
grid on;
%%