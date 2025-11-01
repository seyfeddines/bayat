import 'package:flutter/material.dart';

class BayatDrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const BayatDrawerItem({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textDirection: TextDirection.rtl,
      ),
      onTap: () {
        Navigator.pop(context); // Close the Drawer
        if (onTap != null) {
          onTap!(); // Call custom onTap if provided
        } else {
          // Default behavior: show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('الانتقال إلى: $label', textDirection: TextDirection.rtl)),
          );
        }
      },
    );
  }
}