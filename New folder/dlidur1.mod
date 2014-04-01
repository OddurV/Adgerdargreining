#Li�ur D
#Fyrri hluti
#�etta markfall virkar �annig a� �a� leggur saman �ll n�mskei�in sem lenda � �skilegum stokki, og dregur svo fr� 
#summu �eirra n�mskei�a sem lenda eftir h�degi e�a utan stokka
maximize AEskilegSkipting: (sum{n in Namskeid: NamskeidStokkur[n]>0} V[n,NamskeidStokkur[n]])-sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

solve;
#Fj�ldi n�mskei�a sem lenda � �skilegum stokki � hverju misseri fyrir sig (Sanity check: �a� eru bara 82 n�mskei� me� skilgreindan upp�haldsstokk, �annig a� summa �essara �riggja talna getur ekki veri� st�rri en 82)
param AEskilegSkiptingPerMisseri {m in Misseri}:= sum{n in Namskeid: NamskeidStokkur[n]>0} if V[n,NamskeidStokkur[n]]==1 and NamskeidMisseri[n]==m then 1 else 0;
#display V;
param EftirHadegi := sum{n in Namskeid, s in Stokkur: s>5} V[n,s];
display EftirHadegi;#Hversu m�rg n�mskei� eru eftir h�degi e�a utan stokka
display AEskilegSkipting;
display AEskilegSkiptingPerMisseri;