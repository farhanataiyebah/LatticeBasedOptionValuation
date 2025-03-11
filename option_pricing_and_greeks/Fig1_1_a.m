tic
clear;
clc;
clf;

Sigma=0.25;
elasticity = 1.9999; %elasticity
%dynamics.volcoeff = 3;
r = 0.10; %rate

T = 0.5;
K = 95;
StrCallPut='Call';
Underlying=40:5:150;
[c,p]=blsprice(Underlying, K, r, T, Sigma);
plot(Underlying,c,'LineWidth',3)
xlim([50 150])
ylim([0 60])
title('Call Prices under BS model ')
xlabel('Underlying')
ylabel('Call prices')
toc