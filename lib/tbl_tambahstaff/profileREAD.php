<?php
// Start the session to access session variables
session_start();

// Retrieve the NIP from the session
$nip = $_SESSION['nip'];

// Establish a connection to the database
$conn = mysqli_connect("localhost", "root", "", "db_rekachain");

// Query to retrieve data from the 'coba' table based on NIP
$query = "SELECT * FROM coba WHERE nip = '$nip'";
$result = mysqli_query($conn, $query);

// Display the data on the profile page
while ($row = mysqli_fetch_assoc($result)) {
    echo "Nama: " . $row['nama'] . "<br>";
    echo "NIP: " . $row['nip'] . "<br>";
    echo "Unit Kerja: " . $row['unit_kerja'] . "<br>";
    // Add other columns you want to display
}

// Close the database connection
mysqli_close($conn);
?>
