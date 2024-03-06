<?php

	include 'conn.php';
	
	$kodeproject = $_POST['kodeproject'];
	$namaproject = $_POST['namaproject'];
	
	
	$connect->query("INSERT INTO project (KodeProject,namaProject) VALUES ('".$kodeproject."','".$namaproject."')")

?>