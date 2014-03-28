param Arekstur {k in Nemi, s in Stokkur} := sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s];

for{k in Nemi}{
  printf{s in Stokkur}: "%d ", if Arekstur[k,s]>1 then 1 >> "lidur_c.txt";
  printf "\n" >> "lidur_c.txt";
}
