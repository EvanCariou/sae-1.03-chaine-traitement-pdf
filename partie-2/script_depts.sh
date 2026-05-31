#!/usr/bin/bash

# Etape 1 : Supprimer les entêtes
tail -n +4 < sites_touristiques.csv > sites_touristiques_sans_entete.csv

# Etape 2 : Créer une copie vide
> sites_touristiques_complets.csv

# Etape 3 : On boucle sur les départements de 1 à 95
for num in $(seq 1 95)
do
    # On récupère le nom du département dans le fichier DEPTS
    depts_nom=$(sed -n "${num}p" DEPTS)
    
    # On cherche si ce département a déjà des sites dans le fichier d'origine
    if grep -q ",$num," sites_touristiques_sans_entete.csv
    then
        grep ",$num," sites_touristiques_sans_entete.csv | sed "s/,$num,/,$num,$depts_nom,/g" >> sites_touristiques_complets.csv
    else
        echo ",$num,$depts_nom,0" >> sites_touristiques_complets.csv
    fi
done

# Gestion de la Corse 
# Corse 2A
if grep -q ",2A," sites_touristiques_sans_entete.csv
then
    grep ",2A," sites_touristiques_sans_entete.csv | sed "s/,2A,/,2A,Corse-du-Sud,/g" >> sites_touristiques_complets.csv
else
    echo ",2A,Corse-du-Sud,0" >> sites_touristiques_complets.csv
fi

# Corse 2B
if grep -q ",2B," sites_touristiques_sans_entete.csv
then
    grep ",2B," sites_touristiques_sans_entete.csv | sed "s/,2B,/,2B,Haute-Corse,/g" >> sites_touristiques_complets.csv
else
    echo ",2B,Haute-Corse,0" >> sites_touristiques_complets.csv
fi

# Etape 4 : Créer les 3 fichiers triés différemment

# 1. sites-dept.csv : Tri par numéro de département (croissant)
sort -t ',' -k2,2 -V sites_touristiques_complets.csv > sites-dept.csv

# 2. sites-visites.csv : Tri par visiteurs (décroissant)

sort -t ',' -k4,4 -rn -k2,2n sites_touristiques_complets.csv > sites-visites.csv

# 3. sites-dept.csv devient sites_touristiques_final.csv
cp sites-dept.csv sites_touristiques_final.csv