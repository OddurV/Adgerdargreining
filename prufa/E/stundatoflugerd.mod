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
var Z;
maximize Z;
s.t. Breytuheiti {s in Stokkur}: (sum{n in Namskeid} V[n,s])/FjoldiNamskeid[n]>=Z;

param FjoldiNamskeid {n in Namskeid} := sum{i in Nemi, ell in Namsleidir} NemiSkradur[i, ell, n];


#námskeiðið sé kennt aðeins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
#Stokkur taki að hámarki við 5 kennslustundum (nema stokkur 8)
s.t. FimmTimarPerStokk {s in Stokkur, ell in Namsleidir, h in Hopur: s<=8}: sum{n in NamskeidHopur[ell,h]} NamskeidTimar[n]*V[n,s]<=5;


#Liður D
#Fyrri hluti
#Þetta markfall virkar þannig að það leggur saman öll námskeiðin sem lenda í æskilegum stokki, og dregur svo frá 
#summu þeirra námskeiða sem lenda eftir hádegi eða utan stokka
maximize AEskilegSkipting: (sum{n in Namskeid: NamskeidStokkur[n]>0} V[n,NamskeidStokkur[n]])-sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

solve;
#Fjöldi námskeiða sem lenda í æskilegum stokki á hverju misseri fyrir sig (Sanity check: það eru bara 82 námskeið með skilgreindan uppáhaldsstokk, þannig að summa þessara þriggja talna getur ekki verið stærri en 82)
param AEskilegSkiptingPerMisseri {m in Misseri}:= sum{n in Namskeid: NamskeidStokkur[n]>0} if V[n,NamskeidStokkur[n]]==1 and NamskeidMisseri[n]==m then 1 else 0;
#display V;
param EftirHadegi := sum{n in Namskeid, s in Stokkur: s>5} V[n,s];
display EftirHadegi;#Hversu mörg námskeið eru eftir hádegi eða utan stokka
display AEskilegSkipting;
display AEskilegSkiptingPerMisseri;
#prufubreytur til að sjá skiptinguna í markfallinu betur, á ekki heima í skýrslunni
param prufa1 := sum{n in Namskeid: NamskeidStokkur[n]>0} V[n,NamskeidStokkur[n]];
param prufa2 := sum{n in Namskeid, s in Stokkur: s>5} V[n,s];
param prufa3 := prufa1-prufa2;
display prufa1;
display prufa2;
display prufa3;

/*
#Niðurstöður hjá Oddi (í Windows), til samanburðar
Display statement at line 48
EftirHadegi = 14
Display statement at line 49
AEskilegSkipting.val = 49
Display statement at line 50
AEskilegSkiptingPerMisseri[2] = 18
AEskilegSkiptingPerMisseri[4] = 28
AEskilegSkiptingPerMisseri[6] = 17
Display statement at line 55
prufa1 = 63
Display statement at line 56
prufa2 = 14
Display statement at line 57
prufa3 = 49
*/



/*
#Seinni hluti
#Þetta markfall virkar þannig að það leggur saman öll námskeiðin sem lenda í æskilegum stokki og margfaldar 
#þá summu með stórum fasta, svo dregur það frá summu þeirra námskeiða sem lenda eftir hádegi eða utan stokka 
#(það er líka hægt að setja fasta á það til að gera það mikilvægara)
#Með því að fikta í þessum föstum er hægt að fá mismunandi niðurstöður
maximize AEskilegSkipting: (sum{m in Misseri, n in Namskeid: NamskeidStokkur[n]>0} if NamskeidMisseri[n]==2 then 10000*V[n,NamskeidStokkur[n]] else V[n,NamskeidStokkur[n]])-100*sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

solve;
#Fjöldi námskeiða sem lenda í æskilegum stokki á hverju misseri fyrir sig (Ath það eru bara 82 námskeið með skilgreindan uppáhaldsstokk)
param AEskilegSkiptingPerMisseri {m in Misseri}:= sum{n in Namskeid: NamskeidStokkur[n]>0} if V[n,NamskeidStokkur[n]]==1 and NamskeidMisseri[n]==m then 1 else 0;
#display V;
param EftirHadegi := sum{n in Namskeid, s in Stokkur: s>5} V[n,s];#Hversu mörg námskeið eru eftir hádegi eða utan stokka
display EftirHadegi;
#display AEskilegSkipting; #Í seinni hlutanum segir þetta manni eiginlega ekki neitt gagnlegt held ég
display AEskilegSkiptingPerMisseri;#hversu mörg námskeið lenda í æskilegum stokki
*/
/*
#Niðurstöður hjá Oddi (í Windows), til samanburðar
#Fastar í markfallinu: 10000 og 100
Display statement at line 93
EftirHadegi = 14
Display statement at line 95
AEskilegSkiptingPerMisseri[2] = 22
AEskilegSkiptingPerMisseri[4] = 23
AEskilegSkiptingPerMisseri[6] = 14
*/



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
end;