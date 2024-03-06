<?php
	include 'conn.php';
	$kodeproject=$_POST['kodeproject'];
	$namaproject=$_POST['namaproject'];
	$connect->query("DELETE FROM project WHERE kodeproject=".$kodeproject);

?>