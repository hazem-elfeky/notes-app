import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class GetNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final String title;
  final String content;
  final String? imagePath;

  const AddNoteEvent({
    required this.title,
    required this.content,
    this.imagePath,
  });

  @override
  List<Object?> get props => [title, content, imagePath];
}

class EditNoteEvent extends NotesEvent {
  final String noteId;
  final String title;
  final String content;
  final String? imagePath;

  const EditNoteEvent({
    required this.noteId,
    required this.title,
    required this.content,
    this.imagePath,
  });

  @override
  List<Object?> get props => [noteId, title, content, imagePath];
}

class DeleteNoteEvent extends NotesEvent {
  final String noteId;

  const DeleteNoteEvent(this.noteId);

  @override
  List<Object> get props => [noteId];
}
