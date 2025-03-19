import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientPrescriptionScreen extends StatefulWidget {
  const PatientPrescriptionScreen({Key? key}) : super(key: key);

  @override
  _PatientPrescriptionScreenState createState() =>
      _PatientPrescriptionScreenState();
}

class _PatientPrescriptionScreenState extends State<PatientPrescriptionScreen> {
  final List<Map<String, dynamic>> prescriptions = [
    {
      'id': 'PRE-001',
      'doctor': 'Dr. Smith',
      'date': 'March 15, 2025',
      'diagnosis': 'Seasonal Allergic Rhinitis',
      'medications': [
        {
          'name': 'Loratadine',
          'dosage': '10mg',
          'frequency': 'Once daily',
          'duration': '7 days',
          'instructions': 'Take in the morning',
        },
        {
          'name': 'Fluticasone Nasal Spray',
          'dosage': '50mcg',
          'frequency': 'Twice daily',
          'duration': '7 days',
          'instructions': 'One spray in each nostril',
        },
      ],
      'advice':
          'Avoid allergens, increase fluid intake, and follow up if symptoms persist beyond 7 days.',
      'tests': ['Complete Blood Count if symptoms persist'],
    },
    {
      'id': 'PRE-002',
      'doctor': 'Dr. Johnson',
      'date': 'March 10, 2025',
      'diagnosis': 'Acute Bacterial Sinusitis',
      'medications': [
        {
          'name': 'Amoxicillin',
          'dosage': '500mg',
          'frequency': 'Three times daily',
          'duration': '10 days',
          'instructions': 'Take with food',
        },
        {
          'name': 'Acetaminophen',
          'dosage': '500mg',
          'frequency': 'As needed for pain',
          'duration': 'Max 4 tablets daily',
          'instructions': 'Take for fever or pain',
        },
      ],
      'advice':
          'Complete the full course of antibiotics. Use steam inhalation for symptomatic relief. Follow up in 10 days if symptoms persist.',
      'tests': ['Sinus X-ray if symptoms persist'],
    },
  ];

  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredPrescriptions = [];

  @override
  void initState() {
    super.initState();
    _filteredPrescriptions = List.from(prescriptions);
  }

  void _filterPrescriptions(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredPrescriptions = List.from(prescriptions);
      } else {
        _filteredPrescriptions =
            prescriptions
                .where(
                  (prescription) =>
                      prescription['id'].toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      prescription['doctor'].toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      prescription['diagnosis'].toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      prescription['date'].toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C2E),
        title: Row(
          children: [
            Icon(Icons.flash_on, color: Colors.blue[300]),
            const SizedBox(width: 8),
            Text(
              'DocPilot',
              style: TextStyle(
                color: Colors.blue[300],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'My Prescriptions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search prescriptions...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: _filterPrescriptions,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child:
                _filteredPrescriptions.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? 'No prescriptions yet'
                                : 'No prescriptions match your search',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (_searchQuery.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
                                  _filteredPrescriptions = List.from(
                                    prescriptions,
                                  );
                                });
                              },
                              child: Text(
                                'Clear search',
                                style: TextStyle(color: Colors.blue[300]),
                              ),
                            ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredPrescriptions.length,
                      itemBuilder: (context, index) {
                        final prescription = _filteredPrescriptions[index];
                        return _buildPrescriptionCard(prescription, context);
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Prescriptions tab
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
          if (index != 3) {
            // Navigate to other screens based on index
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/patient_dashboard');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/appointments');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/consult');
                break;
              case 4:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
            }
          }
        },
      ),
    );
  }

  Widget _buildPrescriptionCard(
    Map<String, dynamic> prescription,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    PrescriptionDetailScreen(prescription: prescription),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    prescription['id'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    prescription['date'],
                    style: TextStyle(color: Colors.blue[100]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white70, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        prescription['doctor'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.medical_information,
                        color: Colors.white70,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          prescription['diagnosis'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.medication,
                        color: Colors.white70,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(prescription['medications'] as List).length} Medications',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          // Implement download functionality
                        },
                        icon: const Icon(Icons.download, size: 18),
                        label: const Text('Download'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue[300],
                          side: BorderSide(color: Colors.blue[300]!),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          // Implement share functionality
                        },
                        icon: const Icon(Icons.share, size: 18),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue[300],
                          side: BorderSide(color: Colors.blue[300]!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrescriptionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> prescription;

  const PrescriptionDetailScreen({Key? key, required this.prescription})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C2E),
        title: Text(
          'Prescription Details',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () {
              // Implement download functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prescription['id'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        prescription['date'],
                        style: TextStyle(color: Colors.blue[100]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blue[300],
                        child: Text(
                          prescription['doctor'].toString().substring(4, 5),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prescription['doctor'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'General Physician', // This could be dynamic in a real app
                            style: TextStyle(
                              color: Colors.blue[100],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Diagnosis'),
                  _buildInfoCard(
                    child: Text(
                      prescription['diagnosis'],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Medications'),
                  ...(prescription['medications'] as List).map(
                    (medication) => _buildMedicationCard(medication),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Doctor\'s Advice'),
                  _buildInfoCard(
                    child: Text(
                      prescription['advice'],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Recommended Tests'),
                  _buildInfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...(prescription['tests'] as List).map(
                          (test) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.science,
                                  color: Colors.white70,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    test,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: const Color(0xFF1A1C2E),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to book follow-up appointment
                  Navigator.pushNamed(context, '/book_appointment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Book Follow-up Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[900]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.medication, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              Text(
                medication['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMedicationDetail('Dosage', medication['dosage']),
          _buildMedicationDetail('Frequency', medication['frequency']),
          _buildMedicationDetail('Duration', medication['duration']),
          _buildMedicationDetail('Instructions', medication['instructions']),
        ],
      ),
    );
  }

  Widget _buildMedicationDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
