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