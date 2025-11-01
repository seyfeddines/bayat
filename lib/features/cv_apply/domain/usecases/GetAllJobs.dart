


import 'package:bayat/core/errors/failure.dart';
import 'package:bayat/features/cv_apply/data/repositories/cv_applyrepostries_impl.dart';
import 'package:bayat/features/cv_apply/domain/entities/jobsentity.dart';
import 'package:bayat/features/cv_apply/domain/repositories/CV_apply_repostry.dart';
import 'package:dartz/dartz.dart';

class GetJobsUseCase{
  final CvApplyRepostriet repostriet;
  GetJobsUseCase( {required this.repostriet});

  Future<Either<Failure, List<JobEntity>>> call({required int id}){
    return repostriet.GetjobsCategory(id);
  }
}