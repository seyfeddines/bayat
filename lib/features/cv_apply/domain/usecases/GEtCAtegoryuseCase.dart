



import 'package:bayat/core/errors/failure.dart';
import 'package:bayat/features/cv_apply/domain/entities/CategoryEntity.dart';
import 'package:bayat/features/cv_apply/domain/repositories/CV_apply_repostry.dart';
import 'package:dartz/dartz.dart';

class GetCategoryCase {
  final CvApplyRepostriet repostriet;
  GetCategoryCase(this.repostriet);
  Future<Either<Failure, List<CategoryEntity>>> call(){
    return repostriet.GetAllCategory();
  }
}