import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/notes/presentation/cubit/note_cubit.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/note_form.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteFormCubit(context.read<NotesBloc>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "إضافة ملاحظة",
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
            isEdit: false,
            onSave: () => context.read<NoteFormCubit>().addNote(context),
          ),
        ),
      ),
    );
  }
}
