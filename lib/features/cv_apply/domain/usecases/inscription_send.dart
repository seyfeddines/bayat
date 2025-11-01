


import 'package:bayat/core/errors/failure.dart';
import 'package:bayat/features/cv_apply/data/models/jobapplymodel.dart';
import 'package:bayat/features/cv_apply/domain/repositories/CV_apply_repostry.dart';
import 'package:dartz/dartz.dart';

class InscriptionSendCase{
  final CvApplyRepostriet repostriet;
  InscriptionSendCase(this.repostriet);
  Future<Either<Failure, bool>> call({required JobApplicationModel application}){
    return repostriet.sendaply(application: application);
  }
}