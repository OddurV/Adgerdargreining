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