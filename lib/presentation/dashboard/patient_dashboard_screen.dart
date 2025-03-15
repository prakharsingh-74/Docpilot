import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildMainOverview(),
            const SizedBox(height: 24),
            _buildHealthMetrics(),
            const SizedBox(height: 24),
            _buildAppointments(),
            const SizedBox(height: 24),
            _buildMedications(),
            const SizedBox(height: 24),
            _buildTestResults(),
            const SizedBox(height: 24),
            _buildCarePlan(),
            const SizedBox(height: 24),
            _buildCommunication(),
            const SizedBox(height: 24),
            _buildBillingAndInsurance(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/patient.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome, John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Patient ID: 12345'),
          ],
        ),
      ],
    );
  }

  Widget _buildMainOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.favorite, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  'Health Status: Good',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Next Appointment: March 20, 2025, 10:00 AM'),
            const SizedBox(height: 8),
            const Text('Medication Reminder: Take Aspirin at 2:00 PM'),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetrics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Health Metrics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 3),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement new measurement input
              },
              child: const Text('Input New Measurement'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointments() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('General Checkup'),
              subtitle: const Text('March 20, 2025, 10:00 AM'),
              trailing: const Icon(Icons.video_call),
            ),
            ListTile(
              title: const Text('Dental Cleaning'),
              subtitle: const Text('April 5, 2025, 2:00 PM'),
              trailing: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement appointment scheduling
              },
              child: const Text('Schedule New Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedications() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Medications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Aspirin'),
              subtitle: const Text('1 tablet daily'),
              trailing: ElevatedButton(
                onPressed: () {
                  // TODO: Implement refill request
                },
                child: const Text('Refill'),
              ),
            ),
            ListTile(
              title: const Text('Lisinopril'),
              subtitle: const Text('1 tablet twice daily'),
              trailing: ElevatedButton(
                onPressed: () {
                  // TODO: Implement refill request
                },
                child: const Text('Refill'),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Medication Adherence: 90%'),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResults() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Blood Glucose'),
              subtitle: const Text('95 mg/dL'),
              trailing: const Icon(Icons.arrow_downward, color: Colors.green),
            ),
            ListTile(
              title: const Text('Cholesterol'),
              subtitle: const Text('180 mg/dL'),
              trailing: const Icon(Icons.arrow_upward, color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement full history view
              },
              child: const Text('View Full History'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarePlan() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Care Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Progress: 70% towards weight loss goal'),
            const SizedBox(height: 8),
            const Text('Recommended: 30 minutes of daily exercise'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement educational content
              },
              child: const Text('View Educational Content'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunication() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Communication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement secure messaging
              },
              child: const Text('Message Healthcare Team'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement document upload
              },
              child: const Text('Upload Document or Image'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingAndInsurance() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billing and Insurance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Outstanding Balance: \$150.00'),
            const SizedBox(height: 8),
            const Text('Recent Transaction: \$50.00 paid on March 1, 2025'),
            const SizedBox(height: 8),
            const Text('Insurance: BlueCross BlueShield'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement claims status view
              },
              child: const Text('View Claims Status'),
            ),
          ],
        ),
      ),
    );
  }
}
