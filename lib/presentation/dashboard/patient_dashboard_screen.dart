// lib/presentation/dashboard/patient_dashboard_screen.dart
import 'package:flutter/material.dart';

class PatientDashboardScreen extends StatefulWidget {
  @override
  _PatientDashboardScreenState createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  final String patientName = "John Doe";
  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      'doctorName': 'Dr. Smith',
      'specialty': 'Cardiologist',
      'time': '10:30 AM',
      'date': 'Today',
      'status': 'Confirmed',
    },
    {
      'doctorName': 'Dr. Johnson',
      'specialty': 'Dermatologist',
      'time': '2:15 PM',
      'date': 'Tomorrow',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2E),
        title: Text('DocPilot'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A3C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 25,
                      child: Text(
                        patientName.substring(0, 1),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, $patientName',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'You have 2 upcoming appointments',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickActionCard(
                    context,
                    Icons.calendar_today,
                    Colors.orange,
                    'Book\nAppointment',
                    () {},
                  ),
                  _buildQuickActionCard(
                    context,
                    Icons.description,
                    Colors.green,
                    'My\nPrescriptions',
                    () {},
                  ),
                  _buildQuickActionCard(
                    context,
                    Icons.medical_services,
                    Colors.purple,
                    'Medical\nRecords',
                    () {},
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Upcoming Appointments
              Text(
                'Upcoming Appointments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              // Appointment Cards
              ...upcomingAppointments.map(
                (appointment) => _buildAppointmentCard(appointment),
              ),

              SizedBox(height: 24),

              // Consultation History
              Text(
                'Recent Consultations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A3C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildConsultationItem(
                      'Dr. Williams',
                      'General Physician',
                      'March 15, 2025',
                      'Completed',
                    ),
                    Divider(color: Colors.grey[700]),
                    _buildConsultationItem(
                      'Dr. Garcia',
                      'ENT Specialist',
                      'March 10, 2025',
                      'Completed',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2A2A3C),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Consult'),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Prescriptions',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation here
        },
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF2A2A3C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    Color statusColor =
        appointment['status'] == 'Confirmed' ? Colors.green : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A3C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[700],
            child: Text(
              appointment['doctorName'].substring(3, 4),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['doctorName'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  appointment['specialty'],
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 4),
                    Text(
                      appointment['date'],
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[400]),
                    SizedBox(width: 4),
                    Text(
                      appointment['time'],
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              appointment['status'],
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationItem(
    String doctor,
    String specialty,
    String date,
    String status,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  specialty,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(status, style: TextStyle(color: Colors.green, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
