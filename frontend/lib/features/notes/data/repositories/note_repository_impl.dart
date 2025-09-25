import 'package:dartz/dartz.dart';
import 'package:notesapp/features/notes/data/datasources/note_remote_data_source.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import 'package:notesapp/features/notes/domain/repositories/note_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NotesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Note>>> getNotes(String userId) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getNotes(userId);
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> addNote({
    required String title,
    required String content,
    required String userId,
    String? imagePath,
  }) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.addNote(
        title: title,
        content: content,
        userId: userId,
        imagePath: imagePath,
      );
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> editNote({
    required String noteId,
    required String title,
    required String content,
    String? imagePath,
  }) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.editNote(
        noteId: noteId,
        title: title,
        content: content,
        imagePath: imagePath,
      );
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String noteId) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.deleteNote(noteId);
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
