import 'package:flutter/material.dart';
import 'login.dart';
import 'custompage.dart'; // Ensure this import is correct if Custompage is in another file.

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : Colors.white, // Adjust background color
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : Colors.transparent, // AppBar color
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'appBarTitle',
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black, // Text color
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sign Up Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black, // Text color
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(isDarkMode, 'Username'),
                  SizedBox(height: 16),
                  _buildTextField(isDarkMode, 'Email'),
                  SizedBox(height: 16),
                  _buildTextField(isDarkMode, 'Password', obscureText: true),
                  SizedBox(height: 20),
                  AnimatedHoverButton(
                    text: 'Sign Up',
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    textColor: isDarkMode ? Colors.black : Colors.white,
                    onPressed: () {
                      // Add the logic for sign-up process
                    },
                  ),
                ],
              ),
            ),
            // Footer Section with Login option
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(bool isDarkMode, String label,
      {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black), // Label color
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.black), // Border color
        ),
        border: OutlineInputBorder(),
        fillColor:
            isDarkMode ? Colors.grey[800] : Colors.white, // Input background
        filled: true,
      ),
    );
  }
}

// Reusable Hover Button from Custompage
class AnimatedHoverButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const AnimatedHoverButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 14),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
