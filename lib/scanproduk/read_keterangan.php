<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");

$id_lot = $_POST['id_lot'];
$step = $_POST['step'];
$keterangan_colum = "keterangan_produk$step";

$query=mysqli_query($conn,"select $keterangan_colum from tbl_lot where id_lot = $id_lot");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>