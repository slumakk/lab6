<html>

<?php
    include "parse_url.php";
?>

<head>
    <meta charset="utf-8">
    <meta name="keywords" content="Лабораторна робота, MySQL, робота з базою даних">
    <meta name="description" content="Лабораторна робота. Робота з базою даних">
    <title>Вставка даних</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

    <h1>Вставка даних в таблицю <?php printf($tableName); ?></h1>

    <form method="POST" action="insert.php?table=<?php printf($tableName); ?>">

        <?php
        include "isForeign.php";

        try {
            $stmtCom = $pdo->query("SHOW FULL COLUMNS FROM $tableName");

            $row = $stmtCom->fetch(PDO::FETCH_ASSOC); // skip id

            while ($row = $stmtCom->fetch(PDO::FETCH_ASSOC)) {
                $comment = $row['Comment'] == '' ? $row['Field'] : $row['Comment'];
                
                $required = $row['Null'] == 'NO' ? "required" : "";
                
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
                            while($rowForeign = $stmtForeign->fetch(PDO::FETCH_ASSOC)) {
                                echo "<option value='" . $rowForeign['ID'] . "'>" . $rowForeign['ID'] . " </option>";
                            }
                            echo "</select>";
                        } else {
                            preg_match('/\d+/', $row['Type'], $matches);
                            $size = $matches[0];
                            echo "<input type='number' name='" . $row['Field'] . "' placeholder='" . $comment . "' maxlength='" . $size. "' " . $required. ">";
                        }
                        
                        break;

                    case (strpos($row['Type'], 'varchar') !== false):
                        preg_match('/\d+/', $row['Type'], $matches);
                        $size = $matches[0];
                        echo '<input type="text" name="' . $row['Field'] . '" placeholder="' . $comment . '" maxlength="' . $size . '" ' . $required . '>';
                        break;

                    case 'text':
                        if (preg_match('/_location$/', $row['Field'])) {
                            echo "<input type='file' name='" . $row['Field'] . "' placeholder='" . $comment . "' " . $required. ">";
                        } else {
                            echo "<textarea name='" . $row['Field'] . "' placeholder='" . $comment . "' " . $required. "></textarea>";
                        }
                        break;
                        
                    case 'date':
                        echo "<label for='" . $row['Field'] . "'>" . $comment . "</label>";
                        echo "<input type='date' name='" . $row['Field'] . "' placeholder='" . $comment . "' " . $required. ">";
                        break;

                    default:
                        echo "<input type='text' name='" . $row['Field'] . "' placeholder='" . $comment . "' " . $required. ">";
                        break;
                }
            }
        } catch (PDOException $e) {
            die("Помилка запиту: " . $e->getMessage());
        }

        ?>
        <button type="submit">Вставити рядок</button>
    </form>
</body>

</html>