import 'package:flutter/material.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/request_jobs/request_jobs_state.dart';

Widget buildStepIndicator(JobApplicationLoaded state) {
  final steps = ["معلومات شخصية", "العنوان", "الرقم الوسيط"];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: steps.asMap().entries.map((entry) {
      int index = entry.key;
      String title = entry.value;
      bool isActive = index <= state.currentStep;

      return Column(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: isActive ? Colors.blue.shade700 : Colors.grey.shade400,
            child: Text(
              "${index + 1}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.blue.shade700 : Colors.grey.shade400,
            ),
          ),
        ],
      );
    }).toList(),
  );
}
