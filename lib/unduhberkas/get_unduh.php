<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$id_lot = $_GET['id_lot'];

$sql = $conn->query("SELECT tbl_lot.*, tbl_file.file, tbl_file.tanggal 
FROM tbl_lot 
JOIN tbl_file ON tbl_lot.noProduk = tbl_file.noProduk 
WHERE tbl_lot.id_lot = '$id_lot'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>