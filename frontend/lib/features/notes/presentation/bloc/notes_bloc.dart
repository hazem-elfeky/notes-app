import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/services/app_prefs.dart';
import 'package:notesapp/features/notes/domain/usecases/get_all_notes_usecase.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_event.dart';
import 'package:notesapp/features/notes/presentation/bloc/notes_state.dart';

import '../../domain/usecases/add_note_usecase.dart';
import '../../domain/usecases/edit_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final EditNoteUseCase editNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final SharedPreferencesService sharedPreferencesService;

  NotesBloc({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.editNoteUseCase,
    required this.deleteNoteUseCase,
    required this.sharedPreferencesService,
  }) : super(NotesInitial()) {
    on<GetNotesEvent>(_onGetNotes);
    on<AddNoteEvent>(_onAddNote);
    on<EditNoteEvent>(_onEditNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onGetNotes(
    GetNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());

    final userId = sharedPreferencesService.getUserId() ?? '0';
    final result = await getNotesUseCase(userId);

    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes)),
    );
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());

    final userId = sharedPreferencesService.getUserId() ?? '0';
    final result = await addNoteUseCase(
      AddNoteParams(
        title: event.title,
        content: event.content,
        userId: userId,
        imagePath: event.imagePath,
      ),
    );

    result.fold((failure) => emit(NotesError(failure.message)), (_) {
      emit(NoteOperationSuccess());
      add(GetNotesEvent());
    });
  }

  Future<void> _onEditNote(
    EditNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());

    final result = await editNoteUseCase(
      EditNoteParams(
        noteId: event.noteId,
        title: event.title,
        content: event.content,
        imagePath: event.imagePath,
      ),
    );

    result.fold((failure) => emit(NotesError(failure.message)), (_) {
      emit(NoteOperationSuccess());
      add(GetNotesEvent());
    });
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());

    final result = await deleteNoteUseCase(event.noteId);

    result.fold((failure) => emit(NotesError(failure.message)), (_) {
      emit(NoteOperationSuccess());
      add(GetNotesEvent());
    });
  }
}
