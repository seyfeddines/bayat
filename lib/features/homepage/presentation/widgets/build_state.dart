import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildStatsSection() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 60),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue.shade800, Colors.blue.shade600],
      ),
    ),
    child: Column(
      children: [
        Text(
          'Our Achievements',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 40,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            buildStatItem('500+', 'Projects Completed'),
            buildStatItem('13+', 'Years Experience'),
            buildStatItem('100+', 'Team Members'),
            buildStatItem('95%', 'Client Satisfaction'),
          ],
        ),
      ],
    ),
  );
}

Widget buildStatItem(String value, String label) {
  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 0, end: 1),
    duration: const Duration(milliseconds: 800),
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20 - 20 * value),
          child: child,
        ),
      );
    },
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );
}