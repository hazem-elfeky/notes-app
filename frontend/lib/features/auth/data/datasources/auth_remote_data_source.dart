import 'package:dartz/dartz.dart';
import '../../../../config/app_links.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signUp({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await apiClient.postData(AppLinks.linkLogin, {
      'email': email,
      'password': password,
    });

    return result.fold((failure) => Left(failure), (response) {
      if (response['status'] == 'success') {
        final userModel = UserModel.fromJson(response['data']);
        return Right(userModel);
      } else {
        return Left(ServerFailure('Email Or Password Not Correct'));
      }
    });
  }

  @override
  Future<Either<Failure, void>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await apiClient.postData(AppLinks.linkSignUp, {
      'username': username,
      'email': email,
      'password': password,
    });

    return result.fold((failure) => Left(failure), (response) {
      if (response['status'] == 'success') {
        return const Right(null);
      } else {
        return Left(ServerFailure('Phone Number Or Email Already Exists'));
      }
    });
  }
}
