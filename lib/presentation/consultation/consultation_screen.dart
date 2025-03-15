import 'package:flutter/material.dart';
import 'package:docpilot/presentation/prescriptions/prescription_review_screen.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool _isRecording = false;
  bool _processingAudio = false;
  String _transcription = '';
  final List<String> _conversationLines = [];

  // Mock data for demonstration
  final Map<String, List<String>> _extractedData = {
    'symptoms': ['Fever', 'Cough', 'Fatigue', 'Headache'],
    'diagnosis': ['Upper Respiratory Tract Infection'],
    'medications': [
      'Paracetamol 500mg',
      'Cetirizine 10mg',
      'Amoxicillin 500mg',
    ],
    'tests': ['Complete Blood Count', 'Chest X-ray'],
  };

  void _toggleRecording() {
    if (_isRecording) {
      // Stop recording
      setState(() {
        _isRecording = false;
        _processingAudio = true;
      });

      // Simulate processing delay
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _processingAudio = false;
          // Add mock conversation
          _conversationLines.addAll([
            'Doctor: Hello, how are you feeling today?',
            'Patient: I\'ve been having a fever and cough for the past 3 days.',
            'Doctor: I see. Any other symptoms?',
            'Patient: I also feel very tired and have a headache.',
            'Doctor: How high has your fever been?',
            'Patient: Around 101°F in the evenings.',
            'Doctor: Are you taking any medications currently?',
            'Patient: Just some over-the-counter paracetamol for the fever.',
            'Doctor: Based on your symptoms, it seems like you have an upper respiratory tract infection.',
            'Doctor: I\'ll prescribe some medications to help with the symptoms.',
            'Doctor: Take paracetamol for the fever, cetirizine for any allergic symptoms, and amoxicillin to treat the infection.',
            'Doctor: I also recommend getting a complete blood count and a chest X-ray to rule out any complications.',
            'Patient: Thank you, doctor.',
          ]);

          _transcription = _conversationLines.join('\n');
        });
      });
    } else {
      // Start recording
      setState(() {
        _isRecording = true;
      });
    }
  }

  void _generatePrescription() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => PrescriptionReviewScreen(
              patientName: 'John Doe',
              patientAge: 35,
              patientGender: 'Male',
              symptoms: _extractedData['symptoms']!,
              diagnosis: _extractedData['diagnosis']!,
              medications: _extractedData['medications']!,
              tests: _extractedData['tests']!,
              consultationNotes: _transcription,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: Show help dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Patient Info Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      child: const Text(
                        'JD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text('35 years • Male'),
                          const SizedBox(height: 4),
                          const Text('Patient ID: P12345'),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        // TODO: Edit patient info
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Transcription Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                ),
              ),
              child:
                  _processingAudio
                      ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Processing audio...'),
                            SizedBox(height: 8),
                            Text(
                              'Our AI is analyzing the conversation',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                      : _conversationLines.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mic_none,
                              size: 64,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Tap the microphone button to start recording',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'DocPilot will listen to your consultation and generate a prescription',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              _conversationLines.map((line) {
                                final bool isDoctor = line.startsWith(
                                  'Doctor:',
                                );
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            isDoctor
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.2)
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.2),
                                        child: Text(
                                          isDoctor ? 'D' : 'P',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                isDoctor
                                                    ? Theme.of(
                                                      context,
                                                    ).colorScheme.primary
                                                    : Theme.of(
                                                      context,
                                                    ).colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          line.substring(line.indexOf(':') + 2),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
            ),
          ),

          // Extracted Data Section (only show when data is available)
          if (_conversationLines.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Analysis',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildExtractedDataSection(
                          context,
                          'Symptoms',
                          _extractedData['symptoms']!,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildExtractedDataSection(
                          context,
                          'Diagnosis',
                          _extractedData['diagnosis']!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildExtractedDataSection(
                          context,
                          'Medications',
                          _extractedData['medications']!,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildExtractedDataSection(
                          context,
                          'Tests',
                          _extractedData['tests']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Bottom Action Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        _conversationLines.isNotEmpty
                            ? _generatePrescription
                            : null,
                    icon: const Icon(Icons.description),
                    label: const Text('Generate Prescription'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: _toggleRecording,
                  backgroundColor:
                      _isRecording
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtractedDataSection(
    BuildContext context,
    String title,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        ...items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('• '), Expanded(child: Text(item))],
                ),
              ),
            )
            ,
      ],
    );
  }
}
