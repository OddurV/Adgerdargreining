param Arekstrar {k in Nemi, s in Stokkur} 
:= sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s];
param Bin {k in Nemi,s in Stokkur} := if Arekstrar[k,s]>1 then 1 else 0;
param Arekstur {s in Stokkur}:= sum{k in Nemi} Bin[k,s];

param Arekstrar2 {k in Nemi, s in Stokkur}
:= sum{n in Namskeid: NemiSkradur[k, "EDL", n] == 1} V[n,s];
param Bin2 {k in Nemi,s in Stokkur} := if Arekstrar2[k,s]>1 then 1 else 0;
param Arekstur2 {s in Stokkur}:= sum{k in Nemi} Bin2[k,s];