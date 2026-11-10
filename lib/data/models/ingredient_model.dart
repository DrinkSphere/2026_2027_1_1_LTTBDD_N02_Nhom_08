import 'package:flutter/widgets.dart';

class IngredientModel {
  final String id;
  final String name;
  final String? nameEn;
  final String unit; // ml, g, muỗng, quả, lá...
  final String? description;
  final String? descriptionVi;
  final String? descriptionEn;

  IngredientModel({
    required this.id,
    required this.name,
    this.nameEn,
    required this.unit,
    this.description,
    this.descriptionVi,
    this.descriptionEn,
  });

  String getName(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en' && nameEn != null
      ? nameEn!
      : name;

  String? getDescription(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en' &&
          descriptionEn != null
      ? descriptionEn
      : descriptionVi ?? description;

  String getUnit(BuildContext context) {
    if (Localizations.localeOf(context).languageCode != 'en') {
      return unit;
    }
    switch (unit.toLowerCase()) {
      case 'quả':
        return 'piece(s)';
      case 'lá':
        return 'leaf/leaves';
      case 'lon':
        return 'can(s)';
      case 'miếng':
        return 'slice(s)';
      case 'cây':
        return 'stalk(s)';
      default:
        return unit;
    }
  }

  IngredientModel copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? unit,
    String? description,
    String? descriptionVi,
    String? descriptionEn,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      unit: unit ?? this.unit,
      description: description ?? this.description,
      descriptionVi: descriptionVi ?? this.descriptionVi,
      descriptionEn: descriptionEn ?? this.descriptionEn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'unit': unit,
      'description': description,
      'descriptionVi': descriptionVi,
      'descriptionEn': descriptionEn,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['nameEn'] as String?,
      unit: json['unit'] as String? ?? 'g',
      description: json['description'] as String?,
      descriptionVi: json['descriptionVi'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
    );
  }
}
