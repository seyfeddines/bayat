import 'dart:io' show Platform;
import 'package:bayat/features/cv_apply/presentation/bloc/request_jobs/jobs_application_cubit.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/request_jobs/request_jobs_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/jobaplicationformview.dart';

// JobApplicationForm
class JobApplicationForm extends StatelessWidget {
  final int jobID;
  final String job;

  const JobApplicationForm({super.key, required this.job, required this.jobID});

  @override
  Widget build(BuildContext context) {
    final formKeys = List.generate(4, (_) => GlobalKey<FormState>());

    return BlocProvider(
      create: (context) => JobApplicationCubit(jobID),
      child: Scaffold(

        body: Container(
          color: Colors.grey.shade50,
          width: double.infinity,
          child: BlocBuilder<JobApplicationCubit, JobApplicationState>(
            builder: (context, state) {
              return JobApplicationFormView(
                job: jobID,
                formKeys: formKeys,
              );
            },
          ),
        ),
      ),
    );
  }
}
