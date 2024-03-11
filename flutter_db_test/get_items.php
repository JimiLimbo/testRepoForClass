<?php

// Allow requests from any origin and set the content type to JSON
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Enable error reporting for debugging purposes
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Database connection parameters
$host = 'localhost';
$dbname = 'flutter_test';
$username = 'root';
$password = 'mysql';

// Establish a connection to the MySQL database using PDO
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // Set PDO to throw exceptions in case of error
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    // If connection fails, return an error message
    die("ERROR: Could not connect. " . $e->getMessage());
}

// Check if the request is a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Decode the JSON body from the request
    $data = json_decode(file_get_contents('php://input'), true);

    // Extract item name and price from the decoded data
    $itemName = $data['item_name'];
    $itemPrice = $data['item_price'];

    // Prepare the SQL query to insert a new item into the database
    $insertQuery = "INSERT INTO item (item_name, item_price) VALUES (?, ?)";
    $stmt = $pdo->prepare($insertQuery);
    // Execute the query with the item name and price
    $result = $stmt->execute([$itemName, $itemPrice]);

    // Check if the insert operation was successful
    if ($result) {
        // Respond with a success message
        echo json_encode(['message' => 'Item added successfully']);
    } else {
        // Respond with a failure message
        echo json_encode(['message' => 'Failed to add item']);
    }
} else { // Handle GET requests
    try {
        // Prepare the SQL query to select all items from the database
        $query = "SELECT item_id, item_name, item_price FROM item";
        $stmt = $pdo->prepare($query);
        
        // Execute the query
        $stmt->execute();
        
        // Fetch all results as an associative array
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Encode the items array as JSON and return it
        echo json_encode($items);
    } catch(PDOException $e) {
        // If the query execution fails, return an error message
        die("ERROR: Could not able to execute $query. " . $e->getMessage());
    }
}

// Close the database connection
unset($pdo);
?>