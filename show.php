<?php 
    include "parse_url.php";
?>

<html>

<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>Таблиця <?php printf($tableName); ?></title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Таблиця <?php printf($tableName); ?></h1>

    <?php

    try {

        $stmt = $pdo->query("SELECT * FROM $tableName");
        $stmtCom = $pdo->query("SHOW FULL COLUMNS FROM $tableName");
        printf("<table><tr>");

        while ($row = $stmtCom->fetch(PDO::FETCH_ASSOC)) {
            if($row['Comment'] == '') {
                $value = $row['Field'];    
            }
            else {
                $value = $row['Comment'];
            }

            printf("<th>%s</th>", $value);
        }
        printf("</tr>");
        $stmt->execute();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            printf("<tr>");
            foreach ($row as $value) {
                printf("<td>%s</td>", $value);
            }
            printf("</tr>");
        }
        printf("</table>");
    } catch (PDOException $e) {
        die("Помилка запиту: " . $e->getMessage());
    }

    ?>

    <br>

    <ul>
        <li><a href="searchForm.php?table=<?php printf($tableName) ?>">Пошук значення</a><br></li>
        <li><a href="insertForm.php?table=<?php printf($tableName) ?>">Вставити рядок</a><br></li>
        <li><a href="updateForm.php?table=<?php printf($tableName) ?>">Змінити рядок</a><br></li>
        <li><a href="deleteForm.php?table=<?php printf($tableName) ?>">Видалити рядок</a><br></li>
        <li><a href="./">На головну</a><br></li>
    </ul>

</body>

</html>