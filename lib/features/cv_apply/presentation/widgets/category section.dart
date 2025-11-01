import 'package:bayat/core/Theming/Colors/colors.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/cv_aply_cubit/cv_apply_bloc.dart';
import 'package:bayat/features/cv_apply/presentation/pages/jobs_apply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/cv_aply_cubit/cv_apply_state.dart';
import '../../domain/entities/CategoryEntity.dart';

class BayatCategorySection extends StatelessWidget {
  const BayatCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CvApplyCubit()..loadAllCategory(),
      child: BlocBuilder<CvApplyCubit, CvApplyState>(
        builder: (context, state) {
          Widget content;

          if (state is CvApplyLoading) {
            content = const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (state is CvApplyNoInternet) {
            content = const Center(
              child: Text(
                "🚫 لا يوجد اتصال بالإنترنت",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            );
          } else if (state is CvApplyFailure) {
            content = Center(
              child: Text(
                "⚠️ خطأ: ${state.message}",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            );
          } else if (state is CvApplyLoaded) {
            final categories = state.categories;
            content = LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _CategoryCard(
                      description: category.description,
                      title: category.title,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                JobsAply(selectedCategory: category.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          } else {
            content = const SizedBox();
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFFE3F2FD), // خلفية زرقاء فاتحة
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "اختر الفئة المناسبة لطلبك من القائمة التالية. "
                        "تمثل هذه الفئات الوظائف المتاحة في منصتنا، "
                        "ويمكنك الانضمام إلى فريقنا كصاحب عمل من خلال اختيار الفئة التي تناسبك. "
                        "نحن نرحب بالمبدعين للانضمام إلينا والمساهمة في صنع مستقبل مهني أفضل.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "اختر الفئة",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "اختر الفئة المناسبة لطلبك من القائمة التالية.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 20),
                  content,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final IconData? icon;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth < 600 ? 130.0 : 160.0;
    final cardHeight = screenWidth < 600 ? 120.0 : 140.0;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade400.withOpacity(0.9),
                Colors.blue.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              if (icon != null) const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


