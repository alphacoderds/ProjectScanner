<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$nip=$_POST['nip'];
$password=$_POST['password'];
$hashedPassword = sha1($password);

$sql="SELECT * FROM `coba` WHERE coba.nip = '$nip' AND coba.password = SHA1('$password')";

$result=mysqli_query($conn, $sql);
$count=mysqli_num_rows($result);
$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

if($data != null ) {

    echo json_encode([
        "message" => "Success",
        "data" => $data[0]
    ]);
}else{
    echo json_encode('Error');
}

?>