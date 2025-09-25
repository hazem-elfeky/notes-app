import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_event.dart';
import 'package:notesapp/features/notes/presentation/widgets/notes_appbar.dart';
import 'package:notesapp/features/notes/presentation/widgets/notes_body.dart';
import 'package:notesapp/features/notes/presentation/widgets/notes_fab.dart';

class NotesHomePage extends StatelessWidget {
  const NotesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<NotesBloc>()..add(GetNotesEvent()),
      child: const Scaffold(
        appBar: NotesAppBar(),
        floatingActionButton: NotesFAB(),
        body: NotesBody(),
      ),
    );
  }
}
