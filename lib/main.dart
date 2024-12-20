import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For persistent theme storage
import 'pages/custompage.dart'; // Ensure this file exists and is correctly imported
import 'pages/page1.dart'; // Ensure this file exists and is correctly imported
import 'pages/settings.dart'; // Import your SettingsPage
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Load theme preference and run the app
  final bool isDarkMode = await loadThemePreference();
  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    // Initialize theme mode based on saved preference
    _themeMode = widget.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void _toggleTheme(bool isDarkMode) async {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
    await saveThemePreference(isDarkMode); // Save user preference persistently
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page with Routes',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode, // Dynamically change theme
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => Custompage(
              onThemeChanged: _toggleTheme, // Pass the toggle callback
              isDarkMode: _themeMode == ThemeMode.dark, // Pass current theme
            ),
        '/page1': (context) => Page1(), // Define Page1 route
        '/settings': (context) => SettingsPage(
              onThemeChanged: _toggleTheme, // Pass the toggle callback
              isDarkMode: _themeMode == ThemeMode.dark, // Pass current theme
            ),
      },
    );
  }
}

// Helper functions for persistent storage
Future<void> saveThemePreference(bool isDarkMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isDarkMode', isDarkMode);
}

Future<bool> loadThemePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? false; // Default to light mode
}
