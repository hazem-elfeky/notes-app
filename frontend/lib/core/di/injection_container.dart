import 'package:get_it/get_it.dart';
import 'package:notesapp/core/services/app_prefs.dart';
import 'package:notesapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:notesapp/features/notes/data/datasources/note_remote_data_source.dart';
import 'package:notesapp/features/notes/data/repositories/note_repository_impl.dart';
import 'package:notesapp/features/notes/domain/repositories/note_repository.dart';
import 'package:notesapp/features/notes/domain/usecases/get_all_notes_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../network/api_client.dart';
import '../network/network_info.dart';
import '../navigation/app_navigator.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/notes/domain/usecases/add_note_usecase.dart';
import '../../features/notes/domain/usecases/edit_note_usecase.dart';
import '../../features/notes/domain/usecases/delete_note_usecase.dart';
import '../../features/notes/presentation/bloc/notes_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => Connectivity());

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));
  getIt.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(getIt()),
  );
  getIt.registerLazySingleton<AppNavigator>(() => AppNavigator());

  // Auth Feature
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt(),
      signUpUseCase: getIt(),
      sharedPreferencesService: getIt(),
      appNavigator: getIt(),
    ),
  );

  // Notes Feature
  getIt.registerLazySingleton<NotesRemoteDataSource>(
    () => NotesRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerLazySingleton(() => GetNotesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => EditNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteNoteUseCase(getIt()));
  getIt.registerFactory(
    () => NotesBloc(
      getNotesUseCase: getIt(),
      addNoteUseCase: getIt(),
      editNoteUseCase: getIt(),
      deleteNoteUseCase: getIt(),
      sharedPreferencesService: getIt(),
    ),
  );
}
