<?php

include "parse_url.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $values = array();
    $placeholders = array();
    foreach ($_POST as $key => $value) {
        $values[] = $value;
        $placeholders[] = '?';
    }

    $stmt = $pdo->prepare("INSERT INTO $tableName (" . implode(',', array_keys($_POST)) . ") VALUES (" . implode(',', $placeholders) . ")");
    
    if ($stmt->execute($values)) {
        echo "<script>alert('Дані додано успішно!');
            window.location.href = 'show.php?table=$tableName';
        </script>";
    } else {
        echo "<script>alert('Дані не було додано!');
            window.location.href = 'show.php?table=$tableName';
        </script>";
    }
}

else {
    header("Location: show.php?table=$tableName");
    exit();
}
?>
