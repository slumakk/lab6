<?php

$custom_queries = array(
    0 => array(
        'description' => 'Всі результати експериментів, в яких використовувалася вода',
        'query' => "SELECT results.id, results.obtained_data, results.description
        FROM results
        JOIN results_chemicals
        ON results.id = results_chemicals.result_id
        JOIN chemicals
        ON results_chemicals.chemical_id = chemicals.id
        WHERE chemicals.chemical_composition = 'H2O';
        ",        
    ),

    1=> array(
        "description" => "Всі експерименти, які проводилися в 2023 році.",
        "query"=> "SELECT
        experiments.id,
        experiments.date,
        experiments.description
    FROM
        experiments
    WHERE
        experiments.date BETWEEN '2023-01-01' AND '2023-12-31';
    ",
    ),
);
?>