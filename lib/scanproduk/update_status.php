<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_lot = $_POST['id_lot'];
    $nip = $_POST['nip'];
    $conn = mysqli_connect("localhost", "root", "", "db_rekachain");

    if ($conn) {
        // Logika untuk memeriksa status tahap sebelumnya
        $can_update = false;
        $current_step = 0;  // Untuk melacak tahap yang akan diperbarui

        // Periksa setiap kolom status dari status1 hingga status10
        for ($i = 1; $i <= 10; $i++) {
            $status_column = "status$i";
            $checkQuery = "SELECT $status_column FROM tbl_lot WHERE id_lot=?";
            $stmt = $conn->prepare($checkQuery);
            $stmt->bind_param("s", $id_lot);
            $stmt->execute();
            $stmt->bind_result($status);
            $stmt->fetch();
            $stmt->close();

            if (empty($status)) {
                $current_step = $i;
                if ($i == 1 || $i == 2 || ($i > 2 && $previous_status == 'sudah dikerjakan')) {
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
            $updateQuery = "UPDATE tbl_lot SET $status_column='sedang dikerjakan', $nip_column=? WHERE id_lot=?";
            $stmt = $conn->prepare($updateQuery);
            $stmt->bind_param("ss", $nip, $id_lot);

            if ($stmt->execute()) {
                $response = array("status" => "success", "message" => "Status updated successfully");
            } else {
                $response = array("status" => "error", "message" => "Failed to update status: " . $stmt->error);
            }

            $stmt->close();
        } else {
            $response = array("status" => "error", "message" => "Tidak ada tahap yang dapat diperbarui atau tahap sebelumnya belum selesai.");
        }
    } else {
        $response = array("status" => "error", "message" => "Connection failed: " . mysqli_connect_error());
    }

    $conn->close();
    echo json_encode($response);
} else {
    echo json_encode(array("status" => "error", "message" => "Metode yang digunakan bukan POST."));
}

// cek null kolom status
?>

