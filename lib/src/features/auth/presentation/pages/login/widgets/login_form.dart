import 'package:chat_app/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:chat_app/src/shared/presentation/widgets/text-field.dart';
import 'package:chat_app/src/core/utils/validation/login.validation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final String? prefilledEmail;
  const LoginForm({super.key, this.prefilledEmail});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.prefilledEmail != null) {
      _emailController.text = widget.prefilledEmail!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TTextField(
            controller: _emailController,
            hintText: tr('form.email'),
            textInputType: TextInputType.emailAddress,
            validator: loginValidation['email'],
          ),

          const SizedBox(height: 16),

          TTextField(
            controller: _passwordController,
            textInputType: TextInputType.visiblePassword,
            hintText: tr('form.password'),
            validator: loginValidation['password'],
          ),

          const SizedBox(height: 16),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                current is LoginLoading || current is! LoginLoading,
            builder: (context, state) {
              final isLoading = state is LoginLoading;

              return GestureDetector(
                onTap: isLoading ? null : _onSubmit,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  constraints: BoxConstraints(minHeight: 50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            tr('auth.login.submit'),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text;
    final password = _passwordController.text;

    context.read<LoginBloc>().add(
      LoginSubmitted(email: email, password: password),
    );
  }
}
