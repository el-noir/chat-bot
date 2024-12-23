import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'newchat.dart';
import 'settings.dart';
import 'terms.dart'; // Import the TermsPage
import 'privacy.dart'; // Import the PrivacyPage

class Custompage extends StatefulWidget {
  final Function(bool) onThemeChanged; // Callback to handle theme change
  final bool isDarkMode; // Current theme state

  const Custompage({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _EnhancedPageWithAnimationsState createState() =>
      _EnhancedPageWithAnimationsState();
}

class _EnhancedPageWithAnimationsState extends State<Custompage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward(); // Start animation on page load
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'appBarTitle',
          child: Text(
            'AI BARKAT',
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(), // Navigate to New Chat Page
              ),
            );
          },
          child: Icon(
            Icons.chat_bubble_outline,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Toggle theme on press
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Main Content Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(
                          0, 20 * (1 - value)), // Slide up as it fades in
                      child: child,
                    ),
                  );
                },
                child: Text(
                  'Secure your chats, share moments, and make your experience truly yours.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            // Signup and Login Buttons Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Signup Button
                  MagicButton(
                    title: 'Signup',
                    icon: Icon(
                        Icons.app_registration), // Pass the Icon widget here
                    position: 'left',
                    onPressed: () {
                      // Navigate to Signup Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20), // Add some space between buttons
                  // Login Button
                  MagicButton(
                    title: 'Login',
                    icon: Icon(Icons.login), // Pass the Icon widget here
                    position: 'right',
                    onPressed: () {
                      // Navigate to Login Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Horizontal Buttons Section (Terms, Privacy, Settings)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Terms Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TermsPage(isDarkMode: widget.isDarkMode),
                        ),
                      );
                    },
                    child: OptionTile(
                      title: 'Terms',
                      icon: Icons.article_outlined,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                  // Privacy Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PrivacyPage(isDarkMode: widget.isDarkMode),
                        ),
                      );
                    },
                    child: OptionTile(
                      title: 'Privacy',
                      icon: Icons.lock_outline,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                  // Settings Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(
                            onThemeChanged: widget.onThemeChanged,
                            isDarkMode: widget.isDarkMode,
                          ),
                        ),
                      );
                    },
                    child: OptionTile(
                      title: 'Settings',
                      icon: Icons.settings_outlined,
                      isDarkMode: widget.isDarkMode,
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

}

// OptionTile Widget
class OptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDarkMode;

  const OptionTile({
    required this.title,
    required this.icon,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: isDarkMode ? Colors.white : Colors.black,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// MagicButton Widget
class MagicButton extends StatefulWidget {
  final String title;
  final Icon? icon;
  final String position; // "left" or "right"
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;

  const MagicButton({
    Key? key,
    required this.title,
    this.icon,
    this.position = "left",
    this.onPressed,
    this.margin,
  }) : super(key: key);

  @override
  _MagicButtonState createState() => _MagicButtonState();
}

class _MagicButtonState extends State<MagicButton> {
  // Initial scale and shadow properties
  double _scale = 1.0;
  double _elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          // Scale up and add shadow on hover
          _scale = 1.1;
          _elevation = 8.0;
        });
      },
      onExit: (_) {
        setState(() {
          // Reset scale and shadow when hover ends
          _scale = 1.0;
          _elevation = 0.0;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          margin: widget.margin ?? const EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const SweepGradient(
              startAngle: 0.0,
              endAngle: 6.28,
              colors: [
                Color(0xFFE2CBFF),
                Color(0xFF393BB2),
                Color(0xFFE2CBFF),
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              elevation: _elevation, // Apply the dynamic elevation
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.position == "left" && widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: 8)
                ],
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
                if (widget.position == "right" && widget.icon != null) ...[
                  const SizedBox(width: 8),
                  widget.icon!
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

