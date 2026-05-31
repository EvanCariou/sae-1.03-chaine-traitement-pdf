# Chaîne de traitement & génération de PDF (SAÉ 1.03)

## 📋 Description

Pipeline automatisé pour le traitement de données touristiques. Le système ingère des fichiers CSV contenant des sites touristiques, procède au nettoyage des données, à un tri multi-critères (note, prix, popularité), enrichit les informations et génère des documents PDF formatés. L'ensemble est orchestré via des scripts Bash et conteneurisé avec Docker pour une reproductibilité maximale.

## 🛠️ Technos

- **Bash** – Scripts d'orchestration et automatisation
- **Docker** – Conteneurisation et environnement reproductible
- **PHP** – Traitement et enrichissement des données
- **CSV** – Format d'entrée des données

## 📚 Compétences travaillées

- **C3 – Administrer des systèmes communicants**
  - Gestion d'une pipeline de traitement automatisée
  - Orchestration via conteneurs Docker

- **C5 – Conduire un projet**
  - Architecture et planification d'une chaîne de traitement
  - Documentation et suivi du pipeline

- **C6 – Collaborer en équipe**
  - Scripts partagés et reproductibles
  - Documentation technique pour faciliter la collaboration

## 🚀 Installation / Utilisation

### Prérequis
- Docker et Docker Compose
- Bash (Linux/macOS) ou WSL (Windows)

### Lancement avec Docker
```bash
docker build -t sae-1.03 .
docker run -v $(pwd)/data:/app/data sae-1.03
```

### Ou directement via Bash
```bash
./pipeline.sh input.csv output/
```

### Flux du pipeline
1. **Ingestion** : Lecture du fichier CSV d'entrée
2. **Nettoyage** : Suppression des doublons, formatage
3. **Enrichissement** : Appels API externes pour compléter les données
4. **Tri** : Classement selon plusieurs critères
5. **Génération PDF** : Création des documents finalisés

## 👤 Auteur

**Evan Cariou** – Année 1 BUT Informatique (2025-2026)
