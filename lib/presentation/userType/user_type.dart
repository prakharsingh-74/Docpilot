import 'package:docpilot/presentation/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:docpilot/presentation/auth/login_screen.dart';
import 'package:appwrite/appwrite.dart';

class UserTypeScreen extends StatelessWidget {
  final Account account;
  const UserTypeScreen({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.medical_services_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to DocPilot',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(account: account),
                    ),
                  );
                },
                child: const Text('I am a Doctor'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(account: account),
                    ),
                  );
                },
                child: const Text('I am a Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
