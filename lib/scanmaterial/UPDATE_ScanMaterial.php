<?php
header("Access-Control-Allow-Origin: *");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $no = $_POST['no'];
    $unit = $_POST['unit'];
    $nip = $_POST['nip'];
    $conn = mysqli_connect("localhost", "root", "", "db_rekachain");

    if ($conn) {
        // Cek apakah nip sudah ada di database
        $checkQuery = "SELECT nip FROM tbl_material WHERE no='$no'";
        $result = mysqli_query($conn, $checkQuery);

        if ($result && mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $existingNip = $row['nip'];

            if (empty($existingNip)) {
                // Jika nip masih kosong, update kedua kolom
                $updateQuery = "UPDATE tbl_material SET unit='$unit', nip='$nip' WHERE no='$no'";
            } else {
                if ($existingNip == $nip) {
                    // Jika nip sudah ada dan sesuai, update hanya kolom unit
                    $updateQuery = "UPDATE tbl_material SET unit='$unit' WHERE no='$no'";
                } else {
                    echo "Gagal memperbarui data: NIP tidak sesuai.";
                    exit();
                }
            }
        } else {
            echo "Data tidak ditemukan atau gagal melakukan query.";
            exit();
        }

        if (mysqli_query($conn, $updateQuery)) {
            echo "Data berhasil diperbarui.";
        } else {
            echo "Gagal memperbarui data: " . mysqli_error($conn);
        }
    } else {
        echo "Gagal terhubung ke database: " . mysqli_connect_error();
    }
} else {
    echo "Metode yang digunakan bukan POST.";
}
?>
