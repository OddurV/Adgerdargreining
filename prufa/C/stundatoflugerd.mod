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
#var temp,>=0,integer;

minimize EftirHadegi: sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

#námskeiðið sé kennt aðeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
#Stokkur taki að hámarki við 5 kennslustundum (nema stokkur 8)
s.t. FimmTimarPerStokk {s in Stokkur, ell in Namsleidir, h in Hopur: s<8}: sum{n in NamskeidHopur[ell,h]} NamskeidTimar[n]*V[n,s]<=5;

solve;
display EftirHadegi;
#%%%%
param Arekstrar {k in Nemi, s in Stokkur} := sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s];
param Bin {k in Nemi,s in Stokkur} := if Arekstrar[k,s]>1 then 1 else 0;
param Arekstur {s in Stokkur}:= sum{k in Nemi} Bin[k,s];

param Arekstrar2 {k in Nemi, s in Stokkur} := sum{n in Namskeid: NemiSkradur[k, "EDL", n] == 1} V[n,s];
param Bin2 {k in Nemi,s in Stokkur} := if Arekstrar2[k,s]>1 then 1 else 0;
param Arekstur2 {s in Stokkur}:= sum{k in Nemi} Bin2[k,s];


#printf "" > "lidur_c.txt";
#printf{s in Stokkur}: "%d ", Arekstur[s] >> "lidur_c.txt";
#printf "\n" >> "lidur_c.txt";
display Arekstur;
display Arekstur2;

#%%%%

#%%%%%%%%%%%%%%%%%%%%
#Fall sem prentar út stundatöflurnar
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



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#Dæmi frá Tomma:
#Útreikningur á árekstrum:
#printf " " > "lidur_c.txt";
#for {k in Nemi}
#{
#    printf {s in Stokkur: s <= 8}: "%d ",
#    sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s] >> "lidur_c.txt";
#    printf "\n" >> "lidur_c.txt";
#}

#Fjöldi nema í námskeiði má reikna svona:
param FjoldiNamskeid {n in Namskeid} := sum{i in Nemi, ell in Namsleidir} NemiSkradur[i, ell, n];

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#display V;

end;
