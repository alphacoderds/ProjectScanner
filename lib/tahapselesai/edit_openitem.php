<?php
header("Access-Control-Allow-Origin: *");
$conn = new mysqli("localhost", "root", "", "db_rekachain");

$no = $_POST["no"];
$isi = $_POST["isi"];

$data = mysqli_query($conn, "UPDATE tbl_openilist SET isi='$isi' WHERE no=$no");

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>
