import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final bool isDarkMode; // Current theme status

  const AboutPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        centerTitle: true,
        backgroundColor: isDarkMode
            ? Colors.grey[850] // Dark gray for dark theme
            : Colors.grey[300], // Light gray for light theme
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white, // Dynamic background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our AI Chatbot',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Our AI Chatbot is designed to provide intuitive and intelligent conversational experiences. '
              'Whether you need assistance, want to explore features, or simply chat, our AI is here to help.',
              style: TextStyle(
                fontSize: 16.0,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '- Natural language understanding and responses\n'
              '- Real-time conversational abilities\n'
              '- Adaptive learning for better interactions\n'
              '- Secure and private conversations',
              style: TextStyle(
                fontSize: 16.0,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Mission:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Our mission is to leverage artificial intelligence to bridge the gap between technology and human interaction, making communication seamless, engaging, and accessible to everyone.',
              style: TextStyle(
                fontSize: 16.0,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  color: isDarkMode ? Colors.grey : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
