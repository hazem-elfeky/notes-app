import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notesapp/features/notes/domain/repositories/note_repository.dart';
import '../../../../core/errors/failures.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<Either<Failure, void>> call(AddNoteParams params) async {
    return await repository.addNote(
      title: params.title,
      content: params.content,
      userId: params.userId,
      imagePath: params.imagePath,
    );
  }
}

class AddNoteParams extends Equatable {
  final String title;
  final String content;
  final String userId;
  final String? imagePath;

  const AddNoteParams({
    required this.title,
    required this.content,
    required this.userId,
    this.imagePath,
  });

  @override
  List<Object?> get props => [title, content, userId, imagePath];
}
