#!/bin/sh

set -e

echo "⬇️ Téléchargement de WordPress si nécessaire..."
if ! wp core is-installed; then
  echo "⬇️ Téléchargement de WordPress..."
  wp core download --quiet
fi

echo "🔧 Configuration du fichier wp-config.php..."
if [ ! -f wp-config.php ]; then
  echo "🔧 Configuration du fichier wp-config.php..."
  wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" --quiet --skip-check
fi


echo "🚀 Installation de WordPress..."
wp core install \
  --url="http://localhost:8080" \
  --title="Headless WP" \
  --admin_user="admin" \
  --admin_password="admin" \
  --admin_email="admin@example.com" \
  --skip-email \
  --quiet

echo "🧹 Configuration minimale..."
wp rewrite structure '/%postname%/' --hard --quiet
wp rewrite flush --hard --quiet

echo "🎨 Activation du thème headless..."
wp theme activate theme-headless --quiet

if ! wp plugin is-active starter-api; then
  wp plugin activate starter-api --quiet
fi

echo "✅ WordPress headless prêt à l’emploi."
