# Déploiement Azure Static Website avec Terraform

Ce setup Terraform déploie une infrastructure Azure pour héberger un site web statique via un Storage Account avec activation de la fonctionnalité `Static Website`, ainsi que l’upload de blobs configurés.

## Fonctionnalités

- Création d’un Resource Group Azure

- Génération d’un nom de Storage Account unique en cas d’absence de nom explicite

- Provisionnement d’un Storage Account Azure avec paramètres personnalisables (Tier, réplication)

- Activation du service Static Website sur le Storage Account

- Upload dynamique de fichiers blob dans le container `$web` pour héberger les fichiers du site

- Gestion flexible des tags pour l’ensemble des ressources

- Validation des variables d’input avec restrictions (ex : fichiers index et error doivent être des .html)

## Prérequis

- Terraform >= 1.0

- Un abonnement Azure avec les droits nécessaires à la création de ressources

- Azure CLI configuré et authentifié (pour terraform apply)

## Variables

| Variable               | Type                 | Description                                                    | Exemple                                                       |
| ---------------------- | -------------------- | -------------------------------------------------------------- | ------------------------------------------------------------- |
| `resource_group_name`  | `string`             | Nom du groupe de ressources                                    | `"test-resource-group"`                                       |
| `location`             | `string`             | Région Azure où déployer                                       | `"West Europe"`                                               |
| `tags`                 | `string`             | Tag d’environnement principal                                  | `"Prod"`                                                      |
| `global_tags`          | `map(string)`        | Tags globaux ajoutés à toutes les ressources                   | `{ "Department" = "IT" }`                                     |
| `account_type`         | `map(string)`        | Configuration du Storage Account (Tier et réplication)         | `{ "account_tier" = "Standard", "replication_type" = "LRS" }` |
| `storage_account_name` | `string` (optionnel) | Nom du Storage Account. Si vide, un nom généré automatiquement | `""`                                                          |
| `error_file`           | `string`             | Nom du fichier 404 (doit être `.html`)                         | `"404.html"`                                                  |
| `index_file`           | `string`             | Nom du fichier index (doit être `.html`)                       | `"index.html"`                                                |
| `blob_storage`         | `map(object)`        | Dictionnaire des blobs à uploader                              | Voir ci-dessous                                               |

Exemple de variable `blob_storage`

    blob_storage = {
    "blob1" = {
     name                   = "index.html"
     storage_container_name = "$web"
     type                   = "Block"
     content_type           = "text/html"
     source                 = "index.html"
     }

    "blob2" = {
     name                   = "404.html"
     storage_container_name = "$web"
     type                   = "Block"
     content_type           = "text/html"
     source                 = "404.html"
    }
    }

## Utilisation

Cloner ce dépôt

git clone <URL>
cd <repo>

Initialiser Terraform

terraform init

Vérifier la planification

terraform plan 

Remarques
Le nom du Storage Account est en minuscules, sans caractères spéciaux ni tirets, et doit être globalement unique.

Les fichiers .html doivent être présents dans le dossier local pour le chargement correct des blobs.

En cas de nom de Storage Account déjà pris, un suffixe aléatoire sera généré automatiquement.

Les blobs sont automatiquement uploadés dans le container $web nécessaire pour l’hébergement statique.

Auteur
Ton Nom — LinkedIn | GitHub