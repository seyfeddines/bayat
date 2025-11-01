import 'dart:io';
import 'package:bayat/features/cv_apply/data/datasources/cv_apply_remoute_data_source.dart';
import 'package:bayat/features/cv_apply/data/models/jobapplymodel.dart';
import 'package:bayat/features/cv_apply/data/repositories/cv_applyrepostries_impl.dart';
import 'package:bayat/features/cv_apply/domain/entities/apply_enttity.dart';
import 'package:bayat/features/cv_apply/domain/usecases/inscription_send.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/request_jobs/request_jobs_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobApplicationCubit extends Cubit<JobApplicationState> {
  JobApplicationCubit(int jobId)
      : super(JobApplicationLoaded(
    controllers: {
      'full_name': TextEditingController(),
      'date_of_birth': TextEditingController(),
      'email': TextEditingController(),
      'phone': TextEditingController(),
      'wilaya': TextEditingController(),
      'baladiya': TextEditingController(),
      'address': TextEditingController(),
      'intermediary_number': TextEditingController(),
    },
    job: jobId,
    wilayas: const [
      'Adrar',
      'Chlef',
      'Laghouat',
      'Oum El Bouaghi',
      'Batna',
      'Béjaïa',
      'Biskra',
      'Béchar',
      'Blida',
      'Bouira',
      'Tamanrasset',
      'Tébessa',
      'Tlemcen',
      'Tiaret',
      'Tizi Ouzou',
      'Alger',
      'Djelfa',
      'Jijel',
      'Sétif',
      'Saïda',
      'Skikda',
      'Sidi Bel Abbès',
      'Annaba',
      'Guelma',
      'Constantine',
      'Médéa',
      'Mostaganem',
      'M’Sila',
      'Mascara',
      'Ouargla',
      'Oran',
      'El Bayadh',
      'Illizi',
      'Bordj Bou Arréridj',
      'Boumerdès',
      'El Tarf',
      'Tindouf',
      'Tissemsilt',
      'El Oued',
      'Khenchela',
      'Souk Ahras',
      'Tipaza',
      'Mila',
      'Aïn Defla',
      'Naâma',
      'Aïn Témouchent',
      'Ghardaïa',
      'Relizane',
      'Timimoun',
      'Bordj Badji Mokhtar',
      'Ouled Djellal',
      'Béni Abbès',
      'In Salah',
      'In Guezzam',
      'Touggourt',
      'Djanet',
      'El M’Ghair',
      'El Meniaa'
    ],
  ));

  JobApplicationLoaded get _loadedState => state as JobApplicationLoaded;

  // ✅ Validation methods
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال $fieldName';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صالح';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال رقم الهاتف';
    if (!RegExp(r'^[0-9]{9,13}$').hasMatch(value)) {
      return 'يرجى إدخال رقم هاتف صالح (9-13 رقم)';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال تاريخ الميلاد';
    try {
      DateTime.parse(value);
    } catch (_) {
      return 'صيغة التاريخ غير صحيحة (yyyy-MM-dd)';
    }
    return null;
  }

  // ✅ Steps logic
  void nextStep(List<GlobalKey<FormState>> formKeys, BuildContext context) {
    if (_loadedState.isFormValid(_loadedState.currentStep, formKeys)) {
      if (_loadedState.currentStep < 2) {
        emit(_loadedState.copyWith(currentStep: _loadedState.currentStep + 1));
      } else {
        _showConfirmationDialog(context);
      }
    }
  }

  void previousStep() {
    if (_loadedState.currentStep > 0) {
      emit(_loadedState.copyWith(currentStep: _loadedState.currentStep - 1));
    }
  }
  Future<void> submitApplication({required JobApplicationModel application}) async {
    emit(JobApplicationLoading());
    print("get data =================");

    final jobsOrFailure = await InscriptionSendCase(
      CvaplyRepostriesImpl(remoteDataSpirce: CvapplyRemoteDataSpirce()),
    ).call(application: application ); // ✅ هنا لازم تمرر ApplyEntity

    jobsOrFailure.fold(
          (failure) {
        if (failure.errMessage == "No Internet Connection") {
          emit(JobApplicationNoInternet());
        } else {
          emit(JobApplicationFailure(failure.errMessage));
        }
      },
          (jobsApi) {
        emit(JobApplicationSuccess()); // ✅ أو ممكن ترجع Data جديدة لو لزم
      },
    );
  }


  // ✅ File Picker
  Future<void> pickCV(BuildContext context) async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );
        if (result != null && result.files.isNotEmpty) {
          emit(_loadedState.copyWith(cvFileName: result.files.single.name));
          _showSnack(context, 'تم تحميل الملف: ${result.files.single.name}');
        }
      } catch (e) {
        _showSnack(context, 'فشل تحميل الملف، حاول مرة أخرى');
      }
    } else {
      _showSnack(context, 'رفع الملفات غير مدعوم على هذا النظام');
    }
  }

  void removeCV() {
    emit(_loadedState.copyWith(cvFileName: null));
  }

  // ✅ Create ApplyEntity instance
  ApplyEntity toEntity() {
    return ApplyEntity(
      fullName: _loadedState.controllers['full_name']!.text,
      dateOfBirth: DateTime.parse(_loadedState.controllers['date_of_birth']!.text),
      email: _loadedState.controllers['email']!.text,
      phone: _loadedState.controllers['phone']!.text,
      wilaya: _loadedState.controllers['wilaya']!.text,
      baladiya: _loadedState.controllers['baladiya']!.text,
      address: _loadedState.controllers['address']!.text,
      intermediaryNumber: _loadedState.controllers['intermediary_number']!.text,
      job: _loadedState.job,
    );
  }



  // ✅ Helpers
  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الإرسال', textDirection: TextDirection.rtl),
        content: const Text('هل أنت متأكد من إرسال طلبك؟',
            textDirection: TextDirection.rtl),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              final application = JobApplicationModel(
                fullName: _loadedState.controllers['full_name']!.text,
                dateOfBirth:
                  _loadedState.controllers['date_of_birth']!.text,
                email: _loadedState.controllers['email']!.text,
                phone: _loadedState.controllers['phone']!.text,
                wilaya: _loadedState.controllers['wilaya']!.text,
                baladiya: _loadedState.controllers['baladiya']!.text,
                address: _loadedState.controllers['address']!.text,
                intermediaryNumber:
                _loadedState.controllers['intermediary_number']!.text,
                job: _loadedState.job,
              );

              await submitApplication(application: application);
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }


  @override
  Future<void> close() {
    _loadedState.controllers.values.forEach((controller) => controller.dispose());
    return super.close();
  }
}
