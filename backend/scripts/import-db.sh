#!/bin/bash

set -e

# Charger les variables d'environnement depuis .env
ENV_FILE="../.env"
if [ -f "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
else
  echo "❌ Fichier .env non trouvé dans backend/.env"
  exit 1
fi

# Valeurs par défaut si variables absentes
DB_CONTAINER_NAME=${DB_CONTAINER_NAME:-mysql_db}
DB_NAME=${DATABASE:-wordpress}
DB_USER=${USER:-wpuser}
DB_PASSWORD=${PASSWORD:-wppass}
DUMP_PATH=${DUMP_PATH:-dump/dev-anon.sql.gz}

# Vérifications de base
if [ ! -f "$DUMP_PATH" ]; then
  echo "❌ Fichier dump introuvable à l'emplacement : $DUMP_PATH"
  exit 1
fi

echo "📦 Import de la base de données anonymisée dans '$DB_NAME' sur '$DB_CONTAINER_NAME'..."
gunzip -c "$DUMP_PATH" | docker exec -i "$DB_CONTAINER_NAME" mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME"
echo "✅ Base importée avec succès."