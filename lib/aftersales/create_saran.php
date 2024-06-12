<!-- <?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

$conn = new mysqli("localhost", "root", "", "db_rekachain");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$saran = $_POST["saran"];
$waktu_saran = $_POST["waktu_saran"];

$stmt = $conn->prepare("INSERT INTO tbl_lot (saran, waktu_saran) VALUES (?, ?)");
$stmt->bind_param("ss", $saran, $waktu_saran);

if ($stmt->execute()) {
    echo json_encode(['pesan' => 'Sukses']);
} else {
    echo json_encode(['pesan' => 'Gagal']);
}

$stmt->close();
$conn->close();
?> -->
