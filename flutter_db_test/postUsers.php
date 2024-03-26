<?php

// Allow requests from any origin and set the content type to JSON
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Enable error reporting for debugging purposes
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Include the database connection file
include_once 'dbConnection.php'; // Adjust the file path as necessary

// Check if the necessary parameters are set
if (isset($_POST['email'], $_POST['userName'], $_POST['password'])) {
    // Retrieve user input from the request
    $email = $_POST['email'];
    $userName = $_POST['userName'];
    $password = $_POST['password'];

    // Validate user input (you can add more validation as needed)
    if (empty($email) || empty($userName) || empty($password)) {
        // Handle empty fields error
        http_response_code(400); // Bad Request
        echo json_encode(array("message" => "All fields are required."));
        exit();
    }

    // Hash the password securely
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    try {
        // Prepare and execute the SQL statement to insert the user into the database
        $sql = "INSERT INTO users (email, userName, password) VALUES (?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$email, $userName, $hashedPassword]);

        // User registration successful
        http_response_code(201); // Created
        echo json_encode(array("message" => "User registered successfully."));
    } catch(PDOException $e) {
        // Handle database error
        http_response_code(500); // Internal Server Error
        echo json_encode(array("message" => "Unable to register user. Please try again later."));
    }
} else {
    // Handle missing parameters error
    http_response_code(400); // Bad Request
    echo json_encode(array("message" => "Missing parameters."));
}

// Close the database connection
unset($pdo);
?>


