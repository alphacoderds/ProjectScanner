<?php
header("Access-Control-Allow-Origin: *");
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_project = $_POST['id_project'];
    $item = $_POST['item'];
    $detail_kerusakan = $_POST['detail_kerusakan'];
    $keterangan = $_POST['keterangan'];
    $waktu = $_POST['waktu'];
    $conn = mysqli_connect("localhost", "root", "", "db_rekachain");

    if ($conn) {
        $query = "INSERT INTO tbl_kerusakan (id_project, item, detail_kerusakan, keterangan, waktu) 
                  VALUES ('$id_project', '$item', '$detail_kerusakan', '$keterangan', '$waktu')";

        if (mysqli_query($conn, $query)) {
            echo mysqli_insert_id($conn);
        } else {
            echo "Gagal menyimpan data: " . mysqli_error($conn);
        }
    } else {
        echo "Gagal terhubung ke database: " . mysqli_connect_error();
    }
} else {
    echo "Metode yang digunakan bukan POST";
}
?>
