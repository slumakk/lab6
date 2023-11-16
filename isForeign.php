<?php
function isForeign($pdo, $tableName, $columnName) {
    $stmt = $pdo->query("SHOW CREATE TABLE $tableName");

    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    // Пошук зовнішнього ключа
    $pattern = "/FOREIGN KEY \(`$columnName`\) REFERENCES `(\w+)`/";
    if (preg_match($pattern, $row['Create Table'], $matches)) {
        return $matches[1];
    }
    return false;
}
?>