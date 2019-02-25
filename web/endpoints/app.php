<?php

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
require '../includes/DbOperations.php';

$app->get('/', function (Request $request, Response $response) {

    $data = [
        'app' => 'SimpleVet'
    ];

    return $response->withJson($data, 200);
});

$app->get('/animais', function (Request $request, Response $response) {
    $db =  new DbOperations;
    $animals = $db->getAllAnimals();
    echo($animals);
    if($animals) {
        return $response;
    }
    return $response->withJson($animals, 400);

    
});

$app->get('/racas', function (Request $request, Response $response) {
    $params = $request->getQueryParams();
    $db =  new DbOperations;
    $especie_cod = array_key_exists('especie_cod',$params) ? $params['especie_cod'] : null;
    $situacao = array_key_exists('situacao',$params) ? $params['situacao'] : null;
    $racas = $db->getAllRacas($situacao,$especie_cod);
    if($racas) {
        return $response->withJson($racas, 200);
    }
    $error = [""];
    return $response->withJson($racas, 400);

    
});


$app->post('/animais', function (Request $request, Response $response) {
    $body = json_decode($request->getBody());
    $db = new DbOperations;
    $pet = $db->postAnimal($body);
    return $response->withJson($pet, 200);


});

