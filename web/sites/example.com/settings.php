<?php

$env = getenv('PHAPP_ENV');
$env_type = getenv('PHAPP_TYPE');
$env_mode = getenv('PHAPP_ENV_MODE');

// A site-specific prefix variable that can be used during configuration.
$site_prefix = 'def';
$site = 'default';

// Add in shared based settings and optionally environment specific settings.
require __DIR__ . '/../all/base.settings.php';

// Add in per-env-type settings if existing.
if (file_exists(__DIR__ . '/../all/base-' . $env_type . '.settings.php')) {
  require __DIR__ . '/../all/base-' . $env_type . '.settings.php';
}
// Add in per-env settings if existing.
if (file_exists(__DIR__ . '/../all/env.' . $env . '.settings.php')) {
  require __DIR__ . '/../all/env.' . $env . '.settings.php';
}
// Add in setting-overrides per environment mode (development or production).
if (file_exists(__DIR__ . '/../'. $env_mode . '.settings.php')) {
  require __DIR__ . '/../'. $env_mode . '.settings.php';
}
$settings['install_profile'] = 'thunder';
