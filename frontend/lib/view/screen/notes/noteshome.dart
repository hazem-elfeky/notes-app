import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/controller/notes/notes_controller.dart';
import 'package:notesapp/core/class/statusrequest.dart';
import 'package:notesapp/view/screen/notes/add.dart';
import 'package:notesapp/view/widget/notes/notecard.dart';

class NotesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ملاحظاتي",
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

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNotePage()),
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: GetBuilder<NotesController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.notes.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد ملاحظات بعد، أضف أول ملاحظة الآن!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              final note = controller.notes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                child: NoteCard(note: note),
              );
            },
          );
        },
      ),
    );
  }
}
