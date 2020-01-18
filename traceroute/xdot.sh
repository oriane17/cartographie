#!/bin/bash
echo "digraph grapheTR {" > carto.dot ##Mise en forme de mon fichier carto.dot
for fichier in $(ls *.rte)  ##Je récupère chaque fichier .rte contenant chaque route pour le mettre en forme
do
  
  echo "localhost" >> carto.dot
  forme=$(cat traceroute.rte/$fichier | tr '\n' ' ')
  echo "$forme">>carto.dot
  echo ";" >> carto.dot
done
echo "}" >> carto.dot

dot -Tpdf carto.dot -o carto.pdf  ##Je convertis mon fichier carto.dot en pdf
