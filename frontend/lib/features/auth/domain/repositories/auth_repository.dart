import 'package:dartz/dartz.dart';
import 'package:notesapp/features/auth/domain/entities/user_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signUp({
    required String username,
    required String email,
    required String password,
  });
}
