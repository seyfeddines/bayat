import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNavButton(BuildContext context, String label) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blue.shade900,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}