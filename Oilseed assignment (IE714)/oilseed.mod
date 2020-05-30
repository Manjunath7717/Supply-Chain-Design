# We have assumed in modal that the extraction E2 is already opened at low tech with capacity 9000 ton/month. Hence, No setup cost is considered for E2

param l; # no of fields
param n; # no of plants
param t; # no of extraction plants
param q;
set H = 1..l;
set P = 1..q;
set I = 1..n;
set E = 1..t;
param chi{H, I}; #cost of shipping from fields to plant location
param cie{I, E}; #cost of shipping from plant to extraction plants
param cej{E,P}; # cost of shipping from extraction plant to refinary
param ciq{I,P}; #cost of shiiping oil from plant to refinary
param f{I}; #seed cake produced per tonn
param oc{I}; #oil content present
param p{I}; #processing cost
param ec{E}; # extraction cost
param sh{H}; # capacity of field at location h
param ki{I}; # capacity at plant i
param Qe{E}; # capacity of extraction plant at e
param Fi{I}; # cost of locating plants
param fe{E}; # cost of locating extraction plant E
var yi{I}, binary ; # plant is located at site i
var ye{E}, binary; # extraction plant is located at e
var xej{E,P}, >= 0; # oil shipped from extraction to refinary 
var xie{I,E}, >= 0; # seed cake shipped from plant TO extraction source
var Xij{I,P}, >= 0; # oil shipped from plant to refinary
var xhi{H,I}, >= 0; # seed shipped from field to plant

minimize cost: sum{i in I} Fi[i]*yi[i] + sum {e in E}(fe[e]*ye[e]) + sum {h in H ,i in I}(chi[h,i]*xhi[h,i]) +sum {i in I}((sum{h in H} xhi[h,i])*p[i]) + sum {i in I, e in E}(cie[i,e]*xie[i,e])+ sum{i in I,j in P}(ciq[i,j]*Xij[i,j]) + sum{e in E, j in P}(cej[e,j]*xej[e,j])+ sum{i in I,e in E}(ec[e]*xie[i,e]);
s.t. C1{h in H} : sum{i in I}xhi[h,i] = sh[h]; # all the oil seed reaches to plant
s.t. C2{e in E} : sum{i in I}(xie[i, e]) <= Qe[e]*ye[e]; #Only the amount that extraction plant can process will be shipped to that plant.
s.t. C3{i in I} : sum{h in H}(xhi[h,i]*f[i]) = sum {e in E}xie[i,e] ; # Only the produced amount of output seedcake goes from plant 
s.t. C4{i in I} : ki[i]*yi[i]>= sum{h in H} xhi[h,i]; #seeds are shipped from fields to plant only if that plant is open
s.t. C5{e in E} : sum{j in P}(xej[e,j]) <= Qe[e]*ye[e]; # amount of oil sent is equal to amount of oil produced at plant
s.t. C6{e in E}	: sum{i in I}(xie[i,e]*oc[i] ) = sum{j in P}xej[e,j];
s.t. C7{j in P, i in I} : sum{h in H}(xhi[h,i]*(1-f[i])) = Xij[i,j] ; # oil produced at plants reaches directly at refinary
