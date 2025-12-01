import 'package:chat_app/src/shared/presentation/widgets/text-field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TTextField(),
            const SizedBox(height: 16),
            TTextField(textInputType: TextInputType.visiblePassword),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                print("Login pressed");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                constraints: BoxConstraints(minHeight: 50),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Login',
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
      ),
    );
  }
}
