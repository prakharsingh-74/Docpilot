import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:docpilot/presentation/splash_screen.dart';
import 'package:docpilot/services/app_theme.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject('67d65b7c000fbc5e7631');
  Account account = Account(client);

  runApp(ProviderScope(child: DocPilotApp(account: account)));
}

class DocPilotApp extends StatelessWidget {
  final Account account;
  const DocPilotApp({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocPilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(account: account),
    );
  }
}
