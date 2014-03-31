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

#Liður D
#Tilraun 1 - No primal feasible solution found
#s.t. AEskilegSkipting {n in Namskeid,s in Stokkur}: if NamskeidStokkur[n]==s then V[n,s]=1;

#Tilraun 2 - No primal feasible solution found. Eins ef NamskeidMisseri[n]==4 eða 6.
#s.t. AEskilegSkipting {n in Namskeid,s in Stokkur}: if NamskeidStokkur[n]==s and NamskeidMisseri[n]==2 then V[n,s]=1;

#Tilraun 3 - Error. Má ekki segja V[n,s]==1?
#param Breyta {Namskeid},binary;
#maximize AEskilegSkipting: sum{n in Namskeid} Breyta[n];
#s.t. AEskilegSkiptingSkorda {n in Namskeid,s in Stokkur}: if NamskeidStokkur[n]==s and V[n,s]==1 then Breyta[n]=1;

#Tilraun 4
maximize AEskilegSkipting: sum{n in Namskeid, s in Stokkur: NamskeidStokkur[n]>0} V[n,NamskeidStokkur[n]];



solve;
param misseristeljari {m in Misseri}:= sum{n in Namskeid, s in Stokkur: NamskeidStokkur[n]>0} if V[n,NamskeidStokkur[n]]==1 and NamskeidMisseri[n]==m then 1 else 0;


#Gestur
#Flokka Namskeid Eftir Misseri 

param ErAMisseri {m in Misseri, n in Namskeid} := if NamskeidMisseri[n] == m then n else 0;
printf " " > "test.txt";
for{m in Misseri}{
	printf {n in Namskeid: ErAMisseri[m,n] > 0 and NamskeidStokkur[n]>0} "%d ", n >> "test.txt";
	printf "\n " >> "test.txt";
}

printf "\n ***********\n " >> "test.txt";
printf {m in Misseri} "%d ", sum{n in Namskeid: ErAMisseri[m,n] > 0 and NamskeidStokkur[n]>0} 1 >> "test.txt";


set Edl1 := {30,106,28,27,108,111};
set Edl2 := {31,34,112,114,30};

printf "\n ***********\n " >> "test.txt";
printf {s in Stokkur, e in Edl1: V[e,s] == 1} "%d ", e >> "test.txt"; 

printf "\n ***********\n " >> "test.txt";
printf {s in Stokkur, e in Edl2: V[e,s] == 1} "%d ", e >> "test.txt"; 

printf "\n ***********\n " >> "test.txt";
for{k in Nemi}{
printf {n in Namskeid: NemiSkradur[k, "EDL", n] == 1} "%d ", n >> "test.txt"; 
printf "\n " >> "test.txt";
}

#####

#display V;
#display EftirHadegi;
#display AEskilegSkipting;
#display misseristeljari;
end;

