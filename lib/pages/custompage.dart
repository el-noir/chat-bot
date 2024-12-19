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
  late Animation<Offset> _slideAnimation;

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

    _slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(), // New Chat Page
              ),
            );
          },
          child: Hero(
            tag: 'appBarTitle',
            child: Text(
              'New Chat',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        leading: Icon(Icons.chat_bubble_outline,
            color: widget.isDarkMode ? Colors.white : Colors.black),
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
            // Options Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedOptionTile(
                      title: 'Terms',
                      icon: Icons.article_outlined,
                      animationDelay: 300,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsPage(
                                isDarkMode:
                                    widget.isDarkMode), // Pass dark mode state
                          ),
                        );
                      },
                      isDarkMode: widget.isDarkMode, // Pass dark mode state
                    ),
                    AnimatedOptionTile(
                      title: 'Privacy',
                      icon: Icons.lock_outline,
                      animationDelay: 600,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPage(
                                isDarkMode:
                                    widget.isDarkMode), // Pass dark mode state
                          ),
                        );
                      },
                      isDarkMode: widget.isDarkMode, // Pass dark mode state
                    ),
                    AnimatedOptionTile(
                      title: 'Settings',
                      icon: Icons.settings_outlined,
                      animationDelay: 900,
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
                      isDarkMode: widget.isDarkMode, // Pass dark mode state
                    ),
                  ],
                ),
              ),
            ),
            // Footer Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Save your chat history, share chats, and personalize your experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Login Button with MagicButton
                      Expanded(
                        child: MagicButton(
                          title: 'Login',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          position: "left",
                          icon: const Icon(Icons.login, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Sign Up Button with MagicButton
                      Expanded(
                        child: MagicButton(
                          title: 'Sign Up',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          position: "right",
                          icon:
                              const Icon(Icons.person_add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create custom page transitions
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero; // End at the current position
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

// OptionTile with Animated Appearance
class AnimatedOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final int animationDelay;
  final bool isDarkMode; // Add dark mode flag

  const AnimatedOptionTile({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.animationDelay,
    required this.isDarkMode, // Add dark mode flag to constructor
  });

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: animationDelay,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor to hand pointer
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            margin: EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                // Adjust Icon color based on dark mode
                Icon(
                  icon,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black, // Adjust icon color for dark mode
                  size: 20,
                ),
                SizedBox(width: 12),
                // Adjust Text color based on dark mode
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode
                        ? Colors.white
                        : Colors.black, // Adjust text color for dark mode
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Delayed Animation Widget
class DelayedAnimation extends StatelessWidget {
  final Widget child;
  final int delay;

  const DelayedAnimation({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}

// MagicButton
class MagicButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 40.0),
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
        onPressed: onPressed,
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
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (position == "left" && icon != null) ...[
              icon!,
              const SizedBox(width: 8)
            ],
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            if (position == "right" && icon != null) ...[
              const SizedBox(width: 8),
              icon!
            ],
          ],
        ),
      ),
    );
  }
}
