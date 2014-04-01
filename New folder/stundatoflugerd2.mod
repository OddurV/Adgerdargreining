#Ákvörðunarbreyta
#Skilgreini V[n,s]
var V{n in Namskeid,s in Stokkur},binary;

#námskeiðið sé kennt aðeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
#Stokkur taki að hámarki við 5 kennslustundum (nema stokkur 8)
s.t. FimmTimarPerStokk {s in Stokkur, ell in Namsleidir, h in Hopur: s<8}: sum{n in NamskeidHopur[ell,h]} NamskeidTimar[n]*V[n,s]<=5;

solve;