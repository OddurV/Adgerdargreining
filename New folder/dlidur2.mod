#�etta markfall virkar �annig a� �a� leggur saman �ll n�mskei�in sem lenda � �skilegum stokki og margfaldar 
#�� summu me� st�rum fasta, svo dregur �a� fr� summu �eirra n�mskei�a sem lenda eftir h�degi e�a utan stokka 
#(�a� er l�ka h�gt a� setja fasta � �a� til a� gera �a� mikilv�gara)
#Me� �v� a� fikta � �essum f�stum er h�gt a� f� mismunandi ni�urst��ur
maximize AEskilegSkipting: (sum{m in Misseri, n in Namskeid: NamskeidStokkur[n]>0} if NamskeidMisseri[n]==2 then 10000*V[n,NamskeidStokkur[n]] else V[n,NamskeidStokkur[n]])-100*sum{n in Namskeid, s in Stokkur: s>5} V[n,s];

solve;
#Fj�ldi n�mskei�a sem lenda � �skilegum stokki � hverju misseri fyrir sig (Ath �a� eru bara 82 n�mskei� me� skilgreindan upp�haldsstokk)
param AEskilegSkiptingPerMisseri {m in Misseri}:= sum{n in Namskeid: NamskeidStokkur[n]>0} if V[n,NamskeidStokkur[n]]==1 and NamskeidMisseri[n]==m then 1 else 0;
#display V;
param EftirHadegi := sum{n in Namskeid, s in Stokkur: s>5} V[n,s];#Hversu m�rg n�mskei� eru eftir h�degi e�a utan stokka
display EftirHadegi;
display AEskilegSkiptingPerMisseri;#hversu m�rg n�mskei� lenda � �skilegum stokki