import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/controller/auth/login_controller.dart';
import 'package:notesapp/core/class/handlingdataview.dart';
import 'package:notesapp/core/functions/alertexitapp.dart';
import 'package:notesapp/core/functions/validinptu.dart';
import 'package:notesapp/view/widget/auth/custombuttonauth.dart';
import 'package:notesapp/view/widget/auth/customtextbodyauth.dart';
import 'package:notesapp/view/widget/auth/customtextformauth.dart';
import 'package:notesapp/view/widget/auth/logoauth.dart';
import 'package:notesapp/view/widget/auth/textsignup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      body: PopScope(
        canPop: false,
        // ignore: deprecated_member_use
        onPopInvoked: (didPop) async {
          if (didPop) return;

          bool shouldExit = await alertExitApp();
          if (shouldExit) {}
        },
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    const LogoAuth(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    CustomTextBodyAuth(
                      text:
                          "يمكنك تسجيل الدخول من خلال البريد وكلمة المرور او من خلال وسائل التواصل الاجتماعي",
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormAuth(
                      isNumber: false,

                      valid: (val) {
                        return validInput(val!, 5, 100, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "ادخل البريد الالكتروني",
                      iconData: Icons.email_outlined,
                      labeltext: "البريد الإلكتروني",
                    ),
                    GetBuilder<LoginControllerImp>(
                      builder: (controller) => CustomTextFormAuth(
                        obscureText: controller.isshowpassword,
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 3, 30, "password");
                        },
                        mycontroller: controller.password,
                        hinttext: "ادخل كلمة المرور",
                        iconData: Icons.lock_outline,
                        labeltext: "كلمة المرور",
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "هل نسيت كلمة المرور",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    CustomButtomAuth(
                      text: "تسجيل الدخول",
                      onPressed: () {
                        controller.login();
                      },
                    ),
                    const SizedBox(height: 40),
                    CustomTextSignUpOrSignIn(
                      textone: "ليس لديك حساب",
                      texttwo: "إنشاء حساب",
                      onTap: () {
                        controller.goToSignUp();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
