<?php

include "parse_url.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];
    $stmt = $pdo->prepare("DELETE FROM $tableName WHERE id=?");
    if ($stmt->execute(array($id))) {
        echo "<script>alert('Дані видалено успішно!');
            window.location.href = 'show.php?table=$tableName';
        </script>";
    } else {
        echo "<script>alert('Дані не було видалено.');
            window.location.href = 'show.php?table=$tableName';
        </script>";
    }
}

?>
