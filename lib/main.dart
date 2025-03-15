import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:docpilot/presentation/splash_screen.dart';
import 'package:docpilot/services/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: DocPilotApp()));
}

class DocPilotApp extends StatelessWidget {
  const DocPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocPilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
