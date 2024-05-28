<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Create a new database connection
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Check the connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["message" => "Database connection failed: " . $conn->connect_error]);
    exit();
}

// Execute the query to select all records from tbl_lot
$query = $conn->query("SELECT * FROM tbl_lot");

// Check if the query was successful
if (!$query) {
    http_response_code(500);
    echo json_encode(["message" => "Query execution failed: " . $conn->error]);
    $conn->close();
    exit();
}

// Fetch all records as an associative array
$data = $query->fetch_all(MYSQLI_ASSOC);

// Output the data as a JSON response
echo json_encode($data);

// Close the database connection
$conn->close();
?>
