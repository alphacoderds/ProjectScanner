<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$id_project = $_GET['id_project'];

$sql = $conn->query("SELECT tbl_kerusakan.*, tbl_lot.saran
FROM tbl_kerusakan 
JOIN tbl_lot ON tbl_kerusakan.id_project = tbl_lot.id_lot
WHERE tbl_kerusakan.id_project = '$id_project'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>