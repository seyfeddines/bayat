import 'package:bayat/features/homepage/presentation/widgets/aboutsection.dart';
import 'package:bayat/features/homepage/presentation/widgets/build_portfolio.dart';
import 'package:bayat/features/homepage/presentation/widgets/build_state.dart';
import 'package:bayat/features/homepage/presentation/widgets/cta_action.dart';
import 'package:bayat/features/homepage/presentation/widgets/footer.dart';
import 'package:bayat/features/homepage/presentation/widgets/hersction.dart';
import 'package:bayat/features/homepage/presentation/widgets/navbotton.dart';
import 'package:bayat/features/homepage/presentation/widgets/timelinesection.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show kIsWeb;

class HomepagePresentationWeb extends StatelessWidget {
  const HomepagePresentationWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'InnovateTech',
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          buildNavButton(context, 'Home'),
          buildNavButton(context, 'About'),
          buildNavButton(context, 'Portfolio'),
          buildNavButton(context, 'Contact'),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HeroSectionBayat(),
            const SizedBox(height: 80),
            AboutSection(),
            const SizedBox(height: 80),
            TimelineSection(),
            const SizedBox(height: 80),
            buildPortfolioSection(context),
            const SizedBox(height: 60),
            buildStatsSection(),
            const SizedBox(height: 80),
            buildCTASection(),
            buildFooter(),
          ],
        ),
      ),
    );
  }

















}