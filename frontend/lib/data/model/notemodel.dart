class NoteModel {
  String? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  String? notesUsers;

  NoteModel({
    this.notesId,
    this.notesTitle,
    this.notesContent,
    this.notesImage,
    this.notesUsers,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id']?.toString();
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'] ?? "";
    notesUsers = json['notes_users']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['notes_id'] = notesId;
    data['notes_title'] = notesTitle;
    data['notes_content'] = notesContent;
    if (notesImage != null && notesImage!.isNotEmpty) {
      data['notes_image'] = notesImage;
    }
    data['notes_users'] = notesUsers;
    return data;
  }
}
