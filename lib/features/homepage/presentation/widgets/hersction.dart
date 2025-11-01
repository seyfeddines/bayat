import 'package:flutter/material.dart';

class HeroSectionBayat extends StatelessWidget {
  const HeroSectionBayat({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF05B7FF), // لون شعار Bayat الأساسي
            Color(0xFF003F5C), // لون أغمق للتباين
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // شعار الشركة مع أنيميشن
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1),
            duration: const Duration(seconds: 2),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Image.asset(
              "assets/images/bayat_logo.png", // ضع شعار شركتك هنا
              height: isWide ? 140 : 100,
            ),
          ),
          const SizedBox(height: 30),

          // اسم الشركة مع حركة Fade + Slide
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 40 - 40 * value),
                  child: child,
                ),
              );
            },
            child: Text(
              'Bayat Company',
              style: TextStyle(
                fontSize: isWide ? 52 : 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),

          // الوصف مع Fade بسيط
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 3),
            builder: (context, value, child) {
              return Opacity(opacity: value, child: child);
            },
            child: Text(
              'نحو مستقبل رقمي مبتكر منذ 2010',
              style: TextStyle(
                fontSize: isWide ? 26 : 20,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 50),

          // الأزرار
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 15,
            children: [
              _buildAnimatedButton(
                text: "اكتشف قصتنا",
                onPressed: () {},
                background: Colors.white,
                foreground: const Color(0xFF003F5C),
              ),
              _buildAnimatedButton(
                text: "انضم إلينا",
                onPressed: () {},
                background: const Color(0xFF003F5C),
                foreground: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback onPressed,
    required Color background,
    required Color foreground,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(scale: value, child: child);
        },
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            padding:
            const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
