<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Konfigurasi koneksi database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Memeriksa koneksi
if ($conn->connect_error) {
    die(json_encode(array("pesan" => "Koneksi gagal: " . $conn->connect_error)));
}

// Query untuk mengambil semua data dari tabel saran
$query = mysqli_query($conn, "SELECT * FROM saran");

// Mengambil semua data dan mengonversinya menjadi format JSON
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);

// Menutup koneksi
$conn->close();
?>
