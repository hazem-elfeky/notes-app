import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/class/statusrequest.dart';
import 'package:notesapp/core/constant/routes.dart';
import 'package:notesapp/core/functions/handingdatacontroller.dart';
import 'package:notesapp/data/datasource/remote/auth/signup.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;

  StatusRequest statusRequest = StatusRequest.none;

  SignupData signupData = SignupData(Get.find());

  List data = [];

  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await signupData.postdata(
        username.text,
        password.text,
        email.text,
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoute.login, arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
            title: "ُWarning",
            middleText: "Phone Number Or Email Already Exists",
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
