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

$data = mysqli_query($conn, "UPDATE coba SET kode_staff='$kode_staff', nama='$nama', nip='$nip', jabatan='$jabatan', unit_kerja='$unit_kerja', departemen='$departemen', divisi='$divisi', no_telp='$no_telp', status='$status', password=SHA1('$password'), konfirmasi_password= SHA1('$konfirmasi_password') WHERE nip='$nip' ");

if ($result) {
    echo json_encode([
        "message" => "Success"
    ]);
}else{
   echo json_encode([
    "message" => "Gagal"
   ]);
}
?>