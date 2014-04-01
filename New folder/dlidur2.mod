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
display AEskilegSkiptingPerMisseri;#hversu mörg námskeið lenda í æskilegum stokki