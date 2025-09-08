import 'package:get/get.dart';
import 'package:notesapp/core/class/statusrequest.dart';
import 'package:notesapp/core/functions/handingdatacontroller.dart';
import 'package:notesapp/core/services/services.dart';
import 'package:notesapp/data/datasource/remote/notes/notes.dart';
import 'package:notesapp/data/model/notemodel.dart';

class NotesController extends GetxController {
  NotesData notesData = NotesData(Get.find());
  MyServices myServices = Get.find();

  List<NoteModel> notes = [];
  StatusRequest statusRequest = StatusRequest.none;

  Future<void> getNotes() async {
    notes.clear();
    statusRequest = StatusRequest.loading;
    update();

    String userid = myServices.sharedPreferences.getString("id") ?? "0";
    var response = await notesData.viewNotes(userid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response["data"];
        notes.addAll(data.map((e) => NoteModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> addNote(
    String title,
    String content, {
    String? imagePath,
  }) async {
    statusRequest = StatusRequest.loading;
    update();

    String userid = myServices.sharedPreferences.getString("id") ?? "0";
    var response = await notesData.addNote(title, content, userid, imagePath);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response["status"] == "success") {
      getNotes();
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  Future<void> editNote(
    String noteid,
    String title,
    String content, {
    String? imagePath,
  }) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await notesData.editNote(noteid, title, content, imagePath);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response["status"] == "success") {
      getNotes();
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  Future<void> deleteNote(String noteid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await notesData.deleteNote(noteid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response["status"] == "success") {
      notes.removeWhere((note) => note.notesId == noteid);
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  void onInit() {
    getNotes();
    super.onInit();
  }
}
