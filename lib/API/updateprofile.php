updateprofile php

<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');
$kode_staff = $_POST['kode_staff'];
$nama = $_POST['nama'];
$nip = $_POST['nip'];
$jabatan = $_POST['jabatan'];
$unit_kerja = $_POST['unit_kerja'];
$departemen = $_POST['departemen'];
$divisi = $_POST['divisi'];
$no_telp = $_POST['no_telp'];
$status = $_POST['status'];
$password = $_POST['password'];
$konfirmasi_password = $_POST['konfirmasi_password'];

if (isset($_FILES['userprofile'])) {
    $file = $_FILES['userprofile'];
    $file_name = $file['name'];
    $file_tmp = $file['tmp_name'];
    $file_error = $file['error'];

    if ($file_error === 0) {
        $file_destination = 'uploads/' . $file_name;
        move_uploaded_file($file_tmp, $file_destination);

        $data = mysqli_query($conn, "UPDATE coba SET 
        kode_staff='$kode_staff', 
        nama='$nama', 
        jabatan='$jabatan', 
        unit_kerja='$unit_kerja', 
        departemen='$departemen', 
        divisi='$divisi', 
        no_telp='$no_telp', 
        status='$status', 
        userprofile='$file_destination' 
        WHERE nip='$nip'");
} else {
    echo json_encode([
        "message" => "File upload error"
    ]);
    exit();
}
} else {
$data = mysqli_query($conn, "UPDATE coba SET 
    kode_staff='$kode_staff', 
    nama='$nama', 
    jabatan='$jabatan', 
    unit_kerja='$unit_kerja', 
    departemen='$departemen', 
    divisi='$divisi', 
    no_telp='$no_telp', 
    status='$status' 
    WHERE nip='$nip'");
}

if ($data) {
echo json_encode([
    "message" => "Success"
]);
} else {
echo json_encode([
    "message" => "Failed to update data"
]);
}
?>