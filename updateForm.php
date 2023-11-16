<html>

<?php
    include "parse_url.php";
?>

<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>Оновлення даних</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<h1>Оновлення даних в таблиці <?php printf($tableName); ?></h1>
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

<form method="POST" action="update.php?table=<?php printf($tableName); ?>">

    <?php
    
    try {
        $stmtCom = $pdo->query("SHOW FULL COLUMNS FROM $tableName");

        // неактивний інпут для ід
        printf("<input type='hidden' name='id' value='%s'>", $_POST['id']);

        $row = $stmtCom->fetch(PDO::FETCH_ASSOC); // skip id

        while ($row = $stmtCom->fetch(PDO::FETCH_ASSOC)) {
            $comment = $row['Comment'] == '' ? $row['Field'] : $row['Comment'];
            
            // це треш я знаю
            switch ($row['Type']) {
                case 'tinyint(1)':
                    echo "<input type='checkbox' name='" . $row['Field'] . "' value='1'>";
                    echo "<label for='" . $row['Field'] . "'>" . $comment . "</label>";
                    break;
                    
                case (strpos($row['Type'], 'int') !== false):
                    $isForeign = isForeign($pdo, $tableName, $row['Field']);
                    if ($isForeign) {
                        $stmtForeign = $pdo->query('SELECT ID FROM ' . $isForeign);

                        echo "<label for='" . $row['Field'] . "' " . $required. ">" . $comment . "</label>";

                        echo "<select name='" . $row['Field'] . "' $required>";
                        // пустий варіант
                        echo "<option value=''></option>";
                        while($rowForeign = $stmtForeign->fetch(PDO::FETCH_ASSOC)) {
                            echo "<option value='" . $rowForeign['ID'] . "'>" . $rowForeign['ID'] . " </option>";
                        }
                        echo "</select>";
                    } else {
                        preg_match('/\d+/', $row['Type'], $matches);
                        $size = $matches[0];
                        echo "<input type='number' name='" . $row['Field'] . "' placeholder='" . $comment . "' maxlength='" . $size. "'>";
                    }
                    
                    break;

                case (strpos($row['Type'], 'varchar') !== false):
                    preg_match('/\d+/', $row['Type'], $matches);
                    $size = $matches[0];
                    echo '<input type="text" name="' . $row['Field'] . '" placeholder="' . $comment . '" maxlength="' . $size . '">';
                    break;

                case 'text':
                    if (preg_match('/_location$/', $row['Field'])) {
                        echo "<input type='file' name='" . $row['Field'] . "' placeholder='" . $comment . "'>";
                    } else {
                        echo "<textarea name='" . $row['Field'] . "' placeholder='" . $comment . "'></textarea>";
                    }
                    break;
                    
                case 'date':
                    echo "<label for='" . $row['Field'] . "'>" . $comment . "</label>";
                    echo "<input type='date' name='" . $row['Field'] . "' placeholder='" . $comment . "'>";
                    break;

                default:
                    echo "<input type='text' name='" . $row['Field'] . "' placeholder='" . $comment . "'>";
                    break;
            }
        }
    } catch (PDOException $e) {
        die("Помилка запиту: " . $e->getMessage());
    }

    ?>
    <button type="submit">Оновити рядок</button>
</form>

</body>

</html>