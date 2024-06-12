<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

if (isset($_GET['id_lot'])) {
    $id_lot = $_GET['id_lot'];
    $conn = mysqli_connect("localhost", "root", "", "db_rekachain");

    if ($conn) {
        $query = "SELECT * FROM tbl_lot WHERE id_lot=?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("s", $id_lot);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($row = $result->fetch_assoc()) {
            echo json_encode($row);
        } else {
            echo json_encode(array("status" => "error", "message" => "No record found."));
        }

        $stmt->close();
    } else {
        echo json_encode(array("status" => "error", "message" => "Connection failed: " . mysqli_connect_error()));
    }

    $conn->close();
} else {
    echo json_encode(array("status" => "error", "message" => "ID lot is required."));
}
?>
