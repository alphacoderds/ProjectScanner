<?php
header("Access-Control-Allow-Origin: *");
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// $no = isset($row['no']) ? $row['no'] : '';
// $unit = isset($row['unit']) ? $row['unit'] : '';
// $nip = isset($row['nip']) ? $row['nip'] : '';

$no = $_POST["no"];
$unit = $_POST["unit"];
$nip = $_POST["nip"];

// Fetch current nip
$query = "SELECT nip FROM tbl_material WHERE no='$no'";
$result = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($result);

// $current_nip = isset($row['nip']) ? $row['nip'] : '';
$current_nip = $row['nip'];

if (is_null($current_nip) || $current_nip == '') {
    // If nip is not set, set it to the current NIP
    $updateQuery = "UPDATE tbl_material SET unit='$unit', nip='$nip' WHERE no='$no'";
} else if ($nip == $current_nip) {
    // If nip is set, only allow the update if the current NIP matches the stored NIP
    $updateQuery = "UPDATE tbl_material SET unit='$unit' WHERE no='$no'";
} else {
    echo json_encode([
        'pesan' => 'Unauthorized'
    ]);
    exit;
}

$data = mysqli_query($conn, $updateQuery);
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>
