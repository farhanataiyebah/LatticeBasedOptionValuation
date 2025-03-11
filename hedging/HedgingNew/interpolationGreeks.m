function[greeks]=interpolationGreeks(S0,type, StrCallPut,StrAaAgEAB, Strdeltagamma)

  if strcmp(StrCallPut, 'call') || strcmp(StrCallPut, 'Call') %for call delta
      if strcmp(StrAaAgEAB, 'Aa')
      data=load('1AsianAaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'Ag')
      data=load('1AsianGaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'E')
      data=load('1EuropeanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'A')
      data=load('1AmericanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      
      elseif strcmp(StrAaAgEAB, 'B')
      data=load ('1BermudanGreeks.txt');
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      end
  elseif strcmp(StrCallPut, 'put') || strcmp(StrCallPut, 'Put') %for put delta
      if strcmp(StrAaAgEAB, 'Aa')
      data=load('Put1AsianAaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'Ag')
      data=load('Put1AsianGaGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'E')
      data=load('Put1EuropeanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      elseif strcmp(StrAaAgEAB, 'A')
      data=load('Put1AmericanGreeks.txt'); 
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      
      elseif strcmp(StrAaAgEAB, 'B')
      data=load ('Put1BermudanGreeks.txt');
      x=data(:,1);
      Delta=data(:,2);
      Gamma=data(:,3);
      end
  end      
      
  
  %smoothin using spline
samplingRateIncrease = 20;
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