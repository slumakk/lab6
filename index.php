<html>
<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>База даних</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Структура бази даних agency</h1>
<img src="db.png" alt="">

<ul>

    <?php

    include "databaseConnect.php";

    try {
        $stmt = $pdo->query("show tables");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            printf("<li><a href='show.php?table=%s'>Таблиця %s</a></li>", $row['Tables_in_agency'], $row['Tables_in_agency']);
        };
        
        printf("</table>");
    } catch (PDOException $e) {
        die("Помилка запиту: " . $e->getMessage());
    }

    ?>
</ul>

<h2>Запити</h2>
<ul>
    <?php 
    
    include "custom_queries.php";

    foreach ($custom_queries as $key => $value) {
        printf("<li><a href='showQuery.php?query_id=%s'>%s</a></li>", $key, $value['description']);
    }

    ?>
</ul>
   
</body>
</html>
