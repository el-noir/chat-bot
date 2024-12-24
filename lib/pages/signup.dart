import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'newchat.dart';
import 'magic_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  final String userId;
  final String email;
  final String username;
  final String profileImageUrl;
  final bool isUserLoggedIn;

  SignUpPage({
    required this.userId,
    required this.email,
    required this.username,
    required this.profileImageUrl,
    required this.isUserLoggedIn,
  });

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController; // Declare it late
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email); // Initialize emailController with the passed email
  }

  void _signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_formKey.currentState!.validate()) {
      return; // If the form is invalid, return immediately
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      // Step 1: Create the user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final String userId = userCredential.user!.uid;

      // Step 2: Store additional user details in Firestore
      final firestore = FirebaseFirestore.instance;
      final idDocRef = firestore.collection('metadata').doc('lastUserId');
      final usersCollection = firestore.collection('users');

      // Use a transaction to safely read and update the last used ID
      final newId = await firestore.runTransaction<int>((transaction) async {
        final idDocSnapshot = await transaction.get(idDocRef);

        int lastUserId = idDocSnapshot.exists ? idDocSnapshot['value'] as int : 0;
        final nextUserId = lastUserId + 1;

        // Update the lastUserId in the metadata document
        transaction.set(idDocRef, {'value': nextUserId});

        return nextUserId;
      });

      // Add the new user with the incremented ID
      await usersCollection.doc(userId).set({
        'id': newId,
        'name': name,
        'email': email,
        'profileImageUrl': '', // Placeholder for profile image URL
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to ChatPage after success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userId: userId,
            email: email,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Handle other errors and display them to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'appBarTitle',
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: isLoading
              ? const CircularProgressIndicator()
              : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  isDarkMode,
                  controller: nameController,
                  label: 'Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  isDarkMode,
                  controller: emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  isDarkMode,
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MagicButton(
                  title: 'Sign Up',
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  position: "right",
                  onPressed: _signUp,
                  margin: const EdgeInsets.only(top: 30.0),
                ),
                const SizedBox(height: 20),
                Row(
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
                        Navigator.pop(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Create a method to build reusable text fields
  Widget _buildTextField(
      bool isDarkMode, {
        required TextEditingController controller,
        required String label,
        bool obscureText = false,
        required String? Function(String?) validator,
      }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        border: const OutlineInputBorder(),
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        filled: true,
      ),
      validator: validator,
    );
  }
}
