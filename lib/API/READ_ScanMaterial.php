<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$kode_material = $_GET['kode_material'];

$sql = $conn->query("select * from scan_material where kode_material = '$kode_material'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>