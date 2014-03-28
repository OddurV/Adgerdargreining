param Arekstur {k in Nemi, s in Stokkur} := sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s];
param Arekstur2 {k in Nemi, s in Stokkur}:= if Arekstur[k,s]>1 then 1;
param Arekstur3 {s in Stokkur}:= sum{k in Nemi} Arekstur2[k,s];
printf{s in Stokkur}: "%d ", Arekstur3[s];
