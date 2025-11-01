import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'Our Journey Through Time',
            style: TextStyle(
              fontSize: screenWidth > 600 ? 40 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 48),
          screenWidth > 900
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              TimelineItem(
                  year: '2010',
                  title: 'Founded',
                  description: 'Started with 5 team members'),
              TimelineItem(
                  year: '2014',
                  title: 'Expansion',
                  description: 'Opened international offices'),
              TimelineItem(
                  year: '2018',
                  title: 'Innovation',
                  description: 'Launched AI division'),
              TimelineItem(
                  year: '2023',
                  title: 'Leadership',
                  description: '100+ employees worldwide'),
            ],
          )
              : const Column(
            children: [
              TimelineItem(
                  year: '2010',
                  title: 'Founded',
                  description: 'Started with 5 team members'),
              SizedBox(height: 40),
              TimelineItem(
                  year: '2014',
                  title: 'Expansion',
                  description: 'Opened international offices'),
              SizedBox(height: 40),
              TimelineItem(
                  year: '2018',
                  title: 'Innovation',
                  description: 'Launched AI division'),
              SizedBox(height: 40),
              TimelineItem(
                  year: '2023',
                  title: 'Leadership',
                  description: '100+ employees worldwide'),
            ],
          ),
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;

  const TimelineItem({
    super.key,
    required this.year,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          year,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
