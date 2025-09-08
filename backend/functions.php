<?php

define("MB", 1048576);

function filterRequest($requestname)
{
  return  htmlspecialchars(strip_tags($_POST[$requestname]));
}

function imageUpload($key) {
    if (!isset($_FILES[$key]) || $_FILES[$key]['error'] != 0) {
        return null;
    }

    $fileName  = $_FILES[$key]['name'];
    $tmpName   = $_FILES[$key]['tmp_name'];
    $ext       = pathinfo($fileName, PATHINFO_EXTENSION);
    $newName   = uniqid() . "." . $ext;
    $uploadDir = "../uploads/"; 
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    $destination = $uploadDir . $newName;
    if (move_uploaded_file($tmpName, $destination)) {
        return $newName;
    } else {
        return null; 
    }
}

function deleteFile($dir, $imagename)
{
  if (file_exists($dir . "/" . $imagename)) {
    unlink($dir . "/" . $imagename);
  }
}

