import 'package:bayat/features/cv_apply/presentation/bloc/jobs_apply_cubit/jobs_apply_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show kIsWeb;
import '../pages/jobs_request.dart';

class BayatJobCard extends StatelessWidget {
  final String title;
  final String description;
  final String condition;
  final int id;
  final IconData icon;
  final VoidCallback? onTap;

  const BayatJobCard({
    super.key,
    required this.title,
    required this.condition,
    required this.id,
    required this.description,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth < 600
        ? (screenWidth - 32) / 3
        : screenWidth < 1200
        ? (screenWidth - 96) / 5
        : 300;
    final double titleFontSize = screenWidth < 600 ? 12 : screenWidth < 1200 ? 14 : 16;
    final double descriptionFontSize = screenWidth < 600 ? 10 : 12;
    final double iconSize = screenWidth < 600 ? 18 : 24;
    final double buttonFontSize = screenWidth < 600 ? 10 : 12;
    final double padding = screenWidth < 600 ? 6 : 10;
    final bool isMobile = screenWidth < 600;

    Widget card = Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: iconSize),
                SizedBox(width: padding / 1.5),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
          // Description
          Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              description,
              style: TextStyle(
                fontSize: descriptionFontSize,
                color: Colors.black87,
                height: 1.4,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          // Buttons row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Apply button
                Expanded(
                  child: GestureDetector(
                    onTap: onTap ??
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => JobApplicationForm(job: title, jobID: id),
                            ),
                          );
                        },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: padding / 1.5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'تقديم الطلب',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFontSize,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Details button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(""),
                          content: SingleChildScrollView(
                            child: Text(
                              condition,
                              style: TextStyle(fontSize: descriptionFontSize, color: Colors.black87),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('إغلاق'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: padding / 1.5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'التفاصيل',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFontSize,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return isMobile || !kIsWeb
        ? card
        : MouseRegion(
      cursor: SystemMouseCursors.click,
      child: card,
    );
  }
}
