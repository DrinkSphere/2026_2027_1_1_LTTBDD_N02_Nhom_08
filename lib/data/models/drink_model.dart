import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

class DrinkIngredientItem {
  final String ingredientId;
  final String ingredientName;
  final String? ingredientNameEn;
  final double amount;
  final String unit;

  DrinkIngredientItem({
    required this.ingredientId,
    required this.ingredientName,
    this.ingredientNameEn,
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'ingredientName': ingredientName,
      'ingredientNameEn': ingredientNameEn,
      'amount': amount,
      'unit': unit,
    };
  }

  String getName(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en' &&
          ingredientNameEn != null
      ? ingredientNameEn!
      : ingredientName;

  String getUnit(BuildContext context) {
    if (unit == 'quả') {
      return Localizations.localeOf(context).languageCode == 'en'
          ? 'piece(s)'
          : unit;
    }
    return unit;
  }

  factory DrinkIngredientItem.fromJson(Map<String, dynamic> json) {
    return DrinkIngredientItem(
      ingredientId: json['ingredientId'] as String? ?? '',
      ingredientName: json['ingredientName'] as String? ?? '',
      ingredientNameEn: json['ingredientNameEn'] as String?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String? ?? '',
    );
  }
}

class DrinkModel {
  final String id;
  final String name;
  final String? nameEn;
  final String categoryId;
  final String description;
  final String? descriptionEn;
  final String imageUrl;
  final List<DrinkIngredientItem> ingredients;
  final List<String> steps;
  final List<String>? stepsEn;
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
    this.nameEn,
    required this.categoryId,
    required this.description,
    this.descriptionEn,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    this.stepsEn,
    this.cookingTimeMinutes = 10,
    this.difficulty = 'Dễ',
    this.rating = 5.0,
    required this.creatorId,
    this.creatorName = 'Admin',
    this.isApproved = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool _isEnglish(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en';

  String getName(BuildContext context) =>
      _isEnglish(context) && nameEn != null ? nameEn! : name;

  String getDescription(BuildContext context) =>
      _isEnglish(context) && descriptionEn != null
      ? descriptionEn!
      : description;

  List<String> getSteps(BuildContext context) {
    return _isEnglish(context) && stepsEn != null ? stepsEn! : steps;
  }

  String getDifficulty(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (difficulty) {
      case 'Dễ':
        return l10n.easy;
      case 'Trung bình':
        return l10n.medium;
      case 'Khó':
        return l10n.hard;
      default:
        return difficulty;
    }
  }

  DrinkModel copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? categoryId,
    String? description,
    String? descriptionEn,
    String? imageUrl,
    List<DrinkIngredientItem>? ingredients,
    List<String>? steps,
    List<String>? stepsEn,
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
      nameEn: nameEn ?? this.nameEn,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      stepsEn: stepsEn ?? this.stepsEn,
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
      'nameEn': nameEn,
      'categoryId': categoryId,
      'description': description,
      'descriptionEn': descriptionEn,
      'imageUrl': imageUrl,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'steps': steps,
      'stepsEn': stepsEn,
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
      nameEn: json['nameEn'] as String?,
      categoryId: json['categoryId'] as String? ?? '',
      description: json['description'] as String? ?? '',
      descriptionEn: json['descriptionEn'] as String?,
      imageUrl: json['imageUrl'] as String? ?? '',
      ingredients:
          (json['ingredients'] as List<dynamic>?)
              ?.map(
                (e) => DrinkIngredientItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      stepsEn: (json['stepsEn'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
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
