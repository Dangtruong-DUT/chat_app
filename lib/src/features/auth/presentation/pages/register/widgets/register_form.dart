import 'package:chat_app/src/core/utils/validation/register.validation.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/shared/presentation/widgets/text-field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register_event.dart';

class RegisterForm extends StatefulWidget {
  final String? prefilledEmail;
  const RegisterForm({super.key, this.prefilledEmail});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
            hintText: 'Email',
            textInputType: TextInputType.emailAddress,
            validator: registerValidation['email'],
          ),

          const SizedBox(height: 16),

          TTextField(
            controller: _nameController,
            hintText: 'Name',
            textInputType: TextInputType.text,
            validator: registerValidation['name'],
          ),

          const SizedBox(height: 16),

          TTextField(
            controller: _passwordController,
            textInputType: TextInputType.visiblePassword,
            hintText: 'Password',
            validator: registerValidation['password'],
          ),

          const SizedBox(height: 16),

          GestureDetector(
            onTap: _onSubmit,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              constraints: const BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text;
    final name = _nameController.text;
    final password = _passwordController.text;

    context.read<RegisterBloc>().add(
      RegisterSubmitted(email: email, name: name, password: password),
    );
  }
}
