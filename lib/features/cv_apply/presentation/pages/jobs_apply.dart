import 'package:bayat/features/cv_apply/presentation/bloc/jobs_apply_cubit/jobs_apply_state.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/category%20section.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/drawer.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/footer.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/jobsection.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/navbar.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/jobs_apply_cubit/jobs_apply_cubit.dart';

class JobsAply extends StatelessWidget {
  final int selectedCategory;

  JobsAply({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize =
    screenWidth < 600 ? 18 : screenWidth < 1200 ? 22 : 24;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700, // ثيم أزرق
        elevation: 0,
        title: Text(
          'بايات للتموين - $selectedCategory',
          style: TextStyle(
            color: Colors.white, // النص أبيض
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                BayatJobSection(
                  categoryId: selectedCategory,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: const BayatFooters(), // سيستخدم الثيم الأزرق الجديد
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue.shade50, // خلفية فاتحة للصفحة
    );
  }
}
