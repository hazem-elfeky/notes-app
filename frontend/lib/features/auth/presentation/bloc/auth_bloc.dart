import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/services/app_prefs.dart';
import 'package:notesapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:notesapp/features/auth/presentation/bloc/auth_state.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../config/routes.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final SharedPreferencesService sharedPreferencesService;
  final AppNavigator appNavigator;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.sharedPreferencesService,
    required this.appNavigator,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold((failure) => emit(AuthError(failure.message)), (user) async {
      await sharedPreferencesService.saveUserData(
        id: user.id,
        username: user.username,
        email: user.email,
      );
      emit(AuthSuccess(user));
    });
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signUpUseCase(
      SignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold((failure) => emit(AuthError(failure.message)), (_) {
      emit(SignUpSuccess());
      appNavigator.pushReplacementNamed(AppRoutes.login);
    });
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await sharedPreferencesService.clearUserData();
    appNavigator.pushNamedAndRemoveUntil(AppRoutes.login);
  }
}
