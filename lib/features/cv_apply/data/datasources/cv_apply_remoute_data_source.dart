


import 'dart:convert';

import 'package:bayat/core/Netwirking/api%20constant.dart';
import 'package:bayat/core/Netwirking/api_consumer.dart';
import 'package:bayat/core/Netwirking/dio_consumer.dart';
import 'package:bayat/features/cv_apply/data/models/CategoryModel.dart';
import 'package:bayat/features/cv_apply/data/models/JobsModel.dart';
import 'package:bayat/features/cv_apply/data/models/jobapplymodel.dart';
import 'package:dartz/dartz.dart';

class CvapplyRemoteDataSpirce {
  static final CvapplyRemoteDataSpirce _instance =
  CvapplyRemoteDataSpirce._internal(DioConsumer());

  final ApiConsumer api;

  CvapplyRemoteDataSpirce._internal(this.api);

  factory CvapplyRemoteDataSpirce() {
    return _instance;
  }
  Future<List<CategoryModel>> apigetCategory() async {
    final response = await api.get(
      '${ApiConstant.allCategory}',
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(response);
    print("===========================================================================");

    print(response);
    print("===========================================================================");

    final List<dynamic> data = response["results"];

    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
  Future<List<JobModel>> apigetJobs({required int id}) async {
    final response = await api.get(
      '${ApiConstant.jobs}/${id}',
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(response);
    print("===========================================================================");

    print(response);
    print("===========================================================================");

    final List<dynamic> data = response["results"];

    return data.map((json) => JobModel.fromJson(json)).toList();
  }
  Future<bool> sendapplyjob({required JobApplicationModel application}) async {
    try {
      final response = await api.post(
        ApiConstant.apply, // ex: "/inscriptions/create/"
        headers: {
          "Content-Type": "application/json",
        },
        data: application.toJson(), // نرسل JSON من الموديل
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");
      print("===========================================================================");

      return true;
    } catch (e) {
      print("Error while applying job: $e");
      return false;
    }
  }




}