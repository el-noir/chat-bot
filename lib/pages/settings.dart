import 'package:flutter/material.dart';
import 'login.dart'; // Assuming this is the login page
import 'about_page.dart';


class SettingsPage extends StatefulWidget {
  final Function(bool) onThemeChanged; // Callback to update theme
  final bool isDarkMode; // Current theme status

  const SettingsPage({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDarkMode;
  String _selectedLanguage = 'English'; // Default language
  bool _isUserLoggedIn = false; // Simulate user login status

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode; // Initialize with passed theme status
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    widget.onThemeChanged(value); // Notify parent to change theme
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: _isDarkMode
            ? Colors.black
            : const Color.fromARGB(255, 210, 214, 218),
        foregroundColor: _isDarkMode ? Colors.white : Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Toggle
          ListTile(
            leading: Icon(
              _isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing: Switch(
              value: _isDarkMode,
              activeColor: Colors.blue,
              onChanged: _toggleTheme,
            ),
          ),
          // Language Settings
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: ['English',]
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(isDarkMode: _isDarkMode),
                ),
              );
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
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
    );
  }
}
