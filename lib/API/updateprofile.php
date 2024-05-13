<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$id = $_POST['kode_staff'];
$nama = $_POST['nama'];
$jabatan = $_POST['jabatan'];
$unit_kerja = $_POST['unit_kerja'];
$departemen = $_POST['departemen'];
$divisi = $_POST['divisi'];
$no_telp = $_POST['no_telp'];
$status = $_POST['status'];
$password = $_POST['password'];
$konfirmasi_password = $_POST['konfirmasi_password'];

$sql =  "UPDATE `coba` SET `nama`='$nama',`jabatan`='$jabatan',`unit_kerja`='$unit_kerja',`departemen`='$departemen',`divisi`='$divisi',`no_telp`='$no_telp',`status`='$status',`password`=SHA1('$password'),`konfirmasi_password`= SHA1('$konfirmasi_password') WHERE kode_staff = $id";


$result = mysqli_query($conn,$sql);

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
