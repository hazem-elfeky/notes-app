import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/domain/repositories/note_repository.dart';
import '../../../../core/errors/failures.dart';

class DeleteNoteUseCase {
  final NotesRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<Either<Failure, void>> call(String noteId) async {
    return await repository.deleteNote(noteId);
  }
}
