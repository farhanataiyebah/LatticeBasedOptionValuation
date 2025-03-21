function [Delta_approx, Del_Gam_approx,FullValue_approx ] = European_Approximations(S0,St,K1,K3,m1,m2,m3,T,...
                                                       tau,r,Sigma,NumOfTimeSteps,alpha,lambda,M)
%put = Call_1 + K1*exp(-Rate*T)- S0*exp(-Rate*T);
Call_1=priceOptionTrinCEVEuropeanTry1(S0, K1, r,T, ...
               NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
put=priceOptionTrinCEVEuropeanTry1(S0, K1, r,T, ...
               NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Put');
            
Call_2=priceOptionTrinCEVEuropeanTry1(S0, K3, r,T, ...
              NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
 %%
 
%put = Call1 + K1*exp(-Rate*T)- S0*exp(-Rate*T);
% Black-Scholes delta and gamma
%Del_Call_1 = blsdelta(S0, K1,r, T, est_sig, q);
%Del_Put    = Del_Call_1 - 1 ;
%Del_Call_2 = blsdelta(S0, K3,r, T, est_sig, q);
%---------------------------------
%Gam_Call_1 = blsgamma(S0, K1, r, T, est_sig, q);%
%Gam_Put    = Gam_Call_1 ;
%Gam_Call_2 = blsgamma(S0, K3, r, T, est_sig, q);

%model dependent portfolio hedge factors for full portfolio
%computeDeltaAsian(S0, Strike, r_51, T_51,NumOfTimeSteps, est_sig,alpha,lambda,M, StrCallPut);
%interpolationGreeks_K1(S0,'pchip', 'Put','E', 'delta')

Del_prfl    = m1*(AuxLatticeDeltaEuropean(S0, K1, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, 'Put')) +  m2*(AuxLatticeDeltaEuropean(S0, K1, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, 'Call'))...,  
                    + m3* (AuxLatticeDeltaEuropean(S0, K3, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, 'Call'));
                
Gam_prfl    =  m1*(AuxLatticeGammaEuropean(S0, K1, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, 'Put')) +  m2*(AuxLatticeGammaEuropean(S0, K1, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, 'Call'))...,  
                    + m3* (AuxLatticeGammaEuropean(S0, K3, r, T, ...
                NumOfTimeSteps, Sigma,alpha,lambda,M, 'Call'));
%[BS_Call_1, BS_Put] = blsprice(St, K1, r_51, T_51-tau, est_sig, q_51);
%BS_Call_2 = blsprice(St, K3, r_51, T_51-tau ,est_sig, q_51);

European_Call_1=priceOptionTrinCEVEuropeanTry1(St, K1, r, T-tau, ...
                NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
European_Put=priceOptionTrinCEVEuropeanTry1(St, K1, r, T-tau, ...
                NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Put');
European_Call_2 =priceOptionTrinCEVEuropeanTry1(St, K3, r, T-tau, ...
                NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
%%%% portfolio value today
P0 = m1*put + m2*Call_1 + m3*Call_2 ;

%Delta approximation
Delta_approx = P0 + Del_prfl * (St - S0) ;

% Delta_Gamma approximation
Del_Gam_approx = P0 + Del_prfl *(St-S0) + 0.5*Gam_prfl*(St - S0)^2;

%%% full valuation
FullValue_approx = m1*European_Put + m2*European_Call_1  +  m3*European_Call_2 ;