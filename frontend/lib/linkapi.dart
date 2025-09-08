class AppLink {
  static const String linkServerName = "http://10.0.2.2:8080/nootes";
  static const String linkImageRoot = "http://10.0.2.2:8080/nootes/upload";
  // Auth
  static const String linkSignUp = "$linkServerName/auth/signup.php";
  static const String linkLogin = "$linkServerName/auth/login.php";
  // Note
  static const String linkViewNotes = "$linkServerName/notes/view.php";
  static const String linkAddNotes = "$linkServerName/notes/add.php";
  static const String linkEditNotes = "$linkServerName/notes/edit.php";
  static const String linkDeleteNotes = "$linkServerName/notes/delete.php";
}
