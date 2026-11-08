class DrinkIngredientItem {
  final String ingredientId;
  final String ingredientName;
  final double amount;
  final String unit;

  DrinkIngredientItem({
    required this.ingredientId,
    required this.ingredientName,
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'ingredientName': ingredientName,
      'amount': amount,
      'unit': unit,
    };
  }

  factory DrinkIngredientItem.fromJson(Map<String, dynamic> json) {
    return DrinkIngredientItem(
      ingredientId: json['ingredientId'] as String? ?? '',
      ingredientName: json['ingredientName'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String? ?? '',
    );
  }
}

class DrinkModel {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final String imageUrl;
  final List<DrinkIngredientItem> ingredients;
  final List<String> steps;
  final int cookingTimeMinutes;
  final String difficulty; // 'Dễ', 'Trung bình', 'Khó'
  final double rating;
  final String creatorId;
  final String creatorName;
  final bool isApproved;
  final DateTime createdAt;

  DrinkModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    this.cookingTimeMinutes = 10,
    this.difficulty = 'Dễ',
    this.rating = 5.0,
    required this.creatorId,
    this.creatorName = 'Admin',
    this.isApproved = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  DrinkModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? description,
    String? imageUrl,
    List<DrinkIngredientItem>? ingredients,
    List<String>? steps,
    int? cookingTimeMinutes,
    String? difficulty,
    double? rating,
    String? creatorId,
    String? creatorName,
    bool? isApproved,
    DateTime? createdAt,
  }) {
    return DrinkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      cookingTimeMinutes: cookingTimeMinutes ?? this.cookingTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      rating: rating ?? this.rating,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'steps': steps,
      'cookingTimeMinutes': cookingTimeMinutes,
      'difficulty': difficulty,
      'rating': rating,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'isApproved': isApproved,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => DrinkIngredientItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      steps: (json['steps'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      cookingTimeMinutes: json['cookingTimeMinutes'] as int? ?? 10,
      difficulty: json['difficulty'] as String? ?? 'Dễ',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      creatorId: json['creatorId'] as String? ?? '',
      creatorName: json['creatorName'] as String? ?? '',
      isApproved: json['isApproved'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
