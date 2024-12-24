import 'package:flutter/material.dart';

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
