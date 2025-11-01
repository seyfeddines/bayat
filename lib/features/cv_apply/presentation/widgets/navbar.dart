import 'package:flutter/material.dart';
import 'dart:ui' show kIsWeb;

class BayatNavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const BayatNavButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: onPressed ?? () {},
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}