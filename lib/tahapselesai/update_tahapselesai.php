<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_lot = $_POST['id_lot'];
    $nip = $_POST['nip'];
    $conn = mysqli_connect("localhost", "root", "", "db_rekachain");

    if ($conn) {
        $can_update = false;
        $current_step = 0;

        $previous_status = 'sudah dikerjakan';  // Inisialisasi awal untuk tahap pertama

        for ($i = 1; $i <= 10; $i++) {
            $status_column = "status$i";
            $ap_column = "ap$i";
            $checkQuery = "SELECT $status_column, $ap_column FROM tbl_lot WHERE id_lot=?";
            $stmt = $conn->prepare($checkQuery);
            $stmt->bind_param("s", $id_lot);
            $stmt->execute();
            $stmt->bind_result($status, $ap);
            $stmt->fetch();
            $stmt->close();

            // Jika status adalah 'sedang dikerjakan' dan ap tidak kosong, lanjutkan pengecekan
            if ($status === 'sedang dikerjakan' && !empty($ap)) {
                $current_step = $i;
                $can_update = true;
                break;
            }

            $previous_status = $status;
        }

        if ($can_update && $current_step > 0) {
            // Lakukan pembaruan
            $status_column = "status$current_step";
            $tgl_selesai = "tanggal_selesai$current_step";
            $updateQuery = "UPDATE tbl_lot SET $status_column='sudah dikerjakan',$tgl_selesai=NOW() WHERE id_lot=?";
            $stmt = $conn->prepare($updateQuery);
            $stmt->bind_param("s", $id_lot);

            if ($stmt->execute()) {
                $response = array("status" => "success", "message" => "Status updated successfully");
            } else {
                $response = array("status" => "error", "message" => "Failed to update status: " . $stmt->error);
            }

            $stmt->close();
        } else {
            $response = array("status" => "error", "message" => "Tidak ada tahap yang sedang dikerjakan.");
        }
    } else {
        $response = array("status" => "error", "message" => "Connection failed: " . mysqli_connect_error());
    }

    $conn->close();
    echo json_encode($response);
} else {
    echo json_encode(array("status" => "error", "message" => "Metode yang digunakan bukan POST."));
}
?>
