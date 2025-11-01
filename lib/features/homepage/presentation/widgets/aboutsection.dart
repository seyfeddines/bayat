import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    final double titleSize = isDesktop ? 40 : (isTablet ? 34 : 28);
    final double subTitleSize = isDesktop ? 32 : (isTablet ? 28 : 24);
    final double textSize = isDesktop ? 18 : 16;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Who We Are',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            width: 120,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 40),

          // Layout based on screen width
          isDesktop
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Expanded(
                flex: 1,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(-50 + 50 * value, 0),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),

              // Text section
              Expanded(
                flex: 1,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(50 - 50 * value, 0),
                        child: child,
                      ),
                    );
                  },
                  child: _buildAboutText(
                    subTitleSize,
                    textSize,
                    TextAlign.start,
                  ),
                ),
              ),
            ],
          )
              : Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildAboutText(
                subTitleSize,
                textSize,
                TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutText(double subTitleSize, double textSize, TextAlign align) {
    return Column(
      crossAxisAlignment:
      align == TextAlign.start ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'Our Journey',
          style: TextStyle(
            fontSize: subTitleSize,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
          textAlign: align,
        ),
        const SizedBox(height: 24),
        Text(
          'Founded in 2010, InnovateTech Solutions began as a small team of passionate developers with a vision to revolutionize the digital landscape. Today, we are a leading technology company specializing in web and mobile applications, AI solutions, and digital transformation services.',
          style: TextStyle(
            fontSize: textSize,
            color: Colors.grey.shade700,
            height: 1.8,
          ),
          textAlign: align,
        ),
        const SizedBox(height: 24),
        Text(
          'Our mission is to empower businesses with cutting-edge technology solutions that drive growth, efficiency, and innovation. We believe in building lasting partnerships and delivering exceptional value to our clients.',
          style: TextStyle(
            fontSize: textSize,
            color: Colors.grey.shade700,
            height: 1.8,
          ),
          textAlign: align,
        ),
      ],
    );
  }
}
