import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/controller/notes/notes_controller.dart';
import 'package:notesapp/view/widget/notes/imagepicker.dart';

class AddNotePage extends StatelessWidget {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  String? _imagePath;

  AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة ملاحظة",
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
                  await controller.addNote(
                    _titleCtrl.text,
                    _contentCtrl.text,
                    imagePath: _imagePath,
                  );
                  Get.back();
                },
                child: const Text(
                  "حفظ الملاحظة",
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
