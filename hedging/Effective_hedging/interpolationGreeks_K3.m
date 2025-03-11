function[greeks]=interpolationGreeks_K3(S0,type, StrCallPut,StrAaAgEAB, Strdeltagamma)

  if strcmp(StrCallPut, 'call') || strcmp(StrCallPut, 'Call') %for call delta
      if strcmp(StrAaAgEAB, 'Aa')
      data=load('K3_1AsianAaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'Ag')
      data=load('K3_1AsianGaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'E')
      data=load('K3_1EuropeanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'A')
      data=load('K3_1AmericanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      
      elseif strcmp(StrAaAgEAB, 'B')
      data=load ('K3_1BermudanGreeks.txt');
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      end
  elseif strcmp(StrCallPut, 'put') || strcmp(StrCallPut, 'Put') %for put delta
      if strcmp(StrAaAgEAB, 'Aa')
      data=load('K3_Put1AsianAaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'Ag')
      data=load('K3_Put1AsianGaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'E')
      data=load('K3_Put1EuropeanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'A')
      data=load('K3_Put1AmericanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      
      elseif strcmp(StrAaAgEAB, 'B')
      data=load ('K3_Put1BermudanGreeks.txt');
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      end
  end      
      
 
  %smoothin using spline
samplingRateIncrease = 5;
newXSamplePoints = linspace(min(x), max(x), length(x) * samplingRateIncrease);
 
smoothedDelta = spline(x, Delta, newXSamplePoints);
 
smoothedYGamma = spline(x, Gamma, newXSamplePoints);

%interpolation
%type='pchip';
delta = interp1(newXSamplePoints,smoothedDelta,S0,type);
 
gamma = interp1(newXSamplePoints, smoothedYGamma, S0,type);

if strcmp(Strdeltagamma, 'delta')
    greeks=delta;
else
    greeks=gamma;
end


end