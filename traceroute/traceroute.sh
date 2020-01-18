#!/bin/bash

sites=(
"www.iutbeziers.fr"
"www.nimes-metropole.fr"
"www.alliancetelecom.fr"
)

color=(
"gold"
"purple"
"blue"
"fin"
)

ttl=1
nb=0
recurrence=""
for cible in "${sites[@]}"; ##Passage sur chaque site##
  do
  maxttl=$(traceroute -q 1 -n $cible | sed "1d" | wc -l)
  >./traceroute.rte/$cible.rte  ##J'enlève le contenu de mon fichier cible.rte
  echo "$cible"
  while (("$ttl" <= "$maxttl"));
     do
     for option in "-T" "-I" "-U" "-U -p 53" "-T -p 443" "-T -p 80" "-T -p 25" "-T -p 22";  ##Chaque option pour ma commande traceroute
	     do
	     tracert=$(traceroute -A -q 1 -n -f $ttl -m $ttl $option $cible | awk '{print $1,$2,$3}' | sed '1d')  ##Je garde que le ttl, l'adresse IP du routeur, et l AS
	     adresse=$(echo "$tracert" | awk '{print $2}')  ##Je garde que l'adresse IP du routeur
		if [ "$adresse" == "*" ];  ##Je compare l'adresse IP du routeur avec une étoile
		then
			if [ "$option" == "-T -p 22" ];  ##Dans le cas où j'ai encore une étoile même après être passée par toutes les options
		        then
				echo "->">>./traceroute.rte/$cible.rte  ##Mise en forme du fichier cible.rte pour ensuite l'utiliser dans le .dot
				echo "\"Routeur $ttl introuvable pour $cible\"">>./traceroute.rte/$cible.rte
				echo "Routeur $ttl introuvable"
				echo "$ttl" >> ./ttlintrouvable.txt  ##Je rentre le ttl actif dans mon fichier ttlintrouvable pour l'utiliser après dans mon fichier .dot
			fi
		else 
			if [ "$adresse" != "$recurrence" ];  ##S il n y a pas d étoile, je vérifie que ca e soit pas la même adresse qeue celle du ttl d avant 
			then
			  echo "$tracert"
			  echo "->">>./traceroute.rte/$cible.rte
              echo "\"$tracert\"">>./traceroute.rte/$cible.rte
			  break
			else
			  break
			fi
		 fi
         done
	 recurrence=$adresse
     ttl=$(($ttl+1))  ##J'incrémente mon ttl pour ma boucle while
  done
     ttl=1  ##Une fois le ttl max atteint, je remet mon ttl à 1 pour passer à mon 2eme site
	 echo "[color=${color[$nb]}]">>./traceroute.rte/$cible.rte ##Je définis la couleur pour ma flèche
	 nb=$(($nb+1))
	 if [ ${color[$nb]} == "fin" ];  ##Si la couleur est égale à fin, je recommence ma liste au début
	 then
	     nb=0
	 fi
	 for line in $(cat ttlintrouvable.txt);   ##Mise en forme de mon .dot pour avoir des carrés lorsque mon routeur est introuvable 
	     do
	 	 echo "\"Routeur $line introuvable pour $cible\" [shape=box]">>./traceroute.rte/$cible.rte
	     done
	 >./ttlintrouvable.txt	 
done
./xdot.sh	###Je lance le script qui permet de créer mon .dot
