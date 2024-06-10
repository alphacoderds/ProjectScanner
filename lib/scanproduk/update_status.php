<?php
header("Access-Control-Allow-Origin: *");

// Koneksi ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Periksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Ambil data dari permintaan POST
$id_lot = isset($_POST['id_lot']) ? $_POST['id_lot'] : null;
$current_step = isset($_POST['current_step']) ? $_POST['current_step'] : null;

// Logika untuk memeriksa status tahap sebelumnya
if ($current_step > 1) { // Kecuali tahap pertama
    $previous_step = $current_step - 1;
    $sql_check = "SELECT status1 FROM tbl_lot WHERE id_lot = ?";
    $stmt_check = $conn->prepare($sql_check);
    $stmt_check->bind_param("s", $id_lot);
    $stmt_check->execute();
    $stmt_check->bind_result($previous_status);
    $stmt_check->fetch();
    $stmt_check->close();

    if ($previous_status != 'sudah dikerjakan') {
        $response = array("status" => "error", "message" => "Tahap sebelumnya belum selesai.");
        header('Content-Type: application/json');
        echo json_encode($response);
        exit();
    }
}

// Jika tahap pertama atau tahap sebelumnya sudah 'sudah dikerjakan', lakukan pembaruan
$sql = "UPDATE tbl_lot SET status1 = 'sudah dikerjakan' WHERE id_lot = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $id_lot);

// Eksekusi query update
if ($stmt->execute()) {
    $response = array("status" => "success", "message" => "Status updated successfully");
} else {
    $response = array("status" => "error", "message" => "Failed to update status: " . $conn->error);
}

$stmt->close();
$conn->close();

// Keluarkan respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);
?>