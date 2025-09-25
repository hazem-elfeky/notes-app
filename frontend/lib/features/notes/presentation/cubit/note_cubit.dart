import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_event.dart';

class NoteFormCubit extends Cubit<void> {
  final NotesBloc notesBloc;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String? imagePath;

  NoteFormCubit(this.notesBloc) : super(null);

  bool validate(BuildContext context) {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى ملء جميع الحقول"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  void addNote(BuildContext context) {
    if (!validate(context)) return;
    notesBloc.add(
      AddNoteEvent(
        title: titleController.text,
        content: contentController.text,
        imagePath: imagePath,
      ),
    );
    Navigator.pop(context);
  }

  void editNote(BuildContext context, String noteId) {
    if (!validate(context)) return;
    notesBloc.add(
      EditNoteEvent(
        noteId: noteId,
        title: titleController.text,
        content: contentController.text,
        imagePath: imagePath,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    return super.close();
  }
}
