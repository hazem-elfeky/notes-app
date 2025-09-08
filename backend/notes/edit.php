<?php

include "../connect.php";

$noteid   = filterRequest("id");
$title    = filterRequest("title");
$content  = filterRequest("content");

$stmtGet = $con->prepare("SELECT notes_image FROM notes WHERE notes_id = ?");
$stmtGet->execute([$noteid]);
$note = $stmtGet->fetch(PDO::FETCH_ASSOC);
$imagename = $note['notes_image'] ?? null;

if (isset($_FILES['file']) && $_FILES['file']['error'] == 0) {
    if (!empty($imagename)) {
        deleteFile("../upload", $imagename);
    }
    $imagename = imageUpload("file");
}

$stmt = $con->prepare("UPDATE `notes` SET 
 `notes_title` = ?, 
 `notes_content` = ?, 
 `notes_image` = ? 
 WHERE notes_id = ?
");
$stmt->execute([$title, $content, $imagename, $noteid]);

if ($stmt->rowCount() > 0) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "fail"]);
}
