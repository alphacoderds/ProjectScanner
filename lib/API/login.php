<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$nip=$_POST['nip'];
$password=$_POST['password'];
$hashedPassword = sha1($password);

$sql="select * from coba where nip = '$nip' and password = '$password'";

$result=mysqli_query($conn, $sql);
$count=mysqli_num_rows($result);

if($count == 1) {
    session_start(); // Mulai sesi di sini
    $_SESSION['nip'] = $nip; // Simpan NIP dalam sesi
    echo json_encode("Success");
}else{
    echo json_encode('Error');
}

?>