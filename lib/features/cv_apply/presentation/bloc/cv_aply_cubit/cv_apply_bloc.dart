
import 'package:bayat/features/cv_apply/data/datasources/cv_apply_remoute_data_source.dart';
import 'package:bayat/features/cv_apply/data/repositories/cv_applyrepostries_impl.dart';
import 'package:bayat/features/cv_apply/domain/entities/CategoryEntity.dart';
import 'package:bayat/features/cv_apply/domain/repositories/CV_apply_repostry.dart';
import 'package:bayat/features/cv_apply/domain/usecases/GEtCAtegoryuseCase.dart';
import 'package:bayat/features/cv_apply/presentation/bloc/cv_aply_cubit/cv_apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' show kIsWeb;
import 'package:dartz/dartz.dart';
class CvApplyCubit extends Cubit<CvApplyState> {
  final List<Map<String, dynamic>> _jobCategories = [
    {
      'title': 'التموين الجماعي للشركات',
      'description': 'إعداد وتقديم الوجبات للشركات على نطاق واسع.',
      'icon': Icons.restaurant,
    },
    {
      'title': 'التموين الجوي',
      'description': 'خدمات التموين لشركات الطيران.',
      'icon': Icons.flight,
    },
    {
      'title': 'إدارة قواعد الحياة',
      'description': 'إدارة شاملة لمرافق قواعد الحياة للأفراد.',
      'icon': Icons.business,
    },
    {
      'title': 'التخزين البارد (+/-)',
      'description': 'تخزين وإدارة المنتجات الغذائية في درجات حرارة مضبوطة.',
      'icon': Icons.ac_unit,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'توريد المواد الغذائية',
      'description': 'توفير المنتجات الغذائية للعمليات.',
      'icon': Icons.local_grocery_store,
    },
    {
      'title': 'صيانة المساحات الخضراء',
      'description': 'صيانة وتجميل المساحات الخارجية.',
      'icon': Icons.local_florist,
    },
    {
      'title': 'معالجة النفايات',
      'description': 'إدارة ومعالجة النفايات للحفاظ على بيئة نظيفة.',
      'icon': Icons.delete,
    },
  ];
  final List<CategoryEntity> categories =[];

  CvApplyCubit() : super(CvApplyInitial());

  Future<void> loadAllCategory() async {
    // أول حاجة: نغيّر الحالة إلى Loading
    emit(CvApplyLoading());
    print("get data =================");
    final categoryOrFailure = await GetCategoryCase(
      CvaplyRepostriesImpl(
        remoteDataSpirce: CvapplyRemoteDataSpirce(),
      ),
    ).call();
    print("get data =================");
print(categoryOrFailure);
    categoryOrFailure.fold(
          (failure) {
            print(failure.errMessage);
        // في حالة الفشل
        if (failure.errMessage == "No Internt Conection") {
          emit(const CvApplyNoInternet());
        } else {
          emit(CvApplyFailure(failure.errMessage));
        }
      },
          (categoriesApi) {
        // لو النجاح
        emit(CvApplyLoaded(categoriesApi));
      },
    );
  }


}