import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await repository.signUp(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String username;
  final String email;
  final String password;

  const SignUpParams({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}
