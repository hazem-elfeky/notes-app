import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/utils/validatrors.dart';
import 'package:notesapp/features/auth/presentation/auth_cubit/authcubit.dart';
import '../widgets/custom_text_body_auth.dart';
import '../widgets/custom_text_form_auth.dart';
import '../widgets/custom_button_auth.dart';
import '../widgets/custom_text_sign_up_or_sign_in.dart';
import 'package:notesapp/config/routes.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const CustomTextBodyAuth(
            text:
                "يمكنك تسجيل الدخول من خلال البريد وكلمة المرور أو من خلال وسائل التواصل الاجتماعي",
          ),
          const SizedBox(height: 20),
          CustomTextFormAuth(
            isNumber: false,
            valid: (val) => validInput(val!, 5, 100, "email"),
            mycontroller: emailController,
            hinttext: "ادخل البريد الالكتروني",
            iconData: Icons.email_outlined,
            labeltext: "البريد الإلكتروني",
          ),
          CustomTextFormAuth(
            isNumber: false,
            obscureText: true,
            valid: (val) => validInput(val!, 3, 30, "password"),
            mycontroller: passwordController,
            hinttext: "ادخل كلمة المرور",
            iconData: Icons.lock_outline,
            labeltext: "كلمة المرور",
          ),
          const SizedBox(height: 20),
          CustomButtonAuth(
            text: "تسجيل الدخول",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthCubit>().login(
                  emailController.text,
                  passwordController.text,
                );
              }
            },
          ),
          const SizedBox(height: 40),
          CustomTextSignUpOrSignIn(
            textone: "ليس لديك حساب",
            texttwo: "إنشاء حساب",
            onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
          ),
        ],
      ),
    );
  }
}
