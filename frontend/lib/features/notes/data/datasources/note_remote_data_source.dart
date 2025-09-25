import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/data/models/notes.dart';
import '../../../../config/app_links.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';

abstract class NotesRemoteDataSource {
  Future<Either<Failure, List<NoteModel>>> getNotes(String userId);
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

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  final ApiClient apiClient;

  NotesRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Failure, List<NoteModel>>> getNotes(String userId) async {
    final result = await apiClient.postData(AppLinks.linkViewNotes, {
      'id': userId,
    });

    return result.fold((failure) => Left(failure), (response) {
      if (response['status'] == 'success') {
        final List<dynamic> data = response['data'];
        final notes = data.map((e) => NoteModel.fromJson(e)).toList();
        return Right(notes);
      } else {
        return Left(ServerFailure('Failed to get notes'));
      }
    });
  }

  @override
  Future<Either<Failure, void>> addNote({
    required String title,
    required String content,
    required String userId,
    String? imagePath,
  }) async {
    final result = await apiClient.postDataWithFile(AppLinks.linkAddNotes, {
      'title': title,
      'content': content,
      'id': userId,
    }, files: imagePath != null ? {'file': imagePath} : null);

    return result.fold((failure) => Left(failure), (response) {
      if (response['status'] == 'success') {
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to add note'));
      }
    });
  }

  @override
  Future<Either<Failure, void>> editNote({
    required String noteId,
    required String title,
    required String content,
    String? imagePath,
  }) async {
    final result = await apiClient.postDataWithFile(AppLinks.linkEditNotes, {
      'id': noteId,
      'title': title,
      'content': content,
    }, files: imagePath != null ? {'file': imagePath} : null);

    return result.fold((failure) => Left(failure), (response) {
      if (response['status'] == 'success') {
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to edit note'));
      }
    });
  }

  @override
  Future<Either<Failure, void>> deleteNote(String noteId) async {
    final result = await apiClient.postData(AppLinks.linkDeleteNotes, {
      'id': noteId,
    });

    return result.fold((failure) => Left(failure), (response) {
      if (response['status'] == 'success') {
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to delete note'));
      }
    });
  }
}
