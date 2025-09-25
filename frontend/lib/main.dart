import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/di/injection_container.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'core/middleware/auth_middleware.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/notes/presentation/bloc/notes_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<NotesBloc>(create: (context) => getIt<NotesBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: appTheme,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.generateRoute,
        home: const AuthMiddleware(),
      ),
    );
  }
}
