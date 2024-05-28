<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$conn=mysqli_connect('localhost','root','','db_rekachain');

$kode_staff = $_POST['kode_staff'];
$nama = $_POST['nama'];
$nip = $_POST['nip'];
$foto = $_FILES['foto'];
$jabatan = $_POST['jabatan'];
$unit_kerja = $_POST['unit_kerja'];
$departemen = $_POST['departemen'];
$divisi = $_POST['divisi'];
$no_telp = $_POST['no_telp'];
$status = $_POST['status'];
$password = $_POST['password'];
$konfirmasi_password = $_POST['konfirmasi_password'];

$path = 'upload/';
$extension = pathinfo($foto['name'], PATHINFO_EXTENSION);
$new_filename = uniqid() . '_' . time() . '.' . $extension;
$uploadfile = $path . $new_filename;

if (move_uploaded_file($foto['tmp_name'], $uploadfile)) {
    $base_url = "http://192.168.9.56/ProjectScanner/lib/API/upload/$new_filename";
    $query = "UPDATE `coba` SET `nama`='$nama',`jabatan`='$jabatan',`unit_kerja`='$unit_kerja',`departemen`= '$departemen',`divisi`='$divisi',`no_telp`='$no_telp',`status`='$status',`foto`='$base_url' WHERE nip = $nip";
    $result=mysqli_query($conn, $query);
    if ($result) {
        echo json_encode([
            "message" => "Success",
        ]);
    } else {
        echo json_encode([
            "message" => "Failed",
        ]);
    }
    
} else {
    echo json_encode([
        "message" => "Failed",
    ]);
}
?>