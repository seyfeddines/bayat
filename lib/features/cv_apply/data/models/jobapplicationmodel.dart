
import 'package:bayat/features/cv_apply/domain/entities/apply_enttity.dart';


class ApplyModel extends ApplyEntity {
  ApplyModel({
    required String fullName,
    required DateTime dateOfBirth,
    required String email,
    required String phone,
    required String wilaya,
    required String baladiya,
    required String address,
    required String intermediaryNumber,
    required int job,
  }) : super(
    fullName: fullName,
    dateOfBirth: dateOfBirth,
    email: email,
    phone: phone,
    wilaya: wilaya,
    baladiya: baladiya,
    address: address,
    intermediaryNumber: intermediaryNumber,
    job: job,
  );

  factory ApplyModel.fromJson(Map<String, dynamic> json) {
    return ApplyModel(
      fullName: json['full_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      email: json['email'],
      phone: json['phone'],
      wilaya: json['wilaya'],
      baladiya: json['baladiya'],
      address: json['address'],
      intermediaryNumber: json['intermediary_number'],
      job: json['job'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "date_of_birth": dateOfBirth.toIso8601String().split('T')[0],
      "email": email,
      "phone": phone,
      "wilaya": wilaya,
      "baladiya": baladiya,
      "address": address,
      "intermediary_number": intermediaryNumber,
      "job": job,
    };
  }
}
