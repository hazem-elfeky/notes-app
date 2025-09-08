import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/class/statusrequest.dart';
import 'package:notesapp/core/constant/routes.dart';
import 'package:notesapp/core/functions/handingdatacontroller.dart';
import 'package:notesapp/core/services/services.dart';
import 'package:notesapp/data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.postdata(email.text, password.text);
      print("LOGIN RESPONSE: $response");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          myServices.sharedPreferences.setString(
            "id",
            response['data']['id'].toString(),
          );
          myServices.sharedPreferences.setString(
            "username",
            response['data']['username'],
          );
          myServices.sharedPreferences.setString(
            "email",
            response['data']['email'],
          );

          myServices.sharedPreferences.setString("step", "1");

          print(
            "STEP SAVED: ${myServices.sharedPreferences.getString("step")}",
          );

          Get.offNamed(AppRoute.noteshome);
        } else {
          Get.defaultDialog(
            title: "Warning",
            middleText: "Email Or Password Not Correct",
          );
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
