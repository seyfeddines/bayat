import 'package:bayat/features/cv_apply/domain/entities/CategoryEntity.dart';

class CategoryModel extends CategoryEntity{


  CategoryModel( {
    required super.id,
    required super.title,
    required super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id:  json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
