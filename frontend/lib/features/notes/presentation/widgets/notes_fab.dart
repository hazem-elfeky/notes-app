import 'package:flutter/material.dart';
import '../../../../config/routes.dart';

class NotesFAB extends StatelessWidget {
  const NotesFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, AppRoutes.addNote),
      backgroundColor: const Color(0xFF1976D2),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
