import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/widgets/handling_data_request.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_state.dart';
import 'package:notesapp/features/notes/presentation/widgets/notes_list.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NotesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is NotesLoading) {
          return const HandlingDataRequest(
            requestState: RequestState.loading,
            widget: SizedBox(),
          );
        }
        if (state is NotesLoaded) {
          if (state.notes.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد ملاحظات بعد، أضف أول ملاحظة الآن!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }
          return NoteList(notes: state.notes);
        }
        if (state is NotesError) {
          return HandlingDataRequest(
            requestState: RequestState.error,
            errorMessage: state.message,
            widget: const SizedBox(),
          );
        }
        return const Center(child: Text("حدث خطأ غير متوقع"));
      },
    );
  }
}
