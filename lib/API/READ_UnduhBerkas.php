<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","crudflutter");
$query=mysqli_query($conn,"select * from tbl_file");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>