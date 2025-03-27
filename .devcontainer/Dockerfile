FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Installer outils
RUN apt-get update && apt-get install -y \
    curl \
    make \
    zip \
    unzip \
    less \
    php-cli php-mysql php-curl php-xml

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Installer Node.js + npm pour Vite
RUN curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install -y nodejs
