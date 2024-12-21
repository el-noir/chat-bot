import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final bool isUserLoggedIn;
  final String? username; // Optional username when logged in
  final String? email; // Optional email when logged in
  final String? profileImageUrl; // Optional profile image URL

  ProfilePage({
    required this.isUserLoggedIn,
    this.username,
    this.email,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: isUserLoggedIn
          ? _buildProfileContent(context)
          : _buildLoginPrompt(context),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: profileImageUrl != null
                ? NetworkImage(profileImageUrl!)
                : AssetImage('assets/default-avatar.png') as ImageProvider,
          ),
          SizedBox(height: 16),
          Text(
            username ?? 'User Name',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            email ?? 'user@example.com',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to profile edit screen
            },
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 20),
         ElevatedButton(
            onPressed: () {
              // Log the user out
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red), // Correct
          ),

        ],
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.account_circle, size: 100, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'You are not logged in!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to login/signup page
            },
            child: Text('Log In / Sign Up'),
          ),
        ],
      ),
    );
  }
}
