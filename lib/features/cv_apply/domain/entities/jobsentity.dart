class JobEntity {
  final int id;
  final String title;
  final String description;
  final String condition;
  final int categorie;

  const JobEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.condition,
    required this.categorie,
  });

  // Factory from JSON
  factory JobEntity.fromJson(Map<String, dynamic> json) {
    return JobEntity(
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
