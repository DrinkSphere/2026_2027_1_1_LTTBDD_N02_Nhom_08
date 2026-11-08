class IngredientModel {
  final String id;
  final String name;
  final String unit; // ml, g, muỗng, quả, lá...
  final String? description;

  IngredientModel({
    required this.id,
    required this.name,
    required this.unit,
    this.description,
  });

  IngredientModel copyWith({
    String? id,
    String? name,
    String? unit,
    String? description,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'description': description,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String? ?? 'g',
      description: json['description'] as String?,
    );
  }
}

