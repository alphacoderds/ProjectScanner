<?php

// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: POST");
// header("Access-Control-Allow-Headers: Content-Type");

// $conn = mysqli_connect("localhost", "root", "", "db_rekachain");
// if (!$conn) {
//     die("Connection failed: " . mysqli_connect_error());
// }

// if ($_SERVER['REQUEST_METHOD'] == 'POST') {
//     // Debugging: Log the received POST data
//     error_log(print_r($_POST, true));
//     // Additional debug log to check the request method
//     error_log("Request Method: " . $_SERVER['REQUEST_METHOD']);

//     $no = isset($_POST['no']) ? mysqli_real_escape_string($conn, $_POST['no']) : null;
//     $table = isset($_POST['table']) ? mysqli_real_escape_string($conn, $_POST['table']) : null;

//     if ($no === null || $table === null) {
//         echo json_encode(array('error' => 'No parameter provided'));
//         mysqli_close($conn);
//         exit();
//     }

//     if (!in_array($table, ['tbl_openlist', 'tbl_openilist'])) {
//         echo json_encode(array('error' => 'Invalid table name'));
//         mysqli_close($conn);
//         exit();
//     }

//     $sql = "DELETE FROM $table WHERE no = '$no'";

//     if (mysqli_query($conn, $sql)) {
//         echo json_encode(array('success' => 'Item deleted successfully from ' . $table));
//     } else {
//         echo json_encode(array('error' => 'Failed to delete item from ' . $table . ': ' . mysqli_error($conn)));
//     }
// } else {
//     // Additional debug log to capture when the request method is not POST
//     error_log("Invalid request method: " . $_SERVER['REQUEST_METHOD']);
//     echo json_encode(array('error' => 'Invalid request method'));
// }

// mysqli_close($conn);
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$no = $_POST["no"];
$data= mysqli_query($conn, "delete from tbl_openilist where no='$no' ");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>
