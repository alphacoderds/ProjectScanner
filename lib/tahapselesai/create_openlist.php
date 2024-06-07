<?php
header("Access-Control-Allow-Origin: *");
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $no = $_POST['no'];
    $isi = $_POST['isi'];
    $id_openlist = $_POST['id_openlist'];

    $conn = mysqli_connect("localhost", "root", "", "db_rekachain");

    if ($conn) {
        $query = "INSERT INTO tbl_openilist (no, isi, id_openlist) 
                  VALUES ('$no', '$isi', '$id_openlist')";

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