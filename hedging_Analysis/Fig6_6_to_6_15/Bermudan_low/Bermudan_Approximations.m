function [Delta_approx, Del_Gam_approx,FullValue_approx ] = Bermudan_Approximations(S0,St,K1,K3,m1,m2,m3,T,...
                                                       tau,r,Sigma,NumOfTimeSteps,M_Bermudan,alpha,lambda,M)
%put = Call_1 + K1*exp(-Rate*T)- S0*exp(-Rate*T);
Call_1=priceOptionTrinCEVBermudanTry1(S0, K1, r,T, ...
               NumOfTimeSteps,M_Bermudan,  Sigma,alpha,lambda,M, 'Call');
put=priceOptionTrinCEVBermudanTry1(S0, K1, r,T, ...
               NumOfTimeSteps,M_Bermudan,  Sigma,alpha,lambda,M, 'Put');
            
Call_2=priceOptionTrinCEVBermudanTry1(S0, K3, r,T, ...
              NumOfTimeSteps,M_Bermudan,  Sigma,alpha,lambda,M, 'Call');
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

Del_prfl    = m1*(AuxLatticeDeltaBermudan(S0, K1, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, 'Put')) +  m2*(AuxLatticeDeltaBermudan(S0, K1, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, 'Call'))...,  
                    + m3* (AuxLatticeDeltaBermudan(S0, K3, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, 'Call'));
                
Gam_prfl    =  m1*(AuxLatticeGammaBermudan(S0, K1, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, 'Put')) +  m2*(AuxLatticeGammaBermudan(S0, K1, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, 'Call'))...,  
                    + m3* (AuxLatticeGammaBermudan(S0, K3, r, T, ...
                NumOfTimeSteps,M_Bermudan, Sigma,alpha,lambda,M, 'Call'));
%[BS_Call_1, BS_Put] = blsprice(St, K1, r_51, T_51-tau, est_sig, q_51);
%BS_Call_2 = blsprice(St, K3, r_51, T_51-tau ,est_sig, q_51);

Bermudan_Call_1=priceOptionTrinCEVBermudanTry1(St, K1, r, T-tau, ...
                NumOfTimeSteps,M_Bermudan,  Sigma,alpha,lambda,M, 'Call');
Bermudan_Put=priceOptionTrinCEVBermudanTry1(St, K1, r, T-tau, ...
                NumOfTimeSteps,M_Bermudan,  Sigma,alpha,lambda,M, 'Put');
Bermudan_Call_2 =priceOptionTrinCEVBermudanTry1(St, K3, r, T-tau, ...
                NumOfTimeSteps, M_Bermudan, Sigma,alpha,lambda,M, 'Call');
%%%% portfolio value today
P0 = m1*put + m2*Call_1 + m3*Call_2 ;

%Delta approximation
Delta_approx = P0 + Del_prfl * (St - S0) ;

% Delta_Gamma approximation
Del_Gam_approx = P0 + Del_prfl *(St-S0) + 0.5*Gam_prfl*(St - S0)^2;

%%% full valuation
FullValue_approx = m1*Bermudan_Put + m2*Bermudan_Call_1  +  m3*Bermudan_Call_2 ;