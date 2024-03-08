<?php

$conn=new mysqli("localhost","root","","db_contact");
$query=mysqli_query($conn,"select * from coba");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);

?>