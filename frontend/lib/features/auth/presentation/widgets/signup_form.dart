import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/utils/validatrors.dart';
import 'package:notesapp/features/auth/presentation/auth_cubit/signup_form_cubit.dart';
import '../widgets/custom_text_body_auth.dart';
import '../widgets/custom_text_form_auth.dart';
import '../widgets/custom_button_auth.dart';
import '../widgets/custom_text_sign_up_or_sign_in.dart';
import '../../../../../config/routes.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpFormCubit>();

    return Form(
      key: cubit.formKey,
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const SizedBox(height: 20),
          const CustomTextBodyAuth(
            text:
                "إنشاء حساب باستخدام البريد وكلمة المرور أو من خلال وسائل التواصل",
          ),
          const SizedBox(height: 20),
          CustomTextFormAuth(
            isNumber: false,
            valid: (val) => validInput(val!, 3, 20, "username"),
            mycontroller: cubit.usernameController,
            hinttext: "ادخل اسم المستخدم",
            iconData: Icons.person_outline,
            labeltext: "اسم المستخدم",
          ),
          CustomTextFormAuth(
            isNumber: false,
            valid: (val) => validInput(val!, 3, 40, "email"),
            mycontroller: cubit.emailController,
            hinttext: "ادخل البريد الالكتروني",
            iconData: Icons.email_outlined,
            labeltext: "البريد الإلكتروني",
          ),
          CustomTextFormAuth(
            isNumber: false,
            obscureText: true,
            valid: (val) => validInput(val!, 3, 30, "password"),
            mycontroller: cubit.passwordController,
            hinttext: "ادخل كلمة المرور",
            iconData: Icons.lock_outline,
            labeltext: "كلمة المرور",
          ),
          const SizedBox(height: 20),
          CustomButtonAuth(
            text: "إنشاء حساب",
            onPressed: () => cubit.submit(context),
          ),
          const SizedBox(height: 40),
          CustomTextSignUpOrSignIn(
            textone: "لديك حساب؟",
            texttwo: "تسجيل الدخول",
            onTap: () => Navigator.pushNamed(context, AppRoutes.login),
          ),
        ],
      ),
    );
  }
}
