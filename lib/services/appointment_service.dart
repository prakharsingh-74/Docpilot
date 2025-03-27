import 'package:appwrite/appwrite.dart';
import 'package:docpilot/models/appointment.dart';

class AppointmentService {
  final Databases _databases;
  final String _databaseId = '67d65b7c000fbc5e7631';
  final String _collectionId = 'appointments';

  AppointmentService(this._databases);

  Future<List<Appointment>> getPatientAppointments(String patientId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _collectionId,
        queries: [
          Query.equal('patientId', patientId),
          Query.orderDesc('dateTime'),
        ],
      );

      return response.documents
          .map((doc) => Appointment.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch patient appointments: $e');
    }
  }

  Future<List<Appointment>> getDoctorAppointments(String doctorId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _collectionId,
        queries: [
          Query.equal('doctorId', doctorId),
          Query.orderDesc('dateTime'),
        ],
      );

      return response.documents
          .map((doc) => Appointment.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch doctor appointments: $e');
    }
  }

  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final response = await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: ID.unique(),
        data: appointment.toJson(),
      );

      return Appointment.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  Future<Appointment> updateAppointmentStatus(
    String appointmentId,
    String status,
  ) async {
    try {
      final response = await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: appointmentId,
        data: {'status': status},
      );

      return Appointment.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: appointmentId,
      );
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }
}
