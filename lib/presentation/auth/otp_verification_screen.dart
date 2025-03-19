import 'package:flutter/material.dart';
import 'package:docpilot/presentation/dashboard/dashboard_screen.dart';
import 'package:docpilot/presentation/dashboard/patient_dashboard_screen.dart';



class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
   final String userType;

  const OtpVerificationScreen({Key? key, required this.phoneNumber, required this.userType,}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate OTP verification
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

       if (mounted) {
      if (widget.userType == 'patient') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PatientDashboardScreen()),
        );
      } else if (widget.userType == 'staff') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Verify Your Phone',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the 4-digit code sent to ${widget.phoneNumber}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: _otpControllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter digit';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Verify OTP'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Implement resend OTP functionality
                  },
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
