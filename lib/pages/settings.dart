import 'package:flutter/material.dart';
import 'login.dart'; // Assuming this is the login page

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Initial mode (light mode by default)
  String _selectedLanguage = 'English'; // Default language
  bool _isUserLoggedIn = false; // Simulate user login status

  @override
  void initState() {
    super.initState();
    // You can load the login status from a persistent storage like SharedPreferences
    // Example: _isUserLoggedIn = loadUserLoginStatus();
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    // Add logic to update the app theme dynamically.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: _isDarkMode
            ? Colors.black
            : const Color.fromARGB(255, 179, 212, 239),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Toggle
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: _toggleTheme,
            ),
          ),
          // Language Settings
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: ['English', 'Spanish', 'French', 'German']
                  .map((lang) =>
                      DropdownMenuItem<String>(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
          ),
          const Divider(),
          // Account Management Section (Only visible if the user is logged in)
          if (_isUserLoggedIn) ...[
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to Change Password Page (Implement separately)
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Update Email'),
              onTap: () {
                // Navigate to Update Email Page (Implement separately)
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout (e.g., clear session, navigate to login page)
                setState(() {
                  _isUserLoggedIn = false; // Simulate logout
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ] else ...[
            // Show login prompt if the user is not logged in
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login to access settings'),
              onTap: () {
                // Navigate to login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
          const Divider(),
          // About Section
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About App'),
            onTap: () {
              // Navigate to About Page (Implement separately)
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () {
              // Navigate to Support Page (Implement separately)
            },
          ),
        ],
      ),
    );
  }
}
