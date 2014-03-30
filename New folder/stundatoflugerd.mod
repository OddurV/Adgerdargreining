#Mengi
# N�mskei�sh�pur innan vi� n�mslei�
set Hopur := {1..7};
# Nemi
set Nemi := {1..1858};
# Stokkar 7 og stokkur 8 (t�knar utan stokka)
set Stokkur := {1..8};
# � vorin erum vi� me� �essi 3 misseri
set Misseri := {2,4,6};
# N�mskei�in
set Namskeid := {1..141};
# Tegundir n�mslei�a ��r eru 15 samtals
set Namsleidir;
# Skilgreinir n�mskei�sh�p innan n�mslei�ar
set NamskeidHopur {Namsleidir, Hopur} within Namskeid;

#Breytur
# �skilegur stokkur fyrir n�mskei�, annars n�ll
param NamskeidStokkur{Namskeid};
# Hva�a misseri tilheyrir n�mskei�i�.
param NamskeidMisseri{Namskeid};
# Hva� �arf n�mskei�i� marga t�ma � stokkakerfi�, oftast 5.
param NamskeidTimar {Namskeid};
# � hva�a n�mskei� er nemi skr��ur.
param NemiSkradur {Nemi,Namsleidir,Namskeid}, binary;

#�kv�r�unarbreyta
#Skilgreini V[n,s]
var V{n in Namskeid,s in Stokkur},binary;
#var temp,>=0,integer;

minimize EftirHadegi: sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

#n�mskei�i� s� kennt a�eins einu sinni
s.t. NamskeidKennt {n in Namskeid}: sum{s in Stokkur: s<=8} V[n,s]=1;
#Stokkur taki a� h�marki vi� 5 kennslustundum (nema stokkur 8)
s.t. FimmTimarPerStokk {s in Stokkur, ell in Namsleidir, h in Hopur: s<=8}: sum{n in NamskeidHopur[ell,h]} NamskeidTimar[n]*V[n,s]<=5;

solve;

#%%%%
param Arekstrar {k in Nemi, s in Stokkur} := sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s];
param Bin {k in Nemi,s in Stokkur} := if Arekstrar[k,s]>1 then 1 else 0;
param Arekstur {s in Stokkur}:= sum{k in Nemi} Bin[k,s];

#printf "" > "lidur_c.txt";
#printf{s in Stokkur}: "%d ", Arekstur[s] >> "lidur_c.txt";
#printf "\n" >> "lidur_c.txt";
display Arekstur;#Ni�urst��ur hj� Oddi: 145 156 115 105 295 0 20 0
#%%%%




#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#D�mi fr� Tomma:
#�treikningur � �rekstrum:
#printf " " > "lidur_c.txt";
#for {k in Nemi}
#{
#    printf {s in Stokkur: s <= 8}: "%d ",
#    sum{n in Namskeid, ell in Namsleidir: NemiSkradur[k, ell, n] == 1} V[n,s] >> "lidur_c.txt";
#    printf "\n" >> "lidur_c.txt";
#}

#Fj�ldi nema � n�mskei�i m� reikna svona:
param FjoldiNamskeid {n in Namskeid} := sum{i in Nemi, ell in Namsleidir} NemiSkradur[i, ell, n];

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#display Arekstrar;


#display V;
display EftirHadegi;

end;
