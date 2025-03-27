#!/bin/bash
set -e

# Sécurité : éviter de lancer ça en staging/prod
if [[ "$ENV" == "prod" || "$ENV" == "staging" ]]; then
  echo "❌ Ce script ne doit pas être exécuté en production/staging."
  exit 1
fi

# Variables
SITE_URL="http://localhost:8080"
SITE_TITLE="Starter Dev Site"
ADMIN_USER="admin"
ADMIN_PASSWORD="admin"
ADMIN_EMAIL="admin@example.com"

echo "🚀 Installation de WordPress..."
wp core install \
  --url="$SITE_URL" \
  --title="$SITE_TITLE" \
  --admin_user="$ADMIN_USER" \
  --admin_password="$ADMIN_PASSWORD" \
  --admin_email="$ADMIN_EMAIL"

echo "🎨 Activation du thème..."
wp theme activate theme-headless

echo "🔌 Activation des plugins..."
wp plugin activate starter-api

echo "📝 Création de contenu fictif..."
wp post create --post_title="Bienvenue" --post_status=publish
wp post create --post_title="Notre mission" --post_status=publish
wp post create --post_title="Contactez-nous" --post_status=publish

echo "💾 Export du dump de base..."
wp db export dump/dev-anon.sql
gzip -f dump/dev-anon.sql

echo "✅ Site initialisé + dump généré."
