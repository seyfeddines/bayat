import 'package:bayat/features/cv_apply/presentation/bloc/jobs_apply_cubit/jobs_apply_cubit.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/jobs_apply_cubit/jobs_apply_state.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/jobcard.dart';
import 'package:bayat/features/cv_apply/presentation/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BayatJobSection extends StatelessWidget {
  final int categoryId; // نجيب الوظائف حسب الفئة
  final TextEditingController searchController = TextEditingController();

  BayatJobSection({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double spacing = screenWidth < 600 ? 8 : screenWidth < 1200 ? 16 : 24;
    final double sectionPadding = screenWidth < 600 ? 8 : 20;
    final double titleFontSize = screenWidth < 600 ? 28 : 36;

    return BlocProvider(
      create: (context) => JobsApplyCubit()..loadAllJobs(categoryId),
      child: BlocBuilder<JobsApplyCubit, JobsAplyState>(
        builder: (context, state) {
          Widget content;

          if (state is JobsAplyLoading) {
            content = const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (state is JobsAplyNoInternet) {
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
          } else if (state is JobsAplyFailure) {
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
          } else if (state is JobsAplyLoaded) {
            final jobs = state.jobs;

            content = Wrap(
              spacing: spacing,
              runSpacing: spacing,
              alignment: WrapAlignment.center,
              children: jobs.isEmpty
                  ? [
                const Text(
                  'لم يتم العثور على وظائف مطابقة لبحثك.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textDirection: TextDirection.rtl,
                ),
              ]
                  : jobs
                  .map(
                    (job) => BayatJobCard(
                  title: job.title,
                  id: job.id,
                  description: job.description,
                  icon: Icons.work,
                      condition: job.condition,

                ),
              )
                  .toList(),
            );
          } else {
            content = const SizedBox();
          }

          return Container(
            color: Colors.blue.shade50, // خلفية فاتحة للصفحة
            padding: EdgeInsets.symmetric(horizontal: sectionPadding, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BayatSearchBar(
                  controller: searchController,
                  onChanged: (value) {
                    context.read<JobsApplyCubit>().filterJobs(value);
                  },

                ),
                const SizedBox(height: 16),
                Text(
                  'الوظائف المتاحة',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 12),

                SizedBox(height: sectionPadding * 2),
                content,
              ],
            ),
          );
        },
      ),
    );
  }
}
