# PARTICIPATION MEMBRES EQUIPE

## TABLEAU DE SYNTHESE SAÉ 1.03 - PHASE B

Temps total : entre 15h et 20h 

| Membre    | %   |                                                    
| --------- | --- | 
| Evan      | 40  | 
| Rodolphe  | 20  | 
| Eloi      | 20  | 
| Elie      | 20  |                        

## TÂCHE : ETAPE B-1 - CHAÎNE DE TRAITEMENT

**Responsable principal :** Evan

**Fichiers produits :**
- `script_depts.sh` : Traitement des données CSV (suppression en-têtes, ajout départements manquants, tri)
- `script_run_docker.sh` : automatisation des tâches de la chaîne avec Docker

**Contributions :**
- Evan, Eloi : Développement des scripts Bash, conversion Excel en CSV
- Evan : gestion de Docker 
- Rodolphe, Elie : Tests et validation des résultat des scripts et on aider dans le developpement des scripts notamment

## TÂCHE : ETAPE B-2 - GÉNÉRATION DES PDFs

## DIFFICULTÉS RENCONTRÉES

### Problème 1 : Fichier sites-visites.csv vide
**Description :** La commande sort ne produisait aucun résultat, le fichier restait vide

**Solution :** Incompatibilité des options -n et -V dans la commande sort, Remplacement de -V par -n pour le tri numérique de la colonne département : sort -t ',' -k4,4 -rn -k2,2n

**Résolu par :** Evan, eloi et Elie

### Problème 2 : Tri par visiteurs avec départage
**Description :** Nécessité de trier par visiteurs décroissant puis par code département croissant

**Solution :** Utilisation de deux clés de tri : `-k4,4 -rn` (visiteurs décroissant) puis `-k2,2n` (département croissant)

**Résolu par :** Evan et Eloi

### Problème 3 : difficulté de mise en page pour les PDF sur une seule page :

**Description :** Beaucoup de mal à générer les pdf sur une seul page, les tableaux s'etendait sur plusieurs pages, et le logo et le titre s'affichait sur une page chacun, ce qui rendait un pdf de 3 voir 4 pages en tout.

**Solution :** Mettre le format de page en css en format A4 avec "landscape" pour mettre en format paysage, ce qui nous a permis d'afficher une seul page de PDF avec le tableau, le logo et le titre