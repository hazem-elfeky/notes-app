<?php

include "../connect.php";

$noteid = filterRequest("id"); 

$stmtGet = $con->prepare("SELECT notes_image FROM notes WHERE notes_id = ?");
$stmtGet->execute([$noteid]);
$note = $stmtGet->fetch(PDO::FETCH_ASSOC);

$stmt = $con->prepare("DELETE FROM `notes` WHERE notes_id = ?");
$stmt->execute([$noteid]);

if ($stmt->rowCount() > 0) {
    if (!empty($note['notes_image'])) {
        deleteFile("../upload", $note['notes_image']);
    }
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "fail"]);
}
