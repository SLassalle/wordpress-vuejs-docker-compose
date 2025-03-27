<?php
/*
Plugin Name: Starter API Plugin
Description: Plugin de base pour créer des routes API REST personnalisées dans un projet headless.
Version: 1.0
Author: Équipe DevOps
*/

if (!defined('ABSPATH')) exit; // Sécurité : accès direct interdit

// Charger les routes API custom
add_action('rest_api_init', function () {
    require_once __DIR__ . '/routes/hello.php';
});