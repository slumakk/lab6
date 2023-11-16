<?php
    include "databaseConnect.php";

    $queries = array();
    $queryString = $_SERVER['QUERY_STRING'];
    parse_str($queryString, $queries);
    $tableName = $queries['table'];
    $result = false;

    if (isset($queries['table'])) { 
        try {
            $stmt = $pdo->query("SHOW TABLES LIKE '$tableName'");
            $tableExists = $stmt->rowCount() > 0;
            if ($tableExists) {
                $result = true;
            }
        } catch (PDOException $e) {
            die("Помилка запиту: " . $e->getMessage());
        }
    }

    if($result === false) {
        header("Location: ./");
        exit;
    }
?>