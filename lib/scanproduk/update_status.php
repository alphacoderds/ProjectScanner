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

            // Jika status kosong dan ap tidak kosong, lanjutkan pengecekan
            if (empty($status) && !empty($ap)) {
                $current_step = $i;
                // Jika tahap pertama atau tahap sebelumnya sudah dikerjakan, izinkan update
                if ($i == 1 || $previous_status == 'sudah dikerjakan') {
                    $can_update = true;
                    break;
                }
            }

            $previous_status = $status;
        }

        if ($can_update && $current_step > 0) {
            // Lakukan pembaruan
            $status_column = "status$current_step";
            $nip_column = "nip$current_step";
            $tgl_column = "tanggal_mulai$current_step";
            $d=mktime(11, 14, 54, 8, 12, 2014);
            $date = date("Y-m-d h:i:s");
            $updateQuery = "UPDATE tbl_lot SET $status_column='sedang dikerjakan', $nip_column=?, $tgl_column=NOW() WHERE id_lot=?";
            $stmt = $conn->prepare($updateQuery);
            $stmt->bind_param("ss", $nip, $id_lot);

            if ($stmt->execute()) {
                $response = array("status" => "success", "message" => "Status updated successfully");
            } else {
                $response = array("status" => "error", "message" => "Failed to update status: " . $stmt->error);
            }

            $stmt->close();
        } else {
            $response = array("status" => "error", "message" => "Tidak ada tahap yang dapat diperbarui atau tahap sebelumnya belum selesai.", "id" => "$id_lot");
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
