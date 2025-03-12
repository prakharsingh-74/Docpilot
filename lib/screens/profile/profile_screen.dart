import 'package:flutter/material.dart';
import 'package:docpilot/screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Dr. Sarah Johnson',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text('General Physician'),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Navigate to edit profile screen
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Professional Information
            _buildSection(context, 'Professional Information', [
              _buildInfoItem(
                Icons.badge_outlined,
                'License Number',
                'MED12345',
              ),
              _buildInfoItem(
                Icons.business_outlined,
                'Clinic',
                'HealthCare Medical Center',
              ),
              _buildInfoItem(
                Icons.medical_services_outlined,
                'Specialization',
                'General Medicine',
              ),
              _buildInfoItem(
                Icons.school_outlined,
                'Education',
                'MD, University Medical School',
              ),
            ]),
            const SizedBox(height: 16),

            // Contact Information
            _buildSection(context, 'Contact Information', [
              _buildInfoItem(
                Icons.email_outlined,
                'Email',
                'dr.sarah@example.com',
              ),
              _buildInfoItem(
                Icons.phone_outlined,
                'Phone',
                '+1 (555) 123-4567',
              ),
              _buildInfoItem(
                Icons.location_on_outlined,
                'Address',
                '123 Medical Plaza, Suite 101, New York, NY 10001',
              ),
            ]),
            const SizedBox(height: 16),

            // App Settings
            _buildSection(context, 'App Settings', [
              _buildSettingsItem(
                context,
                Icons.notifications_outlined,
                'Notifications',
                'Manage notification preferences',
                () {
                  // TODO: Navigate to notifications settings
                },
              ),
              _buildSettingsItem(
                context,
                Icons.security_outlined,
                'Privacy & Security',
                'Manage privacy and security settings',
                () {
                  // TODO: Navigate to privacy settings
                },
              ),
              _buildSettingsItem(
                context,
                Icons.language_outlined,
                'Language',
                'Change application language',
                () {
                  // TODO: Navigate to language settings
                },
              ),
              _buildSettingsItem(
                context,
                Icons.dark_mode_outlined,
                'Appearance',
                'Change theme and appearance',
                () {
                  // TODO: Navigate to appearance settings
                },
              ),
            ]),
            const SizedBox(height: 16),

            // Support & Help
            _buildSection(context, 'Support & Help', [
              _buildSettingsItem(
                context,
                Icons.help_outline,
                'Help Center',
                'Get help and support',
                () {
                  // TODO: Navigate to help center
                },
              ),
              _buildSettingsItem(
                context,
                Icons.feedback_outlined,
                'Feedback',
                'Send feedback to improve DocPilot',
                () {
                  // TODO: Navigate to feedback form
                },
              ),
              _buildSettingsItem(
                context,
                Icons.info_outline,
                'About',
                'About DocPilot and version information',
                () {
                  // TODO: Navigate to about screen
                },
              ),
            ]),
            const SizedBox(height: 24),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                _showLogoutDialog(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to *basic* LoginScreen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const LoginScreen(), // Use the basic LoginScreen
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }
}
