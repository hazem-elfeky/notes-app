import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/controller/notes/notes_controller.dart';
import 'package:notesapp/data/model/notemodel.dart';
import 'package:notesapp/linkapi.dart';
import 'package:notesapp/view/screen/notes/edit.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: note.notesImage != null && note.notesImage!.isNotEmpty
            ? Image.network(
                "${AppLink.linkImageRoot}/${note.notesImage}",
                width: 50,
                fit: BoxFit.cover,
              )
            : Icon(Icons.note, size: 40),
        title: Text(
          note.notesTitle ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(note.notesContent ?? ""),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Get.to(() => EditNotePage(note: note));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("تأكيد الحذف"),
                    content: const Text(
                      "هل أنت متأكد أنك تريد حذف هذه الملاحظة؟",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("إلغاء"),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.deleteNote(note.notesId!);
                          Navigator.of(context).pop();
                          Get.snackbar("تم الحذف", "تم حذف الملاحظة بنجاح");
                        },
                        child: const Text(
                          "حذف",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
