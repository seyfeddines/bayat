import 'package:bayat/features/cv_apply/presentation/bloc/cv_aply_cubit/cv_apply_bloc.dart';
import 'package:bayat/features/cv_apply/presentation/pages/jobs_apply.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/category%20section.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/drawer.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/footer.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CvApply extends StatelessWidget {
  const CvApply({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize =
    screenWidth < 600 ? 18 : screenWidth < 1200 ? 22 : 24;
    final bool isMobile = screenWidth < 600;

    return BlocProvider(
      create: (context) => CvApplyCubit()..loadAllCategory(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE3F2FD), // خلفية أزرق فاتح
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
          title: Text(
            'بايات للتموين - الوظائف',
            style: TextStyle(
              color: Colors.white,
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
              child: BayatCategorySection(), // الآن الكروت بالثيم الأزرق الجديد
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BayatFooters(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
