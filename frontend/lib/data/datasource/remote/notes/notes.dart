import 'package:notesapp/core/class/crud.dart';
import 'package:notesapp/linkapi.dart';

class NotesData {
  Crud crud;
  NotesData(this.crud);

  addNote(
    String title,
    String content,
    String userid, [
    String? imagename,
  ]) async {
    var response = await crud.postDataWithFile(AppLink.linkAddNotes, {
      "title": title,
      "content": content,
      "id": userid,
    }, file: imagename != null ? {"file": imagename} : null);
    return response.fold((l) => l, (r) => r);
  }

  viewNotes(String userid) async {
    var response = await crud.postData(AppLink.linkViewNotes, {"id": userid});
    return response.fold((l) => l, (r) => r);
  }

  editNote(
    String noteid,
    String title,
    String content, [
    String? imagename,
  ]) async {
    var response = await crud.postDataWithFile(AppLink.linkEditNotes, {
      "id": noteid,
      "title": title,
      "content": content,
    }, file: imagename != null ? {"file": imagename} : null);
    return response.fold((l) => l, (r) => r);
  }

  deleteNote(String noteid) async {
    var response = await crud.postData(AppLink.linkDeleteNotes, {"id": noteid});
    return response.fold((l) => l, (r) => r);
  }
}
