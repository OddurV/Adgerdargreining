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
param FjoldiNamskeid {n in Namskeid} := sum{i in Nemi, ell in Namsleidir} NemiSkradur[i, ell, n];
#Ákvörðunarbreyta
#Skilgreini V[n,s]
var V{n in Namskeid,s in Stokkur},binary;


#Fyrri hluti:
var Z;
maximize Breyta: Z;
s.t. Breytuheiti {s in Stokkur}: sum{n in Namskeid} V[n,s]/FjoldiNamskeid[n]>=Z;

#námskeiðið sé kennt aðeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;


/*
#Seinni hluti (breyti markfallinu þannig að það reyni að setja sem flest námskeið fyrir hádegi)
var Z;
maximize Breyta: Z-sum{n in Namskeid, s in Stokkur: s>5} V[n,s];
s.t. Breytuheiti {s in Stokkur}: sum{n in Namskeid} V[n,s]/FjoldiNamskeid[n]>=Z;

#námskeiðið sé kennt aðeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
*/


solve;
printf "">"V.txt";
for{n in Namskeid}{
    for{s in Stokkur}{
        printf V[n,s]>> "V.txt";
        printf " ">> "V.txt";
        }
    printf "\n">> "V.txt";
}
#display V;
#display FjoldiNamskeid;

printf "">"FjoldiNamskeid.txt";
printf "Hver lina er hvert fag og tolurnar eru fj nemenda i theim fogum\n" >> "FjoldiNamskeid.txt"; 
printf {n in Namskeid} "%d\n ", FjoldiNamskeid[n] >> "FjoldiNamskeid.txt";

printf "">"FjoldiStokkur.txt";
for{m in Misseri}{
    printf "Misseri ">>"FjoldiStokkur.txt";
    printf m>>"FjoldiStokkur.txt";
    printf ": \n">>"FjoldiStokkur.txt";
    for{s in Stokkur}{
        printf "Stokkur ">>"FjoldiStokkur.txt";
        printf s>>"FjoldiStokkur.txt";
        printf ": ">>"FjoldiStokkur.txt";
        printf sum{n in Namskeid: V[n,s]==1 and NamskeidMisseri[n]==m} FjoldiNamskeid[n]>>"FjoldiStokkur.txt";
        printf "\n">>"FjoldiStokkur.txt";
    }
}

printf "">"Tafla.txt";
printf "Dreifing faganna er eftirfarandi, (fyrri tala taknar fag og su seinni stokk):\n" >> "Tafla.txt"; 
printf {n in Namskeid, s in Stokkur: V[n,s]==1} "%d %d\n", n,s >> "Tafla.txt";

#%%%%%%%%%%%%%%%%%%%%
#Fall sem prentar út stundatöflurnar fyrir eðlisfræðina
printf " " > "stundatoflur.txt";
param EDLfjoldi{n in Namskeid} := sum{k in Nemi: NemiSkradur[k,"EDL", n] == 1}1;
#param EDLI {n in Namskeid} := for{k in Nemi}
printf "\n ***********\n " >> "stundatoflur.txt";

#ÞETTA SÝNIR HVAÐA NÁMSKEIÐ FARA Í HVAÐA STOKK Í EÐLISFRÆÐIHÓPNUM
#ÞAR SEM NÚMER LÍNU ER NÚMER STOKKS
param ErAMisseri {m in Misseri, n in Namskeid} := if NamskeidMisseri[n] == m then n else 0;
for{m in Misseri}{
    printf "Misseri " >> "stundatoflur.txt";
    printf m >> "stundatoflur.txt";
    printf "\n " >> "stundatoflur.txt";
    for{s in Stokkur}{
        printf "Stokkur " >> "stundatoflur.txt";
        printf s >> "stundatoflur.txt";
        printf ": " >> "stundatoflur.txt";
        printf {n in Namskeid: V[n,s] == 1 and EDLfjoldi[n]>0 and ErAMisseri[m,n]>0} "%d ", n >> "stundatoflur.txt";  
        printf "\n " >> "stundatoflur.txt";
    }
printf "---\n " >> "stundatoflur.txt";
}
#%%%%%%%%%%%%%%%%%%%%

end;