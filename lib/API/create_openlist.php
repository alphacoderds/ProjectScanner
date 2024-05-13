<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$no = $_POST["no"];
$isi = $_POST["isi"];
$data= mysqli_query($conn, "INSERT into tbl_openilist set no='$no', isi='$isi'");
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