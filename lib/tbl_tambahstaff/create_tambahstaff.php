<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_contact");
$kode_staff = $_POST["kode_staff"];
$nama = $_POST["nama"];
$jabatan = $_POST["jabatan"];
$unit_kerja = $_POST["unit_kerja"];
$departemen = $_POST["departemen"];
$divisi = $_POST["divisi"];
$no_telp = $_POST["no_telp"];
$nip = $_POST["nip"];
$status = $_POST["status"];
$password = $_POST["password"];
$konfirmasi_password = $_POST["konfirmasi_password"];

$data= mysqli_query($conn, "INSERT into coba set kode_staff = '$kode_staff', nama = '$nama', jabatan = '$jabatan', unit_kerja = '$unit_kerja', departemen = '$departemen', divisi = '$divisi', no_telp = '$no_telp', nip = '$nip', status = '$status', password = '$password', konfirmasi_password = '$konfirmasi_password' ");
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