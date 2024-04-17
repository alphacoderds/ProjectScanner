<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$id = $_POST["id"];
$qty_diterima = $_POST["qty_diterima"];
$data= mysqli_query($conn, "update scan_material set qty_diterima='$qty_diterima' where id='$id' ");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>
