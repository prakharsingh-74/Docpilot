import 'package:flutter/material.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
      appBar: AppBar(
        title: const Text('Prescription'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Recent'), Tab(text: 'All')],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search prescriptions...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchQuery.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Prescription List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Recent Prescriptions
                _buildPrescriptionList(true),

                // All Prescriptions
                _buildPrescriptionList(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionList(bool isRecent) {
    // Mock data - in a real app, this would come from a database
    final int itemCount = isRecent ? 5 : 15;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Mock prescription data
        final patientName = _getMockPatientName(index);
        final date = DateTime.now().subtract(
          Duration(days: index * (isRecent ? 1 : 5)),
        );
        final formattedDate = '${date.day}/${date.month}/${date.year}';
        final diagnosis = _getMockDiagnosis(index);

        if (_searchQuery.isNotEmpty &&
            !patientName.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !diagnosis.toLowerCase().contains(_searchQuery.toLowerCase())) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.2),
              child: Text(
                patientName.substring(0, 1),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(patientName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: $formattedDate'),
                Text('Diagnosis: $diagnosis'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.print_outlined),
                  onPressed: () {
                    // TODO: Implement print functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    // TODO: Implement share functionality
                  },
                ),
              ],
            ),
            isThreeLine: true,
            onTap: () {
              // TODO: Navigate to prescription details
            },
          ),
        );
      },
    );
  }

  String _getMockPatientName(int index) {
    final names = [
      'John Doe',
      'Jane Smith',
      'Robert Johnson',
      'Emily Davis',
      'Michael Wilson',
      'Sarah Brown',
      'David Miller',
      'Jennifer Taylor',
      'James Anderson',
      'Lisa Thomas',
    ];
    return names[index % names.length];
  }

  String _getMockDiagnosis(int index) {
    final diagnoses = [
      'Upper Respiratory Tract Infection',
      'Hypertension',
      'Type 2 Diabetes',
      'Migraine',
      'Gastroenteritis',
      'Urinary Tract Infection',
      'Bronchitis',
      'Allergic Rhinitis',
      'Osteoarthritis',
      'Anxiety Disorder',
    ];
    return diagnoses[index % diagnoses.length];
  }
}
