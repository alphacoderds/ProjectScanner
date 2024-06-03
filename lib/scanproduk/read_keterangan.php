<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");

$id_lot = $_GET['id_lot'];

$query=mysqli_query($conn,"select * from tbl_lot where id_lot = '$id_lot'");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>