import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  final bool isDarkMode; // Add dark mode flag

  TermsPage({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: isDarkMode
            ? Colors.grey[850]
            : const Color.fromARGB(
                255, 230, 224, 224), // Dark mode AppBar background
        foregroundColor: isDarkMode
            ? Colors.white
            : Colors.black, // Dark mode text color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Dark mode text color
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '1. Introduction\n\n'
                'These terms and conditions govern your use of our app. By using our app, you agree to comply with these terms.\n\n'
                '2. User Responsibilities\n\n'
                'You are responsible for all activities that occur under your account. You agree not to misuse the app or access it in any unauthorized way.\n\n'
                '3. Data Collection\n\n'
                'We collect personal data to improve your experience and provide better services. For more details, refer to our Privacy Policy.\n\n'
                '4. Limitations of Liability\n\n'
                'We are not liable for any damages arising from your use of the app.\n\n'
                '5. Governing Law\n\n'
                'These terms are governed by the laws of [Your Country].\n\n'
                '6. Changes to Terms\n\n'
                'We may update these terms from time to time. You will be notified of any changes.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Dark mode text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
