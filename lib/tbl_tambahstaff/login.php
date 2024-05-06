<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect('localhost', 'root', '', 'db_rekachain');

$nip = $_POST['nip'];
$password = $_POST['password'];
$hashedPassword = sha1($password); // You're hashing the password, which is good for security.

$sql = "SELECT * FROM coba WHERE nip = '$nip' AND password = '$hashedPassword'"; // Using SHA1 hashed password for comparison.

$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);

if ($count == 1) {
    session_start(); // Starting session
    $_SESSION['nip'] = $nip; // Storing NIP in session
    echo json_encode("Success");
} else {
    echo json_encode('Error');
}
?>
