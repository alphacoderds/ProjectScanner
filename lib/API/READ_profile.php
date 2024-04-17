<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$nip = $_GET['nip'];

$sql = $conn->query("SELECT * FROM coba WHERE nip = '$nip'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>
