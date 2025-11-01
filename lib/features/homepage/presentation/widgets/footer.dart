import 'package:flutter/material.dart';

class BuildFooter extends StatelessWidget {
  const BuildFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;

    // ضبط حجم الخط بحسب حجم الشاشة
    double titleFontSize = screenWidth > 800 ? 24 : 18;
    double textFontSize = screenWidth > 800 ? 16 : 14;
    double verticalPadding = screenWidth > 800 ? 40 : 20;
    double horizontalPadding = screenWidth > 800 ? 20 : 10;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      color: Colors.blue.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bayat Carting',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: verticalPadding / 2),
          Text(
            '© 2025 Bayat. All rights reserved.',
            style: TextStyle(
              fontSize: textFontSize,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: verticalPadding / 2),
          LayoutBuilder(
            builder: (context, constraints) {
              // إذا الشاشة ضيقة، أظهر الأزرار في عمود
              bool isMobile = constraints.maxWidth < 600;
              return Wrap(
                spacing: 20,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                children: [
                  _footerButton('Privacy Policy'),
                  _footerButton('Terms of Service'),
                  _footerButton('Contact Us'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _footerButton(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
