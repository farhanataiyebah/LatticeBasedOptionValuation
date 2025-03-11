function [param,feval] = estimated_sigma(ivol)


options  =  optimset('fminunc');
    options  =  optimset(options , 'TolFun'      , 1e-005);
    options  =  optimset(options , 'Display'     , 'iter');
    options  =  optimset(options , 'Diagnostics' , 'on');
    options  =  optimset(options , 'LargeScale'  , 'on');
    options  =  optimset(options , 'MaxFunEvals' , 40000);
    options  =  optimset(options , 'GradObj'     , 'off');
      
 %format short  
[param,feval]= fminunc('BS_RMSE',ivol,options) ;
    