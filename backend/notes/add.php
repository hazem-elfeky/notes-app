<?php
include "../connect.php";




$title   = filterRequest("title");
$content = filterRequest("content");
$userid  = filterRequest("id");
$imagename = imageUpload("file"); 

if (!$title || !$content || !$userid) {
    echo json_encode([
        "status" => "fail",
        "message" => "Missing required fields"
    ]);
    exit;
}

$stmt = $con->prepare("INSERT INTO `notes` (`notes_title`, `notes_content`, `notes_user`, `notes_image`) VALUES (?, ?, ?, ?)");
$success = $stmt->execute([$title, $content, $userid, $imagename]);

if ($success) {
    echo json_encode([
        "status" => "success",
        "message" => "Note added successfully"
    ]);
} else {
    echo json_encode([
        "status" => "fail",
        "message" => "Failed to add note"
    ]);
}
