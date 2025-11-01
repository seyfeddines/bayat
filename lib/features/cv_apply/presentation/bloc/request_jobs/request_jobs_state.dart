import 'package:flutter/cupertino.dart';

/// الحالة العامة للتقديم على الوظائف
sealed class JobApplicationState {}

/// البداية
class JobApplicationInitial extends JobApplicationState {}

/// جاري تحميل البيانات
class JobApplicationLoading extends JobApplicationState {}

/// الحالة لما تكون البيانات جاهزة
class JobApplicationLoaded extends JobApplicationState {
  final int currentStep;
  final Map<String, TextEditingController> controllers;
  final String? cvFileName;
  final bool isSubmitting;
  final List<String> wilayas;
  final int job;

  JobApplicationLoaded({
    this.currentStep = 0,
    required this.controllers,
    this.cvFileName,
    this.isSubmitting = false,
    required this.wilayas,
    required this.job,
  });

  JobApplicationLoaded copyWith({
    int? currentStep,
    Map<String, TextEditingController>? controllers,
    String? cvFileName,
    bool? isSubmitting,
    List<String>? wilayas,
    int? job,
  }) {
    return JobApplicationLoaded(
      currentStep: currentStep ?? this.currentStep,
      controllers: controllers ?? this.controllers,
      cvFileName: cvFileName ?? this.cvFileName,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      wilayas: wilayas ?? this.wilayas,
      job: job ?? this.job,
    );
  }

  double calculateProgress() {
    double progress = (currentStep + 1) / 4 * 100;
    if (currentStep == 3 && cvFileName == null) {
      progress = 75.0;
    }
    return progress;
  }

  bool isFormValid(int step, List<GlobalKey<FormState>> formKeys) {
    return formKeys[step].currentState?.validate() ?? false;
  }

  bool canSubmit() {
    return currentStep == 3 && cvFileName != null;
  }
}

/// جاري إرسال الطلب
class JobApplicationSubmitting extends JobApplicationState {}

/// تم الإرسال بنجاح
class JobApplicationSuccess extends JobApplicationState {}

/// فشل في الإرسال
class JobApplicationFailure extends JobApplicationState {
  final String message;
  JobApplicationFailure(this.message);
}

/// لا يوجد إنترنت
class JobApplicationNoInternet extends JobApplicationState {}
