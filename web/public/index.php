<?php

require '../vendor/autoload.php';

$settings['displayErrorDetails'] = true;
$settings['determineRouteBeforeAppMiddleware'] = true;

$app = new \Slim\App(["settings" => $settings]);

require '../config.php';
require '../endpoints/app.php';

$app->run();
