<?php

include "parse_url.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $values = array();
    $keys = array();
    $placeholders = array();
    foreach ($_POST as $key => $value) {
        if ($value != '') {
            $values[] = $value;
            $keys[] = $key;
            printf($value);
        }
    }

    // delete id from values
    array_shift($values);
    array_shift($keys);

    $stmt = $pdo->prepare("UPDATE $tableName SET " . implode('=?,', $keys) . "=? WHERE ID = " . $_POST['id']);

    if ($stmt->execute($values)) {
        echo "<script>alert('Дані оновлено успішно!');
            window.location.href = 'show.php?table=$tableName';
        </script>";
    } else {
        echo "<script>alert('Дані не було оновлено.');
            window.location.href = 'show.php?table=$tableName';
        </script>";
    }
}

?>
