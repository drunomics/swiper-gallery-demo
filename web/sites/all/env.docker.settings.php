<?php

/**
 * @file
 * Some settings.php defaults that get included depending on the active environment.
 */

$settings['trusted_host_patterns'][] = '^(.+\.)?swiper-gallery-demo.local';

// Default database connection.
$databases['default']['default'] = array(
  'database' => 'swiper_gallery_demo_' . $site_prefix,
  'username' => 'root',
  'password' => '',
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);

$settings['file_chmod_directory'] = octdec(2770);
