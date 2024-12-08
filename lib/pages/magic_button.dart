import 'package:flutter/material.dart';

class MagicButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final String position;
  final VoidCallback onPressed;

  const MagicButton({
    required this.title,
    required this.icon,
    this.position = "left",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjust padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adjust to fit content
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (position == "left") icon,
          if (position == "left") SizedBox(width: 8), // Space between icon and text
          Text(
            title,
            style: TextStyle(
              fontSize: 14, // Adjust text size
              fontWeight: FontWeight.bold,
            ),
          ),
          if (position == "right") SizedBox(width: 8),
          if (position == "right") icon,
        ],
      ),
    );
  }
}
