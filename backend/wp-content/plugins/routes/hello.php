<?php

register_rest_route('starter/v1', '/hello', [
    'methods'  => 'GET',
    'callback' => function () {
        return [
            'message' => '👋 Hello depuis le Starter Plugin !'
        ];
    },
    'permission_callback' => '__return_true' // ⚠️ Dev uniquement, à sécuriser si besoin
]);