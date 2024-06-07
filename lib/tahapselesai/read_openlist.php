<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

$conn = mysqli_connect("localhost", "root", "", "db_rekachain");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

if (!isset($_GET['id_openlist'])) {
    echo json_encode(array('error' => 'Parameter id_openlist tidak ditemukan'));
    exit();
}

$id_openlist = mysqli_real_escape_string($conn, $_GET['id_openlist']);
$sql = "SELECT * FROM tbl_openilist WHERE id_openlist = '$id_openlist'";
$result = mysqli_query($conn, $sql);

if ($result) {
    $data = mysqli_fetch_all($result, MYSQLI_ASSOC);
    echo json_encode($data);
} else {
    echo json_encode(array('error' => 'Gagal mengambil data: ' . mysqli_error($conn)));
}

mysqli_close($conn);
?>
