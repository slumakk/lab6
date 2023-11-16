<?php 
    include "databaseConnect.php";
?>

<html>

<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>Таблиця за запитом</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Таблиця за запитом</h1>

    <?php
    include "custom_queries.php";

    $queries = array();
    $queryString = $_SERVER['QUERY_STRING'];
    parse_str($queryString, $queries);
    $queryID = $queries['query_id'];
    $result = false;

    if (isset($queryID)) { 
        try {
            if (array_key_exists($queryID, $custom_queries)) {
                $result = true;

                printf("<p><b>Запит:</b> %s</p>", $custom_queries[$queryID]['query']);
                printf("<p><b>Опис:</b> %s</p>", $custom_queries[$queryID]['description']);

                $query = $pdo->query($custom_queries[$queryID]['query']);
                $row1 = $query->fetch(PDO::FETCH_ASSOC);
                $rowKeys = array_keys($row1);
                $rowValues = array_values($row1);

                printf("<table><tr>");
                foreach ($rowKeys as $key) {
                    printf("<th>%s</th>", $key);
                }
                printf("</tr>");
                foreach ($rowValues as $value) {
                    printf("<td>%s</td>", $value);
                }
                printf("</tr>");

                while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
                    printf("<tr>");
                    foreach ($row as $value) {
                        printf("<td>%s</td>", $value);
                    }
                    printf("</tr>");
                }
                printf("</table>");
            }
        } catch (PDOException $e) {
            die("Помилка запиту: " . $e->getMessage());
        }
    }

    if($result === false) {
        header("Location: ./");
        exit;
    }

    ?>

    <br>

    <ul>
        <?php 
        
        include "custom_queries.php";

        foreach ($custom_queries as $key => $value) {
            printf("<li><a href='showQuery.php?query_id=%s'>%s</a></li>", $key, $value['description']);
        }

        ?>
        <li><a href="./">На головну</a><br></li>
    </ul>

</body>

</html>