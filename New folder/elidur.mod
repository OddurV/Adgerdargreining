#Fyrri hluti:
var Z;
maximize Breyta: Z;
s.t. Breytuheiti {s in Stokkur}: sum{n in Namskeid} V[n,s]/FjoldiNamskeid[n]>=Z;

#námskeiğiğ sé kennt ağeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;


#Seinni hluti (breyti markfallinu şannig ağ şağ reyni ağ setja sem flest námskeiğ fyrir hádegi)
var Z;
maximize Breyta: Z-sum{n in Namskeid, s in Stokkur: s>5} V[n,s];
s.t. Breytuheiti {s in Stokkur}: sum{n in Namskeid} V[n,s]/FjoldiNamskeid[n]>=Z;

#námskeiğiğ sé kennt ağeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;

