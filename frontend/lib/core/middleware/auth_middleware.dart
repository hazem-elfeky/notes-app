import 'package:flutter/material.dart';
import 'package:notesapp/core/di/injection_container.dart';
import 'package:notesapp/core/services/app_prefs.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/notes/presentation/pages/notes_home_page.dart';

class AuthMiddleware extends StatelessWidget {
  const AuthMiddleware({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = getIt<SharedPreferencesService>();

    if (sharedPreferencesService.isLoggedIn) {
      return const NotesHomePage();
    } else {
      return const LoginPage();
    }
  }
}
