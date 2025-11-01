


import 'package:bayat/core/Netwirking/checkinternet.dart';
import 'package:bayat/core/errors/expentions.dart';
import 'package:bayat/core/errors/failure.dart';
import 'package:bayat/features/cv_apply/data/datasources/cv_apply_remoute_data_source.dart';
import 'package:bayat/features/cv_apply/data/models/CategoryModel.dart';
import 'package:bayat/features/cv_apply/data/models/jobapplymodel.dart';
import 'package:bayat/features/cv_apply/domain/entities/CategoryEntity.dart';
import 'package:bayat/features/cv_apply/domain/entities/jobsentity.dart';
import 'package:bayat/features/cv_apply/domain/repositories/CV_apply_repostry.dart';
import 'package:dartz/dartz.dart';

class CvaplyRepostriesImpl extends CvApplyRepostriet{
  final CvapplyRemoteDataSpirce remoteDataSpirce;
  CvaplyRepostriesImpl({required this.remoteDataSpirce});

  @override
  Future<Either<Failure, List<CategoryEntity>>> GetAllCategory() async {
    if (await NetworkUtil.hasInternet()) {
      try {
        final response = await remoteDataSpirce.apigetCategory();

        // response هنا هو List<CategoryModel>
        final entities = response
            .map((model) => CategoryEntity(
              id: model.id,
          title: model.title,
          description: model.description,
        ))
            .toList();

        return Right(entities);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }


  @override
  Future<Either<Failure, List<JobEntity>>> GetjobsCategory(int id) async{
    if (await NetworkUtil.hasInternet()) {
    try {
    final response = await remoteDataSpirce.apigetJobs(id: id);

    // response هنا هو List<JobsModel>
    final entities = response
        .map((model) => JobEntity(
      categorie: model.categorie,
      condition: model.condition,
        id: model.id,
    title: model.title,
    description: model.description,
    )).toList();

    return Right(entities);
    } on ServerException catch (e) {
    return Left(Failure(errMessage: e.errorModel.errorMessage));
    }
    } else {
    return Left(Failure(errMessage: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> sendaply({required JobApplicationModel application}) async {
    if (await NetworkUtil.hasInternet()) {
      try {
        final response = await remoteDataSpirce.sendapplyjob(application: application);
        return Right(response);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }




}