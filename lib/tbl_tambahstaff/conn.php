<?php
header("Access-Control-Allow-Origin: *");
$connect = new mysqli("localhost","root","","db_contact");
if($connect){
}else{
	echo "Connection Failed";
	exit();
}