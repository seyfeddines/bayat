import 'package:bayat/features/cv_apply/domain/entities/jobsentity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required int id,
    required String title,
    required String description,
    required String condition,
    required int categorie,
  }) : super(
    id: id,
    title: title,
    description: description,
    condition: condition,
    categorie: categorie,
  );

  // Factory from JSON
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      condition: json['condition'] as String,
      categorie: json['categorie'] as int,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "condition": condition,
      "categorie": categorie,
    };
  }
}
