import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notesapp/features/notes/domain/repositories/note_repository.dart';
import '../../../../core/errors/failures.dart';

class EditNoteUseCase {
  final NotesRepository repository;

  EditNoteUseCase(this.repository);

  Future<Either<Failure, void>> call(EditNoteParams params) async {
    return await repository.editNote(
      noteId: params.noteId,
      title: params.title,
      content: params.content,
      imagePath: params.imagePath,
    );
  }
}

class EditNoteParams extends Equatable {
  final String noteId;
  final String title;
  final String content;
  final String? imagePath;

  const EditNoteParams({
    required this.noteId,
    required this.title,
    required this.content,
    this.imagePath,
  });

  @override
  List<Object?> get props => [noteId, title, content, imagePath];
}
