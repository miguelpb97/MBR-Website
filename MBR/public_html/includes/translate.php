<?php
// includes/translate.php

const LANGUAGES = [
    'es' => ['label' => 'Español', 'flag' => 'fi-es', 'html' => 'es-ES'],
    'en' => ['label' => 'English', 'flag' => 'fi-gb', 'html' => 'en-US'],
    'fr' => ['label' => 'Français', 'flag' => 'fi-fr', 'html' => 'fr-FR'],
    'de' => ['label' => 'Deutsch',  'flag' => 'fi-de', 'html' => 'de-DE'],
    'it' => ['label' => 'Italiano', 'flag' => 'fi-it', 'html' => 'it-IT'],
];

function get_available_languages(): array
{
    return array_keys(LANGUAGES);
}

function lang_info(string $lang, string $key): string
{
    return LANGUAGES[$lang][$key] ?? LANGUAGES['es'][$key];
}

function detect_language(): string
{
    $available = get_available_languages();
    $default = 'es';

    if (isset($_GET['lang']) && in_array($_GET['lang'], $available, true)) {
        $lang = $_GET['lang'];
        setcookie('site_lang', $lang, time() + (86400 * 365), '/');
        return $lang;
    }

    if (isset($_COOKIE['site_lang']) && in_array($_COOKIE['site_lang'], $available, true)) {
        return $_COOKIE['site_lang'];
    }

    if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
        $browser_lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
        if (in_array($browser_lang, $available, true)) {
            return $browser_lang;
        }
    }

    return $default;
}

function load_translations(string $lang): array
{
    $file = __DIR__ . "/../lang/{$lang}.json";
    if (!file_exists($file)) {
        $file = __DIR__ . "/../lang/es.json";
    }
    $json = file_get_contents($file);
    return json_decode($json, true) ?? [];
}

function t(string $key): string
{
    global $translations;
    return $translations[$key] ?? $key;
}

// Como t(), pero permite insertar HTML (enlaces, etc.) mediante placeholders.
// Los valores del array de reemplazo SÍ pueden llevar HTML;
// el texto base de la traducción se trata como texto plano.
function t_html(string $key, array $replacements = []): string
{
    global $translations;
    $text = $translations[$key] ?? $key;
    return strtr($text, $replacements);
}
