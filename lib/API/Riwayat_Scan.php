riwayat scan

<?php
// Informasi koneksi ke database MySQL
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "db_contact";

// Membuat koneksi ke database
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mendapatkan data dari aplikasi Flutter
$data = json_decode(file_get_contents('php://input'), true);

// Menyimpan data riwayat scan ke dalam database
$user = $data['user'];
$product = $data['product'];

$sql = "INSERT INTO scan_history (user, product) VALUES ('$user', '$product')";

if ($conn->query($sql) === TRUE) {
    echo "Data riwayat scan berhasil disimpan";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Menutup koneksi database
$conn->close();
?>
