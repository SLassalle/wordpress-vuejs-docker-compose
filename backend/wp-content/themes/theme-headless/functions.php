<?php
// Désactiver l'affichage front
add_action('template_redirect', function () {
    if (!is_admin()) {
        status_header(403);
        exit('Ce site utilise une API headless. Aucun front ici.');
    }
});