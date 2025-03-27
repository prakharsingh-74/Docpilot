import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:docpilot/presentation/splash_screen.dart';
import 'package:docpilot/services/app_theme.dart';
import 'package:appwrite/appwrite.dart';
import 'package:docpilot/presentation/dashboard/patient_dashboard_screen.dart';
import 'package:docpilot/presentation/dashboard/appointments_screen.dart';
import 'package:docpilot/presentation/consultation/patient_consultation_screen.dart';
import 'package:docpilot/presentation/prescriptions/patient_prescription_screen.dart';
import 'package:docpilot/presentation/profile/patient_profile_screen.dart';
import 'presentation/appointments/book_appointment_screen.dart';
import 'presentation/appointments/patient_appointments_screen.dart';
import 'presentation/appointments/doctor_appointments_screen.dart';

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
      routes: {
        '/patient_dashboard': (context) => PatientDashboardScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
        '/consult': (context) => const PatientConsultationScreen(),
        '/prescriptions': (context) => const PatientPrescriptionScreen(),
        '/profile': (context) => PatientProfileScreen(account: account),
        '/book-appointment':
            (context) => BookAppointmentScreen(account: account),
        '/patient-appointments':
            (context) => PatientAppointmentsScreen(account: account),
        '/doctor-appointments':
            (context) => DoctorAppointmentsScreen(account: account),
      },
    );
  }
}
