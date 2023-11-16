<?php

$custom_queries = array(
    0 => array(
        'description' => 'Середня вартість типів нерухомості в області',
        'query' => "SELECT region AS 'Область' , type AS 'Тип нерухомості', ROUND(AVG(price)) AS 'Середня ціна' FROM properties INNER JOIN properties_types ON properties.type_id = properties_types.id GROUP BY type, region",        
    ),
    1 => array(
        'description' => 'Клієнти, які купили нерухомість та кількість куплених ними об\'єктів',
        'query' => "SELECT
            clients.name AS 'Ім\'я',
            clients.surname AS 'Прізвище',
            clients.patronymic AS 'По батькові',
            COUNT(agreements.property_id) AS 'Кількість куплених об\'єктів'
            FROM
                clients
            JOIN agreements
            ON
                clients.id = agreements.buyer_id
            GROUP BY
                clients.id
            ORDER BY
                COUNT(agreements.property_id) DESC",        
    ),

    2 => array(
        "description" => "Рієлтори, хто найбільше продав нерухомості",
        "query" => "SELECT
            realtors.name AS 'Ім\'я',
            realtors.surname AS 'Прізвище',
            realtors.patronymic AS 'По батькові',
            COUNT(agreements.property_id) AS 'Кількість проданих об\'єктів'
            FROM
                realtors
            LEFT JOIN agreements
            ON
                realtors.id = agreements.realtor_id
            GROUP BY
                realtors.id
            ORDER BY
                COUNT(agreements.property_id) DESC",
    ),

    3 => array(
        'description' => 'Квартири, які є у продажі та у яких площа більша за 50 кв. м.',
        'query' => "SELECT
            properties.id AS 'ID',
            properties.region AS 'Область',
            properties.city AS 'Місто',
            properties.address AS 'Адреса',
            properties.area AS 'Площа',
            properties.price AS 'Ціна'
            FROM
                properties
            JOIN properties_types
            ON
                properties.type_id = properties_types.id
            WHERE
                properties_types.type = 'Квартира'
            AND
                properties.area >= 50
            AND
                properties.is_active = 1",
    ),

    4 => array(
        'description' => 'Квартири, які були куплені у Києві',
        'query'=> "SELECT
            properties.id AS 'ID',
            properties.region AS 'Область',
            properties.city AS 'Місто',
            properties.address AS 'Адреса',
            properties.area AS 'Площа',
            properties.price AS 'Ціна'
            FROM
                properties
            JOIN properties_types
            ON
                properties.type_id = properties_types.id
            JOIN agreements
            ON
                properties.id = agreements.property_id
            WHERE
                properties_types.type = 'Квартира'
            AND
                properties.city = 'Київ'",
    ),

    5 => array(
        'description' => 'Список всіх угод, які були укладені у 2023 році',
        'query'=> 'SELECT
            agreements.id AS "ID",
            properties_types.type AS "Тип нерухомості",
            properties.region AS "Область",
            properties.city AS "Місто",
            properties.address AS "Адреса",
            properties.area AS "Площа",
            agreements.date AS "Дата укладання",
            agreements.price AS "Ціна",
            buyers.name AS "Ім\'я покупця",
            buyers.surname AS "Прізвище покупця",
            sellers.name AS "Ім\'я продавця",
            sellers.surname AS "Прізвище продавця",
            realtors.asnu_cert AS "Сертифікат АФНУ рієлтора"
            FROM
                agreements
            JOIN properties
            ON
                agreements.property_id = properties.id
            JOIN clients as buyers
            ON
                agreements.buyer_id = buyers.id
            JOIN clients as sellers
            ON
                agreements.seller_id = sellers.id
            JOIN realtors
            ON
                agreements.realtor_id = realtors.id
            JOIN properties_types
            ON
                properties.type_id = properties_types.id
            WHERE
                agreements.date BETWEEN "2023-01-01" AND "2023-12-31"',
    )
);

?>