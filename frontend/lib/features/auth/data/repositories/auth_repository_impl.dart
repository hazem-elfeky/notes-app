import 'package:dartz/dartz.dart';
import 'package:notesapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:notesapp/features/auth/domain/entities/user_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.login(email: email, password: password);
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.signUp(
        username: username,
        email: email,
        password: password,
      );
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
