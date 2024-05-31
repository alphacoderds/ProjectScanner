<?php
// Retrieve the NIP from the session
$nip = $_POST['nip'];

// Establish a connection to the database
$conn = mysqli_connect("localhost", "root", "", "db_rekachain");

// Query to retrieve data from the 'coba' table based on NIP
$query = "SELECT * FROM tbl_tambahstaff WHERE nip = $nip";
$result = mysqli_query($conn, $query);

$count = mysqli_num_rows($result);
$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

if ($count == 1) {
    echo json_encode([
        "message" => "Success",
        "data" => $data[0]
    ]);
} else {
    echo json_encode([
        "message" => "Failed",
    ]);
}

// Close the database connection
mysqli_close($conn);
?>
