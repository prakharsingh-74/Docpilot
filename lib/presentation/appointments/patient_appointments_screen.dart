import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../../models/appointment.dart';
import '../../services/appointment_service.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  final Account account;

  const PatientAppointmentsScreen({Key? key, required this.account})
    : super(key: key);

  @override
  State<PatientAppointmentsScreen> createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  late final AppointmentService _appointmentService;
  List<Appointment> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _appointmentService = AppointmentService(Databases(widget.account.client));
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final user = await widget.account.get();
      final appointments = await _appointmentService.getPatientAppointments(
        user.$id,
      );
      setState(() {
        _appointments = appointments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading appointments: ${e.toString()}'),
          ),
        );
      }
    }
  }

  Future<void> _cancelAppointment(Appointment appointment) async {
    try {
      await _appointmentService.updateAppointmentStatus(
        appointment.id,
        'cancelled',
      );
      await _loadAppointments();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment cancelled successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error cancelling appointment: ${e.toString()}'),
          ),
        );
      }
    }
  }

  void _showCancelDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancel Appointment'),
            content: const Text(
              'Are you sure you want to cancel this appointment?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _cancelAppointment(appointment);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAppointments,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _appointments.isEmpty
              ? const Center(child: Text('No appointments found'))
              : ListView.builder(
                itemCount: _appointments.length,
                itemBuilder: (context, index) {
                  final appointment = _appointments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(
                        'Appointment with Dr. ${appointment.doctorId}', // Replace with doctor name
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}',
                          ),
                          Text(
                            'Time: ${appointment.dateTime.hour}:${appointment.dateTime.minute.toString().padLeft(2, '0')}',
                          ),
                          Text('Type: ${appointment.type}'),
                          Text('Status: ${appointment.status}'),
                          if (appointment.notes.isNotEmpty)
                            Text('Notes: ${appointment.notes}'),
                        ],
                      ),
                      trailing:
                          appointment.status == 'pending'
                              ? IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () => _showCancelDialog(appointment),
                              )
                              : null,
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/book-appointment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
