import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import 'package:notesapp/features/notes/domain/repositories/note_repository.dart';
import '../../../../core/errors/failures.dart';

class GetNotesUseCase {
  final NotesRepository repository;

  GetNotesUseCase(this.repository);

  Future<Either<Failure, List<Note>>> call(String userId) async {
    return await repository.getNotes(userId);
  }
}
