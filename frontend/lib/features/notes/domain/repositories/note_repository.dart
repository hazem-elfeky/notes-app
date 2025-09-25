import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getNotes(String userId);
  Future<Either<Failure, void>> addNote({
    required String title,
    required String content,
    required String userId,
    String? imagePath,
  });
  Future<Either<Failure, void>> editNote({
    required String noteId,
    required String title,
    required String content,
    String? imagePath,
  });
  Future<Either<Failure, void>> deleteNote(String noteId);
}
