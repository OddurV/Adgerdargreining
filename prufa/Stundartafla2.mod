# Setja fyrir neðan solve;
# Þarf Nemi, Stokkur, NemiSkradur, Namsleidir
# Arekstur er tafla[Nemi, Stokkur] sem hefur hversu mörgusinnum nemandi er í tíma hverju sinni
# Arekstur2 er tafla[Nemi, Stokkur] sem virkar eins og boolean hvort nemandi er í 2 tímum eða fleyrri á sama tíma
# Arekstur3 er Listi[Stokkur] sem hefur samtals árekstra

param Arekstur {k in Nemi, s in Stokkur} := sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s];
param Arekstur2 {k in Nemi, s in Stokkur}:= if Arekstur[k,s]>1 then 1;
param Arekstur3 {s in Stokkur}:= sum{k in Nemi} Arekstur2[k,s];
printf{s in Stokkur}: "%d ", Arekstur3[s];
