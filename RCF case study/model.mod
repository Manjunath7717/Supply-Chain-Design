set RPW; 
set FPW;  

param Cost{RPW,FPW}; 
param FactoryCost{RPW};		
param AvgDemand{FPW};      
param Fixed = 1000000; 

var y{RPW} binary; 
var x{RPW,FPW} >=0; 
var z{RPW} >=0; 

minimize Total: sum{i in RPW}(FactoryCost[i]*z[i]+Fixed*y[i] ) + sum{i in RPW,j in FPW}(Cost[i,j]*x[i,j]);

s.t. C1 {j in FPW}:sum{i in RPW} (x[i,j])>=AvgDemand[j];

s.t. C2 {i in RPW,j in FPW}:(x[i,j])<=AvgDemand[j]*y[i];

s.t. C3 {i in RPW}:z[i] = sum{j in FPW}x[i,j];

