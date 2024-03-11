<?php

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

ini_set('display_errors', 1);
error_reporting(E_ALL);

$host = 'localhost';
$dbname = 'flutter_test';
$username = 'root';
$password = 'mysql';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("ERROR: Could not connect. " . $e->getMessage());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    $itemName = $data['item_name'];
    $itemPrice = $data['item_price'];

    $insertQuery = "INSERT INTO item (item_name, item_price) VALUES (?, ?)";
    $stmt = $pdo->prepare($insertQuery);
    $result = $stmt->execute([$itemName, $itemPrice]);

    if ($result) {
        echo json_encode(['message' => 'Item added successfully']);
    } else {
        echo json_encode(['message' => 'Failed to add item']);
    }
} else { // Handle GET requests
    try {
        $query = "SELECT item_id, item_name, item_price FROM item";
        $stmt = $pdo->prepare($query);
    
        $stmt->execute();
    
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        echo json_encode($items);
    } catch(PDOException $e) {
        die("ERROR: Could not able to execute $query. " . $e->getMessage());
    }
}

unset($pdo);
?>
