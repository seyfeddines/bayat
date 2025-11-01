class CategoryEntity {
  final String title;
  final String description;
  final int id;

  CategoryEntity( {
    required this.id,
    required this.title,
   required this.description,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
       id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
