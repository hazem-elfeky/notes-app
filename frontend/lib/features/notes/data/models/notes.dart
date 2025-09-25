import 'package:notesapp/features/notes/domain/entities/note_entity.dart';

class NoteModel extends Note {
  const NoteModel({
    required String id,
    required String title,
    required String content,
    String? image,
    required String userId,
  }) : super(
         id: id,
         title: title,
         content: content,
         image: image,
         userId: userId,
       );

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['notes_id']?.toString() ?? '',
      title: json['notes_title'] ?? '',
      content: json['notes_content'] ?? '',
      image: json['notes_image'] ?? '',
      userId: json['notes_users']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes_id': id,
      'notes_title': title,
      'notes_content': content,
      'notes_image': image,
      'notes_users': userId,
    };
  }
}
