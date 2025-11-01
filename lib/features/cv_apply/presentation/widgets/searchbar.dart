import 'package:flutter/material.dart';
import 'dart:ui' show kIsWeb;

class BayatSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const BayatSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth < 600 ? 16 : 20;
    final double fontSize = screenWidth < 600 ? 14 : 16;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'البحث عن وظيفة...',
          hintStyle: TextStyle(fontSize: fontSize, color: Colors.black45),
          prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
        ),
        onChanged: onChanged,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
