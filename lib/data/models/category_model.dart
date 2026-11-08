class CategoryModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;

  CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
    );
  }
}

