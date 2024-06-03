<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$id_lot = $_POST["id_lot"];
$nip = $_POST["nip"];
$keterangan_produk = $_POST["keterangan_produk"];
$data= mysqli_query($conn, "update tbl_lot set keterangan_produk='$keterangan_produk', nip='$nip' where id_lot='$id_lot' ");
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
