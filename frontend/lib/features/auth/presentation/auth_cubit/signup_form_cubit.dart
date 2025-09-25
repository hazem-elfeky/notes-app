import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_cubit/authcubit.dart';

class SignUpFormCubit extends Cubit<void> {
  final AuthCubit authCubit;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpFormCubit(this.authCubit) : super(null);

  void submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      authCubit.signUp(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
