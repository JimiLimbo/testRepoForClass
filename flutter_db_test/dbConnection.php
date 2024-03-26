<?php

// Database connection parameters
$host = 'localhost';
$dbname = 'flutter_test';
$username = 'root';
$password = 'mysql';

try {
    // Establish a connection to the MySQL database using PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // Set PDO to throw exceptions in case of error
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    // If connection fails, display an error message and terminate execution
    die("ERROR: Could not connect. " . $e->getMessage());
}

?>
