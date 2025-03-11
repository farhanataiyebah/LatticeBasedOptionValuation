function [Delta, Del,FullValue ] = BS(S0,St,K1,K3,m1,m2,m3,T,tau,r,sig)
%Put=4.2251 ;
%Put = Call_1 + K1- S0*exp(-r*T);
[Call_1, Put] = blsprice(St, K1, r, T, sig);
Call_2 = blsprice(St, K3, r, T ,sig);
% Black-Scholes delta and gamma
%Del_Call_1 = blsdelta(S0, K1,r, T, est_sig, q);
%Del_Put    = Del_Call_1 - 1 ;
%Del_Call_2 = blsdelta(S0, K3,r, T, est_sig, q);
%---------------------------------
%Gam_Call_1 = blsgamma(S0, K1, r, T, est_sig, q);%
%Gam_Put    = Gam_Call_1 ;
%Gam_Call_2 = blsgamma(S0, K3, r, T, est_sig, q);

%model dependent portfolio hedge factors for full portfolio



Del_prfl    = m1*(blsdelta(S0, K1,r, T, sig) - 1) +  m2*blsdelta(S0, K1,r, T, sig)...,  
                    + m3* blsdelta(S0, K3,r, T, sig);
                
Gam_prfl    = m1* blsgamma(S0, K1, r, T, sig) +  m2*blsgamma(S0, K1, r, T, sig)...,
                     + m3*blsgamma(S0, K3, r, T, sig);
                 
[BS_Call_1, BS_Put] = blsprice(St, K1, r, T-tau, sig);
BS_Call_2 = blsprice(St, K3, r, T-tau ,sig);


%%%% portfolio value today
P0 = m1*Put + m2*Call_1 + m3*Call_2 ;

%Delta approximation
Delta = P0 + Del_prfl * (St - S0) ;

% Delta_Gamma approximation
Del = P0 + Del_prfl *(St-S0) + 0.5*Gam_prfl*(St - S0)^2;

%%% full valuation
FullValue = m1*BS_Put + m2*BS_Call_1  +  m3*BS_Call_2 ;


