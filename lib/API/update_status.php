<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
$conn=new mysqli("localhost","root","","db_rekachain");


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id_lot = $_POST['id_lot'];
$current_step = $_POST['current_step'];  // Tahap saat ini yang akan diperbarui
$nip = $_POST['nip'];

$sql = "SELECT * FROM `tbl_lot` WHERE id_lot = $id_lot";
$resultCheck =mysqli_query($conn, $sql);
$count=mysqli_num_rows($resultCheck);
$data = [];

while($row = mysqli_fetch_assoc($resultCheck)){
    $data[] = $row;
}

if ($data == null) {
    $response = array("status" => "error", "message" => "Failed to update status");
    header("HTTP/1.1 404 ERROR");
    echo json_encode([
        "message" => "Failed",
    ]);
}else{
    $sql_check = "UPDATE `tbl_lot` SET `status1`='sedang dikerjakan',`keterangan_produk1`='',`nip1`=$nip WHERE id_lot = $id_lot";
    $result=mysqli_query($conn, $sql_check);

if ($result) {
    $response = array("status" => "success", "message" => "Status updated successfully");
    echo json_encode([
        "message" => "Success",
    ]);
} else {
    $response = array("status" => "error", "message" => "Failed to update status");
    header("HTTP/1.1 404 ERROR");
    echo json_encode([
        "message" => "Failed",
    ]);
}
}


?>
