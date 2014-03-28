#Mengi
# Námskeiðshópur innan við námsleið
set Hopur := {1..7};
# Nemi
set Nemi := {1..1858};
# Stokkar 7 og stokkur 8 (táknar utan stokka)
set Stokkur := {1..8};
# Á vorin erum við með þessi 3 misseri
set Misseri := {2,4,6};
# Námskeiðin
set Namskeid := {1..141};
# Tegundir námsleiða þær eru 15 samtals
set Namsleidir;
# Skilgreinir námskeiðshóp innan námsleiðar
set NamskeidHopur {Namsleidir, Hopur} within Namskeid;

#Breytur
# Æskilegur stokkur fyrir námskeið, annars núll
param NamskeidStokkur{Namskeid};
# Hvaða misseri tilheyrir námskeiðið.
param NamskeidMisseri{Namskeid};
# Hvað þarf námskeiðið marga tíma í stokkakerfið, oftast 5.
param NamskeidTimar {Namskeid};
# Í hvaða námskeið er nemi skráður.
param NemiSkradur {Nemi,Namsleidir,Namskeid}, binary;

#Ákvörðunarbreyta
#Skilgreini V[n,s]
var V{n in Namskeid,s in Stokkur},binary;

minimize EftirHadegi: sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

#námskeiðið sé kennt aðeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
#Stokkur taki að hámarki við 5 kennslustundum (nema stokkur 8)
s.t. FimmTimarPerStokk {s in Stokkur, ell in Namsleidir, h in Hopur: s<=8}: sum{n in NamskeidHopur[ell,h]} NamskeidTimar[n]*V[n,s]<=5;


solve;
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#Dæmi frá Tomma:
#Útreikningur á árekstrum:
printf " " > "lidur_c.txt";
for {k in Nemi}
{
    printf {s in Stokkur: s <= 8}: "%d ",
    sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s] >> "lidur_c.txt";
    printf "\n" >> "lidur_c.txt";
}

#Fjöldi nema í námskeiði má reikna svona:
param FjoldiNamskeid {n in Namskeid} := sum{i in Nemi, ell in Namsleidir} NemiSkradur[i, ell, n];

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



#display V;
display EftirHadegi;

end;
