import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/config/routes.dart';
import 'package:notesapp/core/widgets/handling_data_request.dart';
import 'package:notesapp/features/auth/presentation/auth_cubit/authcubit.dart';
import 'package:notesapp/features/auth/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _authListener,
        builder: _authBuilder,
      ),
    );
  }

  /// ===== Bloc Listener =====
  void _authListener(BuildContext context, AuthState state) {
    if (state.error != null) {
      _showErrorDialog(state.error!);
    }
    if (state.isLoggedIn) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.notesHome, (_) => false);
    }
  }

  /// ===== Bloc Builder =====
  Widget _authBuilder(BuildContext context, AuthState state) {
    return Scaffold(
      body: HandlingDataRequest(
        requestState: state.isLoading
            ? RequestState.loading
            : RequestState.success,
        widget: Padding(
          padding: const EdgeInsets.all(30),
          child: LoginForm(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
