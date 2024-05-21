<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

$conn = new mysqli("localhost", "root", "", "db_rekachain");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$kode_produk = $_POST["kode_produk"];
$saran = $_POST["saran"];
$waktu = $_POST["waktu"];

$stmt = $conn->prepare("INSERT INTO saran (kode_produk, saran, waktu) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $kode_produk, $saran, $waktu);

if ($stmt->execute()) {
    echo json_encode(['pesan' => 'Sukses']);
} else {
    echo json_encode(['pesan' => 'Gagal']);
}

$stmt->close();
$conn->close();
?>
