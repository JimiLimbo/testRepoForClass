<?php
// Start a session
session_start();

// Database connection
require_once 'dbConnection.php';

// Retrieve email and password from the request
$email = $_POST['email'];
$password = $_POST['password'];

// Query to find user by email
$stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch();

// Verify user and password
if ($user && password_verify($password, $user['password'])) {
    // Authentication successful, start a session
    $_SESSION['user_id'] = $user['userID'];
    $_SESSION['email'] = $user['email'];
    // You can store more user information in the session if needed

    // Return success response
    echo json_encode(['success' => true, 'message' => 'Login successful']);
} else {
    // Authentication failed
    echo json_encode(['success' => false, 'message' => 'Invalid email or password']);
}
?>
