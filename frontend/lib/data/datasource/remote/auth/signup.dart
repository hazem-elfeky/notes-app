import 'package:notesapp/core/class/crud.dart';
import 'package:notesapp/linkapi.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);
  postdata(String username, String password, String email) async {
    var response = await crud.postData(AppLink.linkSignUp, {
      "username": username,
      "password": password,
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
