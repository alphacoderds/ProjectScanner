<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$conn = mysqli_connect('localhost', 'root', '', 'db_rekachain');

$nama = $_POST['nama'];
$nip = $_POST['nip'];
$jabatan = $_POST['jabatan'];
$unit_kerja = $_POST['unit_kerja'];
$departemen = $_POST['departemen'];
$divisi = $_POST['divisi'];
$no_telp = $_POST['no_telp'];
$status = $_POST['status'];

$path = '../Project/upload/';
$profile = isset($_FILES['profile']) ? $_FILES['profile'] : null;

if ($profile) {
    $extension = pathinfo($profile['name'], PATHINFO_EXTENSION);
    $new_filename = uniqid() . '_' . time() . '.' . $extension;
    $uploadfile = $path . $new_filename;

    if (move_uploaded_file($profile['tmp_name'], $uploadfile)) {
        $base_url = "http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/upload/$new_filename";
        $query = "UPDATE `tbl_tambahstaff` SET `nama`='$nama',`jabatan`='$jabatan',`unit_kerja`='$unit_kerja',`departemen`= '$departemen',`divisi`='$divisi',`no_telp`='$no_telp',`status`='$status',`profile`='$base_url' WHERE nip = $nip";
    } else {
        echo json_encode(["message" => "Failed to upload image"]);
        exit();
    }
} else {
    $query = "UPDATE `tbl_tambahstaff` SET `nama`='$nama',`jabatan`='$jabatan',`unit_kerja`='$unit_kerja',`departemen`= '$departemen',`divisi`='$divisi',`no_telp`='$no_telp',`status`='$status' WHERE nip = $nip";
}

$result = mysqli_query($conn, $query);

if ($result) {
    echo json_encode(["status" => "success", "message" => "Update successful"]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to update data"]);
}
?>
