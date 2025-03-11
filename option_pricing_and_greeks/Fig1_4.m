tic
clear;
clc;
clf;

Sigma=0.25;
r = 0.10; %rate

T = 0.5;
K = 95;
Underlying=40:160;
g=blsgamma(Underlying, K, r, T, Sigma);
plot(Underlying,g,'LineWidth',3)
title('Gamma (BS)')
xlabel('Underlying')
ylabel('Gamma')
xlim([40 160])
ylim([0 0.03])
toc