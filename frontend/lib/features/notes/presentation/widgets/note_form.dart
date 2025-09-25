import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/notes/presentation/cubit/note_cubit.dart';
import 'package:notesapp/features/notes/presentation/widgets/image_picker_widget.dart';

class NoteForm extends StatelessWidget {
  final bool isEdit;
  final VoidCallback onSave;

  const NoteForm({Key? key, required this.isEdit, required this.onSave})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteFormCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: TextField(
              controller: cubit.titleController,
              decoration: const InputDecoration(
                hintText: "عنوان الملاحظة",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: TextField(
              controller: cubit.contentController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "محتوى الملاحظة",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ImagePickerWidget(
            onImageSelected: (file) {
              cubit.imagePath = file?.path;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: const Color(0xFF1976D2),
              elevation: 5,
            ),
            onPressed: onSave,
            child: Text(
              isEdit ? "حفظ التعديلات" : "حفظ الملاحظة",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
