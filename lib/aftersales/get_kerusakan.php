<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect("localhost", "root", "", "db_rekachain");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
if (!isset($_GET['id_project'])) {
    echo json_encode(array('error' => 'Parameter id_project tidak ditemukan'));
    exit();
}
$id_project = $_GET['id_project'];
$sql = $conn->query("SELECT * FROM tbl_kerusakan WHERE id_project = '$id_project'");
if ($sql) {
    $data = $sql->fetch_all(MYSQLI_ASSOC);
    echo json_encode($data);
} else {
    echo json_encode(array('error' => 'Gagal mengambil data kerusakan: ' . mysqli_error($conn)));
}
mysqli_close($conn);
?>
