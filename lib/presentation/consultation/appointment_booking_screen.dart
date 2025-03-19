// lib/presentation/consultation/appointment_booking_screen.dart
import 'package:flutter/material.dart';

class AppointmentBookingScreen extends StatefulWidget {
  @override
  _AppointmentBookingScreenState createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  String selectedTime = '10:00 AM';
  String selectedDoctor = '';
  String selectedConsultationType = 'Video Consultation';
  final TextEditingController _reasonController = TextEditingController();

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Smith',
      'specialty': 'Cardiologist',
      'experience': '15 years',
      'rating': 4.8,
      'image': 'assets/doctor1.png',
      'available': true,
    },
    {
      'name': 'Dr. Johnson',
      'specialty': 'Dermatologist',
      'experience': '10 years',
      'rating': 4.6,
      'image': 'assets/doctor2.png',
      'available': true,
    },
    {
      'name': 'Dr. Williams',
      'specialty': 'General Physician',
      'experience': '12 years',
      'rating': 4.7,
      'image': 'assets/doctor3.png',
      'available': false,
    },
    {
      'name': 'Dr. Garcia',
      'specialty': 'ENT Specialist',
      'experience': '8 years',
      'rating': 4.5,
      'image': 'assets/doctor4.png',
      'available': true,
    },
  ];

  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
  ];

  final List<String> consultationTypes = [
    'Video Consultation',
    'In-person Visit',
    'Audio Call',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2E),
        title: Text('Book Appointment'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Selection
              Text(
                'Select Doctor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    final isSelected = selectedDoctor == doctor['name'];
                    final isAvailable = doctor['available'];

                    return GestureDetector(
                      onTap:
                          isAvailable
                              ? () {
                                setState(() {
                                  selectedDoctor = doctor['name'];
                                });
                              }
                              : null,
                      child: Container(
                        width: 160,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue.withOpacity(0.2)
                                  : Color(0xFF2A2A3C),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              isSelected
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : null,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey[800],
                                  child: Text(
                                    doctor['name'].substring(3, 4),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (!isAvailable)
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Unavailable',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              doctor['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              doctor['specialty'],
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  doctor['rating'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 24),

              // Consultation Type
              Text(
                'Consultation Type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: consultationTypes.length,
                  itemBuilder: (context, index) {
                    final type = consultationTypes[index];
                    final isSelected = selectedConsultationType == type;
                    IconData icon;

                    if (type == 'Video Consultation') {
                      icon = Icons.videocam;
                    } else if (type == 'In-person Visit') {
                      icon = Icons.person;
                    } else {
                      icon = Icons.phone;
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedConsultationType = type;
                        });
                      },
                      child: Container(
                        width: 120,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue.withOpacity(0.2)
                                  : Color(0xFF2A2A3C),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              isSelected
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              type,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 24),

              // Date Selection
              Text(
                'Select Date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              Container(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final date = DateTime.now().add(Duration(days: index));
                    final isSelected =
                        selectedDate.day == date.day &&
                        selectedDate.month == date.month &&
                        selectedDate.year == date.year;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue.withOpacity(0.2)
                                  : Color(0xFF2A2A3C),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              isSelected
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              [
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Sun',
                              ][date.weekday - 1],
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 24),

              // Time Selection
              Text(
                'Select Time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    timeSlots.map((time) {
                      final isSelected = selectedTime == time;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                        child: Container(
                          width: 90,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.blue.withOpacity(0.2)
                                    : Color(0xFF2A2A3C),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                isSelected
                                    ? Border.all(color: Colors.blue, width: 2)
                                    : null,
                          ),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isSelected ? Colors.blue : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),

              SizedBox(height: 24),

              // Reason for visit
              Text(
                'Reason for Visit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              TextField(
                controller: _reasonController,
                style: TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      'Briefly describe your symptoms or reason for consultation',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Color(0xFF2A2A3C),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),

              SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  // Book appointment logic
                  // Navigate back to dashboard
                  Navigator.pop(context);
                },
                child: Text('Book Appointment', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
