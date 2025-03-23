import 'package:flutter/material.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _patientData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+1 234 567 8900',
    'dob': '15 Jan 1990',
    'bloodGroup': 'O+',
    'address': '123 Main St, New York, NY 10001',
    'emergencyContact': '+1 234 567 8901',
    'allergies': 'None',
    'chronicConditions': 'None',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C2E),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  if (_formKey.currentState!.validate()) {
                    _isEditing = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } else {
                  _isEditing = true;
                }
              });
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue[700],
                      child: Text(
                        _patientData['name']!.substring(0, 1),
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection('Personal Information', [
                _buildProfileField('Name', 'name', Icons.person),
                _buildProfileField('Email', 'email', Icons.email),
                _buildProfileField('Phone', 'phone', Icons.phone),
                _buildProfileField('Date of Birth', 'dob', Icons.cake),
                _buildProfileField(
                  'Blood Group',
                  'bloodGroup',
                  Icons.bloodtype,
                ),
              ]),
              const SizedBox(height: 16),
              _buildSection('Contact Information', [
                _buildProfileField('Address', 'address', Icons.home),
                _buildProfileField(
                  'Emergency Contact',
                  'emergencyContact',
                  Icons.emergency,
                ),
              ]),
              const SizedBox(height: 16),
              _buildSection('Medical Information', [
                _buildProfileField('Allergies', 'allergies', Icons.warning),
                _buildProfileField(
                  'Chronic Conditions',
                  'chronicConditions',
                  Icons.medical_services,
                ),
              ]),
              const SizedBox(height: 24),
              if (!_isEditing) ...[
                _buildActionButton(
                  'Medical Records',
                  Icons.folder_outlined,
                  () {
                    // TODO: Navigate to medical records
                  },
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  'Privacy Settings',
                  Icons.security_outlined,
                  () {
                    // TODO: Navigate to privacy settings
                  },
                ),
                const SizedBox(height: 12),
                _buildActionButton('Help & Support', Icons.help_outline, () {
                  // TODO: Navigate to help & support
                }),
                const SizedBox(height: 12),
                _buildActionButton('Logout', Icons.logout, () {
                  // TODO: Implement logout
                }, color: Colors.red[400]),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Profile tab
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
          if (index != 4) {
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
              case 3:
                Navigator.pushReplacementNamed(context, '/prescriptions');
                break;
            }
          }
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String field, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
          _isEditing
              ? TextFormField(
                initialValue: _patientData[field],
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(icon, color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFF1A1C2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your $label';
                  }
                  return null;
                },
              )
              : Row(
                children: [
                  Icon(icon, color: Colors.grey[400], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _patientData[field]!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed, {
    Color? color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF2A2A3C),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.white),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(color: color ?? Colors.white, fontSize: 16),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: color ?? Colors.white),
          ],
        ),
      ),
    );
  }
}
