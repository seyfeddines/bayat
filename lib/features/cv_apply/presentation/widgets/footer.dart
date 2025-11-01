import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show kIsWeb;

class BayatFooters extends StatelessWidget {
  const BayatFooters({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 400 ? 12 : screenWidth < 600 ? 14 : 16;
    final double titleFontSize = screenWidth < 400 ? 16 : screenWidth < 600 ? 20 : 24;
    final double maxContentWidth = screenWidth < 1200 ? screenWidth : 1200;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: screenWidth < 400 ? 12 : 20,
        horizontal: screenWidth < 400 ? 12 : 16,
      ),
      color: Colors.blue.shade700, // خلفية أزرق داكن
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'بايات للتموين',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white, // عنوان أبيض
              ),
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                'المنطقة الصناعية رقم 2، بئر مسعود، 30500 حاسي مسعود، الجزائر',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white70, // نص ثانوي أبيض فاتح
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                '© 2025 بايات للتموين. جميع الحقوق محفوظة.',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white70,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              alignment: WrapAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'سياسة الخصوصية',
                      style: TextStyle(
                        fontSize: fontSize - 2,
                        color: Colors.white70,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'شروط الاستخدام',
                      style: TextStyle(
                        fontSize: fontSize - 2,
                        color: Colors.white70,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'اتصل بنا',
                      style: TextStyle(
                        fontSize: fontSize - 2,
                        color: Colors.white70,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
