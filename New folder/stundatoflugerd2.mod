#�kv�r�unarbreyta
#Skilgreini V[n,s]
var V{n in Namskeid,s in Stokkur},binary;

#n�mskei�i� s� kennt a�eins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
#Stokkur taki a� h�marki vi� 5 kennslustundum (nema stokkur 8)
s.t. FimmTimarPerStokk {s in Stokkur, ell in Namsleidir, h in Hopur: s<8}: sum{n in NamskeidHopur[ell,h]} NamskeidTimar[n]*V[n,s]<=5;

solve;