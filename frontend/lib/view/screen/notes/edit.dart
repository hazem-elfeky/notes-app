import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/controller/notes/notes_controller.dart';
import 'package:notesapp/data/model/notemodel.dart';
import 'package:notesapp/linkapi.dart';
import 'package:notesapp/view/widget/notes/imagepicker.dart';

class EditNotePage extends StatelessWidget {
  final NoteModel note;
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  String? _imagePath;

  EditNotePage({Key? key, required this.note}) : super(key: key) {
    _titleCtrl.text = note.notesTitle ?? "";
    _contentCtrl.text = note.notesContent ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تعديل الملاحظة",
          style: TextStyle(fontWeight: FontWeight.bold),
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

      body: GetBuilder<NotesController>(
        builder: (controller) => SingleChildScrollView(
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
                  controller: _titleCtrl,
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
                  controller: _contentCtrl,
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

              if ((note.notesImage != null && note.notesImage!.isNotEmpty) &&
                  _imagePath == null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "${AppLink.linkImageRoot}/${note.notesImage}",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 15),

              ImagePickerWidget(
                onImageSelected: (file) {
                  _imagePath = file?.path;
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
                onPressed: () async {
                  await controller.editNote(
                    note.notesId!,
                    _titleCtrl.text,
                    _contentCtrl.text,
                    imagePath: _imagePath,
                  );
                  Get.back();
                },
                child: const Text(
                  "حفظ التعديلات",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
