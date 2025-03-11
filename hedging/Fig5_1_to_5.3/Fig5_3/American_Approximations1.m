function [Delta_approx, Del_Gam_approx,FullValue_approx ] = American_Approximations1(S0,St,K1,K3,m1,m2,m3,T,tau,Rate,Sigma,NumOfTimeSteps,alpha,lambda,M)

%put = Call_1 + K1*exp(-Rate*T)- S0*exp(-Rate*T);
Call_1=priceOptionTrinCEVAmericanTry1(S0, K1, Rate,T, ...
               NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
put=priceOptionTrinCEVAmericanTry1(S0, K1, Rate,T, ...
               NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Put');
            
Call_2=priceOptionTrinCEVAmericanTry1(S0, K3, Rate,T, ...
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

Del_prfl    = m1*(interpolationGreeks_K1(S0,'pchip', 'Put','A', 'delta')) +  m2*(interpolationGreeks_K1(S0,'pchip', 'Call','A', 'delta'))...,  
                    + m3* (interpolationGreeks_K3(S0,'pchip', 'Call','A', 'delta'));
                
Gam_prfl    = m1*(interpolationGreeks_K1(S0,'pchip', 'Put','A', 'gamma')) +  m2*(interpolationGreeks_K1(S0,'pchip', 'Call','A', 'gamma'))...,  
                    + m3* (interpolationGreeks_K3(S0,'pchip', 'Call','A', 'gamma'));
                 
%[BS_Call_1, BS_Put] = blsprice(St, K1, r_51, T_51-tau, est_sig, q_51);
%BS_Call_2 = blsprice(St, K3, r_51, T_51-tau ,est_sig, q_51);

American_Call_1=priceOptionTrinCEVAmericanTry1(St, K1, Rate, T-tau, ...
                NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
American_Put=priceOptionTrinCEVAmericanTry1(St, K1, Rate, T-tau, ...
                NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Put');
American_Call_2 =priceOptionTrinCEVAmericanTry1(St, K3, Rate, T-tau, ...
                NumOfTimeSteps,  Sigma,alpha,lambda,M, 'Call');
%%%% portfolio value today
P0 = m1*put + m2*Call_1 + m3*Call_2 ;

%Delta approximation
Delta_approx = P0 + Del_prfl * (St - S0) ;

% Delta_Gamma approximation
Del_Gam_approx = P0 + Del_prfl *(St-S0) + 0.5*Gam_prfl*(St - S0)^2;

%%% full valuation
FullValue_approx = m1*American_Put + m2*American_Call_1  +  m3*American_Call_2 ;