import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C2E),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue[300],
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildUpcomingAppointments(), _buildPastAppointments()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Appointments tab
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1C2E),
        selectedItemColor: Colors.blue[300],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Consult'),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Prescriptions',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          if (index != 1) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/patient_dashboard');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/consult');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/prescriptions');
                break;
              case 4:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        onPressed: () {
          _showBookAppointmentBottomSheet(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    // Mock data for upcoming appointments
    final upcomingAppointments = [
      {
        'doctorName': 'Dr. Sarah Wilson',
        'specialty': 'Cardiologist',
        'date': 'Today',
        'time': '2:30 PM',
        'status': 'Confirmed',
      },
      {
        'doctorName': 'Dr. Michael Brown',
        'specialty': 'Dermatologist',
        'date': 'Tomorrow',
        'time': '10:15 AM',
        'status': 'Pending',
      },
    ];

    return _buildAppointmentsList(upcomingAppointments);
  }

  Widget _buildPastAppointments() {
    // Mock data for past appointments
    final pastAppointments = [
      {
        'doctorName': 'Dr. John Smith',
        'specialty': 'General Physician',
        'date': 'March 15, 2024',
        'time': '3:00 PM',
        'status': 'Completed',
      },
      {
        'doctorName': 'Dr. Emily Davis',
        'specialty': 'Neurologist',
        'date': 'March 10, 2024',
        'time': '11:30 AM',
        'status': 'Completed',
      },
    ];

    return _buildAppointmentsList(pastAppointments);
  }

  Widget _buildAppointmentsList(List<Map<String, String>> appointments) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: const Color(0xFF2A2A3C),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[700],
              child: Text(
                appointment['doctorName']!.substring(4, 5),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              appointment['doctorName']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  appointment['specialty']!,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.blue[300],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${appointment['date']} at ${appointment['time']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(appointment['status']!).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                appointment['status']!,
                style: TextStyle(
                  color: _getStatusColor(appointment['status']!),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showBookAppointmentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A3C),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder:
                (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search doctors...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1A1C2E),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Available Doctors',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              color: const Color(0xFF1A1C2E),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[700],
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  'Dr. ${['Sarah Wilson', 'Michael Brown', 'John Smith', 'Emily Davis', 'Robert Johnson'][index]}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      [
                                        'Cardiologist',
                                        'Dermatologist',
                                        'General Physician',
                                        'Neurologist',
                                        'Orthopedic',
                                      ][index],
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.yellow[700],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${4.0 + (index * 0.2)}/5.0',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // TODO: Implement booking logic
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Appointment request sent!',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Book',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}
