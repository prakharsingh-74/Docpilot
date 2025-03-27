import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import '../../models/appointment.dart';
import '../../services/appointment_service.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  final Account account;

  const DoctorAppointmentsScreen({Key? key, required this.account})
    : super(key: key);

  @override
  State<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
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
      final appointments = await _appointmentService.getDoctorAppointments(
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

  Future<void> _updateAppointmentStatus(
    Appointment appointment,
    String status,
  ) async {
    try {
      await _appointmentService.updateAppointmentStatus(appointment.id, status);
      await _loadAppointments();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment status updated to $status')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating appointment status: ${e.toString()}'),
          ),
        );
      }
    }
  }

  void _showStatusUpdateDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Update Appointment Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Confirm'),
                  onTap: () {
                    Navigator.pop(context);
                    _updateAppointmentStatus(appointment, 'confirmed');
                  },
                ),
                ListTile(
                  title: const Text('Complete'),
                  onTap: () {
                    Navigator.pop(context);
                    _updateAppointmentStatus(appointment, 'completed');
                  },
                ),
                ListTile(
                  title: const Text('Cancel'),
                  onTap: () {
                    Navigator.pop(context);
                    _updateAppointmentStatus(appointment, 'cancelled');
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
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
                        'Patient ID: ${appointment.patientId}', // Replace with patient name
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
                                icon: const Icon(Icons.edit),
                                onPressed:
                                    () => _showStatusUpdateDialog(appointment),
                              )
                              : null,
                    ),
                  );
                },
              ),
    );
  }
}
