import 'package:flutter/material.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import 'package:notesapp/features/notes/presentation/pages/add_notes_page.dart';
import 'package:notesapp/features/notes/presentation/pages/edit_notes_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/notes/presentation/pages/notes_home_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String notesHome = '/notes-home';
  static const String addNote = '/add-note';
  static const String editNote = '/edit-note';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case notesHome:
        return MaterialPageRoute(builder: (_) => const NotesHomePage());
      case addNote:
        return MaterialPageRoute(builder: (_) => const AddNotePage());
      case editNote:
        final note = settings.arguments as Note;
        return MaterialPageRoute(builder: (_) => EditNotePage(note: note));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
