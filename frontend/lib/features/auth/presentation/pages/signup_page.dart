import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/widgets/handling_data_request.dart';
import 'package:notesapp/config/routes.dart';
import 'package:notesapp/features/auth/presentation/auth_cubit/signup_form_cubit.dart';
import 'package:notesapp/features/auth/presentation/widgets/signup_form.dart';
import '../auth_cubit/authcubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('خطأ'),
                content: Text(state.error!),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('حسناً'),
                  ),
                ],
              ),
            );
          }
          if (state.isSignedUp) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
          }
        },
        builder: (context, state) {
          return BlocProvider(
            create: (_) => SignUpFormCubit(context.read<AuthCubit>()),
            child: Scaffold(
              body: HandlingDataRequest(
                requestState: state.isLoading
                    ? RequestState.loading
                    : RequestState.success,
                widget: const SignUpForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}
