<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

$conn = new mysqli("localhost", "root", "", "db_rekachain");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id_lot = $_POST["id_lot"]; // Pastikan Anda menerima ID yang akan diupdate
$saran = $_POST["saran"];
$waktu_saran = $_POST["waktu_saran"];

$stmt = $conn->prepare("UPDATE tbl_lot SET saran = ?, waktu_saran = ? WHERE id_lot = ?");
$stmt->bind_param("ssi", $saran, $waktu_saran, $id_lot);

if ($stmt->execute()) {
    echo json_encode(['pesan' => 'Sukses']);
} else {
    echo json_encode(['pesan' => 'Gagal']);
}

$stmt->close();
$conn->close();
?>
