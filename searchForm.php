<html>

<?php 
    include "parse_url.php";
?>

<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>Пошук значення</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Пошук значення в таблиці <?php printf($tableName) ?></h1>

    <h2>Виберіть рядок, за яким будете шукати значення:</h2>

    <?php 
        include "isForeign.php";

        // склади форму з вибором ід яка буде оброблятися всередині
        printf('<form method="POST" action="">');
        
        // склади запит який отримує список всіх ід <select> <option>
        $stmt = $pdo->query("SHOW FULL COLUMNS FROM $tableName");
        printf("<label for='name'>Назва колонки</label>");
        printf("<select name='name' required>");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            printf("<option value='%s'>%s | %s</option>", $row['Field'], $row['Field'], $row['Comment']);
        }
        printf('<input type="text" name="value" placeholder="Частина значення">');
        // додай кнопку submit і закрий тег <select>
        printf('</select><button type="submit">Знайти рядок</button></form>');

    ?>

    <?php

    $col = $_POST['name'];
    $value = $_POST['value'];
    if (isset($col) && !empty($col)) {
        $search = "%" . $value . "%";
        $stmt = $pdo->prepare("SELECT * FROM $tableName WHERE $col LIKE :search");
        $stmt->bindParam(':search', $search);
        $stmt->execute();

        $count = $stmt->rowCount();

        if ($count > 0) {
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
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                printf("<tr>");
                foreach ($row as $value) {
                    printf("<td>%s</td>", $value);
                }
                printf("</tr>");
            }
            printf("</table>");
        } else {
            echo "Немає результатів для вашого запиту.";
        }
    }
    ?>

    <br><br><br>

    <ul>
        <li><a href="./">На головну</a><br></li>
    </ul>


</body>

</html>