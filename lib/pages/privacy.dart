import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  final bool isDarkMode; // Add dark mode flag

  PrivacyPage({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: isDarkMode
            ? Colors.grey[850]
            : const Color.fromARGB(
                255, 212, 201, 201), // Dark mode AppBar background
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
                'Privacy Policy',
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
                '1. Information We Collect\n\n'
                'We collect personal data such as name, email address, and device information when you use our app.\n\n'
                '2. Use of Information\n\n'
                'We use the collected information to personalize your experience and improve our services.\n\n'
                '3. Sharing of Information\n\n'
                'We do not sell or share your personal information with third parties except where required by law.\n\n'
                '4. Data Security\n\n'
                'We implement reasonable security measures to protect your data. However, no system is completely secure.\n\n'
                '5. Your Rights\n\n'
                'You have the right to access, update, or delete your personal information at any time.\n\n'
                '6. Changes to Privacy Policy\n\n'
                'We may update this policy from time to time. Any changes will be communicated to you.',
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
