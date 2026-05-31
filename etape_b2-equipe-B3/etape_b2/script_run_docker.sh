#!/usr/bin/bash

# Etape 1 : Chaîne de traitement 

# Création d'une variable pour le nom du conteneur
NOM_CONTENEUR="etapeB2"

# On nettoie au cas où des anciens conteneurs sont encore en marche
docker rm -f $NOM_CONTENEUR

# 1. Lancer le conteneur
docker run -d --name $NOM_CONTENEUR --rm bigpapoo/sae103-php:latest sleep infinity

# Installer ssconvert (gnumeric) dans le conteneur afin de pouvoir convertir l'Excel
docker exec $NOM_CONTENEUR bash -c "apt-get update && apt-get install -y gnumeric"

# 2. Copier les fichiers nécessaires pour le traitement bash
docker cp "sites_touristiques_france_v2.xlsx" $NOM_CONTENEUR:/tmp/
docker cp "script_depts.sh" $NOM_CONTENEUR:/tmp/
docker cp "DEPTS" $NOM_CONTENEUR:/tmp/

# 3. Convertir le fichier Excel en CSV
docker exec $NOM_CONTENEUR bash -c "cd /tmp && ssconvert sites_touristiques_france_v2.xlsx sites_touristiques.csv"

# 4. Lancer le traitement bash
docker exec $NOM_CONTENEUR bash -c "cd /tmp && bash script_depts.sh"

# 5. Récupérer les fichiers CSV générés
docker cp $NOM_CONTENEUR:/tmp/sites_touristiques.csv ./sites_touristiques.csv
docker cp $NOM_CONTENEUR:/tmp/sites_touristiques_sans_entete.csv ./sites_touristiques_sans_entete.csv
docker cp $NOM_CONTENEUR:/tmp/sites_touristiques_complets.csv ./sites_touristiques_complets.csv
docker cp $NOM_CONTENEUR:/tmp/sites-dept.csv ./sites-dept.csv
docker cp $NOM_CONTENEUR:/tmp/sites-visites.csv ./sites-visites.csv

# 6. Copier les fichiers pour la génération des PDFs
docker cp "generateur_sites_dept.php" $NOM_CONTENEUR:/tmp/
docker cp "generateur_sites_visites.php" $NOM_CONTENEUR:/tmp/
docker cp "generateur_sites_regions.php" $NOM_CONTENEUR:/tmp/
docker cp "Logo_office_tourisme.png" $NOM_CONTENEUR:/tmp/
docker cp "REGIONS" $NOM_CONTENEUR:/tmp/

# 7. Copier les fichiers CSV générés dans le conteneur
docker cp "sites-dept.csv" $NOM_CONTENEUR:/tmp/
docker cp "sites-visites.csv" $NOM_CONTENEUR:/tmp/
docker cp "sites_touristiques_complets.csv" $NOM_CONTENEUR:/tmp/

# Etape 2 : Générer les 3 PDFs

# 1. Générer le HTML pour le fichier sites-dept
docker exec -w /tmp $NOM_CONTENEUR php generateur_sites_dept.php > sites_touristiques_dept.html

# 2. Convertir HTML en PDF pour le fichier sites-dept
docker run --rm -v "$(pwd):/data" bigpapoo/sae103-html2pdf:latest weasyprint /data/sites_touristiques_dept.html /data/sites-dept.pdf

# 3. Générer le HTML pour le fichier sites-visites
docker exec -w /tmp $NOM_CONTENEUR php generateur_sites_visites.php > sites_touristiques_visites.html

# 4. Convertir HTML en PDF pour le fichiersites-visites
docker run --rm -v "$(pwd):/data" bigpapoo/sae103-html2pdf:latest weasyprint /data/sites_touristiques_visites.html /data/sites-visites.pdf

# 5. Générer le HTML pour le fichier sites-regions
docker exec -w /tmp $NOM_CONTENEUR php generateur_sites_regions.php > sites_touristiques_regions.html

# 6. Convertir HTML en PDF pour le fichier sites-regions
docker run --rm -v "$(pwd):/data" bigpapoo/sae103-html2pdf:latest weasyprint /data/sites_touristiques_regions.html /data/sites-regions.pdf

# 7. Arrêter le conteneur
docker stop $NOM_CONTENEUR

echo "✓ Les 3 PDFs sont générés !"