


import 'package:bayat/core/errors/failure.dart';
import 'package:bayat/features/cv_apply/data/models/CategoryModel.dart';
import 'package:bayat/features/cv_apply/data/models/jobapplymodel.dart';
import 'package:bayat/features/cv_apply/domain/entities/CategoryEntity.dart';
import 'package:bayat/features/cv_apply/domain/entities/jobsentity.dart';
import 'package:dartz/dartz.dart';

abstract class CvApplyRepostriet{

  Future<Either<Failure, List<CategoryEntity>>> GetAllCategory();
  Future<Either<Failure, bool>> sendaply({required JobApplicationModel application});
  Future<Either<Failure, List<JobEntity>>> GetjobsCategory(int id);

}