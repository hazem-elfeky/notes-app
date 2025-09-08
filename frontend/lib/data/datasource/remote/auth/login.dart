import 'package:notesapp/core/class/crud.dart';
import 'package:notesapp/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  postdata(String email, String password) async {
    var response = await crud.postData(AppLink.linkLogin, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
