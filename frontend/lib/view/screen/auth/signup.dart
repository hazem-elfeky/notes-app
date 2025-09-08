import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/controller/auth/signup_controller.dart';
import 'package:notesapp/core/class/handlingdataview.dart';
import 'package:notesapp/core/constant/color.dart';
import 'package:notesapp/core/functions/alertexitapp.dart';
import 'package:notesapp/core/functions/validinptu.dart';
import 'package:notesapp/view/widget/auth/custombuttonauth.dart';
import 'package:notesapp/view/widget/auth/customtextbodyauth.dart';
import 'package:notesapp/view/widget/auth/customtextformauth.dart';
import 'package:notesapp/view/widget/auth/textsignup.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
      body: PopScope(
        onPopInvoked: (didPop) async {
          if (!didPop) {
            final shouldExit = await alertExitApp();
            if (shouldExit) {
              Navigator.of(context).pop();
            }
          }
        },
        child: GetBuilder<SignUpControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    CustomTextBodyAuth(
                      text:
                          "انشاء حساب من خلال البريد وكلمة المرور او من خلال وسائل التواصل الاجتماعي",
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 3, 20, "username");
                      },
                      mycontroller: controller.username,
                      hinttext: "ادخل اسم المستخدم",
                      iconData: Icons.person_outline,
                      labeltext: "اسم المستخدم",
                    ),
                    CustomTextFormAuth(
                      isNumber: false,

                      valid: (val) {
                        return validInput(val!, 3, 40, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "ادخل البريد الالكتروني",
                      iconData: Icons.email_outlined,
                      labeltext: "البريد الإلكتروني",
                    ),

                    CustomTextFormAuth(
                      isNumber: false,

                      valid: (val) {
                        return validInput(val!, 3, 30, "password");
                      },
                      mycontroller: controller.password,
                      hinttext: "ادخل كلمة المرور",
                      iconData: Icons.lock_outline,
                      labeltext: "كلمة المرور",
                    ),
                    CustomButtomAuth(
                      text: "إنشاء حساب",
                      onPressed: () {
                        controller.signUp();
                      },
                    ),
                    const SizedBox(height: 40),
                    CustomTextSignUpOrSignIn(
                      textone: "لديك حساب؟",
                      texttwo: "تسجيل الدخول",
                      onTap: () {
                        controller.goToSignIn();
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
