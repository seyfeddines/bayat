import 'package:flutter/material.dart';

Widget buildStatsSection() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;

      bool isMobile = screenWidth < 600;
      bool isTablet = screenWidth >= 600 && screenWidth < 1024;

      // ضبط حجم الخط والمسافات بناءً على حجم الشاشة
      double titleFontSize = isMobile ? 28 : isTablet ? 34 : 40;
      double valueFontSize = isMobile ? 32 : isTablet ? 40 : 48;
      double labelFontSize = isMobile ? 14 : isTablet ? 16 : 18;
      double verticalPadding = isMobile ? 30 : 60;
      double spacing = isMobile ? 20 : 40;

      // عناصر الإحصائيات
      List<Map<String, String>> stats = [
        {'value': '500+', 'label': 'Projects Completed'},
        {'value': '13+', 'label': 'Years Experience'},
        {'value': '100+', 'label': 'Team Members'},
        {'value': '95%', 'label': 'Client Satisfaction'},
      ];

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20),
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
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: verticalPadding / 1.5),
            // استخدام GridView أو Column/Row حسب حجم الشاشة
            if (isMobile)
              Column(
                children: stats
                    .map((stat) => Padding(
                  padding: EdgeInsets.symmetric(vertical: spacing / 2),
                  child: buildStatItem(
                      stat['value']!, stat['label']!, valueFontSize, labelFontSize),
                ))
                    .toList(),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: stats
                    .map((stat) => buildStatItem(
                    stat['value']!, stat['label']!, valueFontSize, labelFontSize))
                    .toList(),
              ),
          ],
        ),
      );
    },
  );
}

Widget buildStatItem(
    String value, String label, double valueFontSize, double labelFontSize) {
  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 0, end: 1),
    duration: const Duration(milliseconds: 800),
    builder: (context, animValue, child) {
      return Opacity(
        opacity: animValue,
        child: Transform.translate(
          offset: Offset(0, 20 - 20 * animValue),
          child: child,
        ),
      );
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: valueFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
