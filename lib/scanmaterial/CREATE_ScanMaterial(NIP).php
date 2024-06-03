<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

// Periksa koneksi
if ($conn->connect_error) {
    die("Koneksi ke database gagal: " . $conn->connect_error);
}

// Tangkap NIP dari body request
$nip = $_POST['nip'];

// Query untuk menyimpan NIP ke dalam tabel pengguna (ganti 'nama_tabel' dengan nama tabel Anda)
$sql = "INSERT INTO coba (nip) VALUES ('$nip')";

// Eksekusi query
if ($conn->query($sql) === TRUE) {
    echo "NIP berhasil disimpan ke dalam database";
} else {
    echo "Gagal menyimpan NIP ke dalam database: " . $conn->error;
}

// Tutup koneksi database
$conn->close();
?>
