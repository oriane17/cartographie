# Cartographie Internet

## Script traceroute.sh

Premier script pour lancer chaque traceroute et mettre en forme un fichier pour chaque adresse.   

|----------------------------------------------------------------------------------------------------------------------|   
| variables | utilité							      | modifiable			       |   
-----------------------------------------------------------------------------------------------------------------------|   
|sites      | liste de sites pour le traceroute				      | Oui, ajouter ou supprimer des adresses |   
|----------------------------------------------------------------------------------------------------------------------|   
|color      | liste des couleurs pour les flèches de mon graphe               | Oui, ajouter ou supprimer des couleurs |   
|----------------------------------------------------------------------------------------------------------------------|   
|ttl        | pour pouvoir passer par tous les ttl de chaque adresse          | Non				       |    
|----------------------------------------------------------------------------------------------------------------------|    
|nb         | incrémentation des couleurs				      | Non				       |    
|----------------------------------------------------------------------------------------------------------------------|     
|recurrence | contient l'adresse du ttl précédent pour éviter les recurrences | Non				       |    
|----------------------------------------------------------------------------------------------------------------------|   
|maxttl     | contient le ttl max de chaque adresse			      | Non				       |   
|----------------------------------------------------------------------------------------------------------------------|    

    
Je crée un fichier pour chaque site, contenu dans mon dossier traceroute.rte, pour ensuite le récupérer à l'aide de mon 2eme script.    
Ces fichiers contiennent les informations nécessaire pour créer ensuite ma cartographie.     
   
Ce script va lancer un traceroute sur chaque site sélectionné préalablement dans la variable "sites".    
Et il remplacera les * par une phrase.   
   
Pour finir, il lance le 2eme script, xdot.sh    
   
## Script xdot.sh
    
Ce script commence par la syntaxe nécessaire à la création d'un graphe .dot     
Il va ensuite juste prendre chaque fichier .rte créé à l'aide de mon 1er script, et enlever les retours à la ligne.    
    
On rentre tout cela dans le fichier carto.dot     
Ce fichier contenant donc toutes les routes de chaque site va ensuite être converti en pdf.      



