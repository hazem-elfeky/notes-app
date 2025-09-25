import 'package:flutter/material.dart';
import 'package:notesapp/features/notes/domain/entities/note_entity.dart';
import '../widgets/note_card.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  const NoteList({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          child: NoteCard(note: notes[index]),
        );
      },
    );
  }
}
