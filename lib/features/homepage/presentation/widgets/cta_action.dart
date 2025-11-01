import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCTASection() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
    child: Column(
      children: [
        Text(
          'Ready to Start Your Project?',
          style: TextStyle(

            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'Let\'s collaborate and create something amazing together',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Get Started Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}