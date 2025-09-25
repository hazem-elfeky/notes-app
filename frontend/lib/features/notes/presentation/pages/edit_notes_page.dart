import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import 'package:notesapp/features/notes/presentation/cubit/note_cubit.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/note_form.dart';

class EditNotePage extends StatelessWidget {
  final Note note;
  const EditNotePage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = NoteFormCubit(context.read<NotesBloc>());
        cubit.titleController.text = note.title;
        cubit.contentController.text = note.content;
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "تعديل الملاحظة",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Builder(
          builder: (context) => NoteForm(
            isEdit: true,
            onSave: () =>
                context.read<NoteFormCubit>().editNote(context, note.id),
          ),
        ),
      ),
    );
  }
}
