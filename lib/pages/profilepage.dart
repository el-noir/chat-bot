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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              color: isDarkMode
                  ? Colors.grey[900]
                  : Colors.grey[200], // Neutral background
            ),
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!)
                    : AssetImage('assets/default-avatar.png') as ImageProvider,
                child: GestureDetector(
                  onTap: () {
                    // Add functionality to change profile picture
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 70), // To adjust for the avatar overlap
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
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to profile edit screen
          },
          icon: Icon(Icons.edit),
          label: Text('Edit Profile'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            // Log the user out
          },
          icon: Icon(Icons.logout),
          label: Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode
                ? Colors.grey[800]
                : Colors.grey[300], // Neutral color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/login-illustration.png', // Add an illustration asset
            height: 150,
          ),
          SizedBox(height: 16),
          Text(
            'You are not logged in!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Log in to access your profile and settings.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to login/signup page
            },
            child: Text('Log In / Sign Up'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
