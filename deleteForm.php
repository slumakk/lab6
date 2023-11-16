<html>

<?php
    include "parse_url.php";
?>


<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>Видалення даних</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
<h1>Видалення даних в таблиці <?php printf($tableName); ?></h1>
<h2>Виберіть ID рядка:</h2>

<?php 
    include "isForeign.php";

    // склади форму з вибором ід яка буде оброблятися всередині
    printf('<form method="POST" action="">');
    
    // склади запит який отримує список всіх ід <select> <option>
    $stmt = $pdo->query("SELECT ID FROM $tableName");
    printf("<label for='id'>ID</label>");
    printf("<select name='id' required>");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        printf("<option value='%s'>%s</option>", $row['ID'], $row['ID']);
    }

    // додай кнопку submit і закрий тег <select>
    printf('</select><button type="submit">Вибрати</button></form>');

?>

<?php
    
    // склади вивід таблиці після вибору ід в менюшці
    // опрацюй метод пост від форм вище і виведи таблицю
    $stmt = $pdo->query('SELECT * FROM ' . $tableName . ' WHERE ID = ' . $_POST['id']);
    
    printf('<table><tr>');
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        foreach ($row as $key => $value) {
            printf('<th>%s</th>', $key);
        }
        printf('</tr><tr>');
        foreach ($row as $key => $value) {
            printf('<td>%s</td>', $value);
        }
    }
    printf('</tr></table><br>');
    
?>

<form method="POST" action="delete.php?table=<?php printf($tableName); ?>">
    <input type='hidden' name='id' value='<?php printf($_POST['id']) ?>'>
    <button type="submit">Видали рядок</button>
</form>
</body>
</html>