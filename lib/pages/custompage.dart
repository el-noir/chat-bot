import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'newchat.dart';
import 'settings.dart';
import 'terms.dart';
import 'privacy.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomPage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const CustomPage({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _EnhancedPageWithAnimationsState createState() => _EnhancedPageWithAnimationsState();
}

class _EnhancedPageWithAnimationsState extends State<CustomPage> with SingleTickerProviderStateMixin {
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
    _controller.forward();
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
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    userId: user.uid,
                    email: user.email ?? 'No Email',
                  ),
                ),
              );
            } else {
              // Show a dialog or navigate to the login page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please log in to access chat')),
              );
              // Optionally, navigate to the login page directly
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
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
                      offset: Offset(0, 20 * (1 - value)),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MagicButton(
                    title: 'Signup',
                    icon: const Icon(Icons.app_registration),
                    position: 'left',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(
                            userId: '',
                            email: '',
                            username: '',
                            profileImageUrl: '',
                            isUserLoggedIn: false,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  MagicButton(
                    title: 'Login',
                    icon: const Icon(Icons.login),
                    position: 'right',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsPage(isDarkMode: widget.isDarkMode),
                        ),
                      );
                    },
                    child: OptionTile(
                      title: 'Terms',
                      icon: Icons.article_outlined,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPage(isDarkMode: widget.isDarkMode),
                        ),
                      );
                    },
                    child: OptionTile(
                      title: 'Privacy',
                      icon: Icons.lock_outline,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
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

