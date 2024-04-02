<?php
// Ambil NIP dari sesi
session_start();
$nip = $_SESSION['nip'];

// Lakukan koneksi ke database
$conn = mysqli_connect("localhost", "root", "", "db_contact");

// Query untuk mengambil data dari tabel 'coba' sesuai dengan NIP
$query = "SELECT * FROM coba WHERE nip = '$nip'";
$result = mysqli_query($conn, $query);

// Tampilkan data di halaman profil
while($row = mysqli_fetch_assoc($result)) {
    echo "Nama: " . $row['nama'] . "<br>";
    echo "NIP: " . $row['nip'] . "<br>";
    echo "NIP: " . $row['unit_kerja'] . "<br>";
    // Tambahkan kolom lain yang ingin ditampilkan
}

// Tutup koneksi ke database
mysqli_close($conn);
?>
